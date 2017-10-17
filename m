From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 0/2] Add snd_card_disconnect_sync()
	helper
Date: Tue, 17 Oct 2017 23:25:10 +0900
Message-ID: <20171017142510.7959-1-o-takashi@sakamocchi.jp>
References: <87k1zu7g1l.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id E8322266DA4
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 16:25:15 +0200 (CEST)
In-Reply-To: <87k1zu7g1l.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Hi guys,

On Oct 17 2017 09:59, Kuninori Morimoto wrote:>> Some of the issues might be addressed, yes, but I'm skeptical whether
>> it covers all.  The BE needs proper locking and refcounting that is
>> coupled with the FE, I suppose.
> 
> So, this means, your helper patch seems OK,
> but DPCM side needs more hack.

In my opinion, it's better for us to take enough proofs and explanations
when changing core functionalities.


Below patch for snd-dummy is to enable unbind operation to platform_device
for this module. (but it's too rough to apply mainline.) This works without
Iwai-san's two patches.

Let's try:
$ modprobe snd-dummy
$ aplay -D hw:Dummy /dev/null &
$ lsmod | grep dummy
$ echo -n snd_dummy.0 > /sys/bus/platform/drivers/snd_dummy/unbind
$ lsmod | grep dummy
$ cat /proc/asound/cards
$ modprobe -r snd-dummy
$ cat /proc/asound/cards

Actually, we have no addressed issues in these operations. The issue is
only on ALSA SoC part.

But I note that even if unbind works fine to shift state of sound devices
into disconnected, poll(2) call to ALSA control character devices does not
return (e.g. run 'amixer events'). I don't know exactly the cause yet...

======== 8< --------

>From 74bb5c45f0bf36e6487538088c654b88e1efb5b5 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 17 Oct 2017 17:58:47 +0900
Subject: [PATCH] ALSA: dummy: support unbind operation to shift state of sound
 devices to disconnected

---
 sound/drivers/dummy.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index c0939a0164a6..dcdefd2931c7 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -92,6 +92,7 @@ MODULE_PARM_DESC(hrtimer, "Use hrtimer as the timer source.");
 #endif
 
 static struct platform_device *devices[SNDRV_CARDS];
+static struct snd_card *cards[SNDRV_CARDS];
 
 #define MIXER_ADDR_MASTER	0
 #define MIXER_ADDR_LINE		1
@@ -1134,7 +1135,24 @@ static int snd_dummy_probe(struct platform_device *devptr)
 
 static int snd_dummy_remove(struct platform_device *devptr)
 {
-	snd_card_free(platform_get_drvdata(devptr));
+	struct snd_card *card = platform_get_drvdata(devptr);
+	struct snd_device *dev;
+	int i;
+
+	for (i = 0; i < SNDRV_CARDS; ++i) {
+		/* Temporary for module removal. */
+		if (devices[i] == devptr)
+			cards[i] = card;
+	}
+
+	/*
+	 * This shifts state of an instance of sound card into disconnected, but
+	 * don't wait till all of references to instances of sound devices are
+	 * released.
+	 */
+	list_for_each_entry_reverse(dev, &card->devices, list)
+		snd_device_disconnect(card, dev->device_data);
+
 	return 0;
 }
 
@@ -1178,8 +1196,23 @@ static void snd_dummy_unregister_all(void)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(devices); ++i)
-		platform_device_unregister(devices[i]);
+	for (i = 0; i < ARRAY_SIZE(devices); ++i) {
+		struct platform_device *devptr = devices[i];
+		struct snd_card *card = cards[i];
+
+		if (devptr == NULL)
+			continue;
+		if (card) {
+			/*
+			 * This can wait till the final reference to an
+			 * instance of sound card is released.
+			 */
+			snd_card_free(card);
+		}
+
+		platform_device_unregister(devptr);
+	}
+
 	platform_driver_unregister(&snd_dummy_driver);
 	free_fake_buffer();
 }
-- 
2.11.0
