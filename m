From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda: Fix potential race at
	unregistration and unsol events
Date: Mon, 19 Jun 2017 17:56:11 +0200
Message-ID: <20170619155611.25060-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BF470266C24
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 17:56:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Martin Peres <martin.peres@free.fr>
List-Id: alsa-devel@alsa-project.org

When the codec device is unregistered / freed, it may release the
resource while being used in an unsolicited event like the jack
detection work.  This leads to use-after-free.

The fix here is to unregister the device at first, i.e. removing the
codec from the list, then flushing the pending works to assure that
all unsol events are gone.  After this point, we're free from
accessing the codec via unsol events, thus can release the resources
gracefully.

The issue was spotted originally by Intel CI, but it couldn't be
reproduced reliably by its nature.  So let's hope this fix really
addresses the whole issues.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196045
Reported-by: Martin Peres <martin.peres@free.fr>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_bus.c    | 1 +
 sound/hda/hdac_device.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index 0e81ea89a596..714a51721a31 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -212,5 +212,6 @@ void snd_hdac_bus_remove_device(struct hdac_bus *bus,
 	bus->caddr_tbl[codec->addr] = NULL;
 	clear_bit(codec->addr, &bus->codec_powered);
 	bus->num_codecs--;
+	flush_work(&bus->unsol_work);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_remove_device);
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 03c9872c31cf..19deb306facb 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -159,6 +159,7 @@ void snd_hdac_device_unregister(struct hdac_device *codec)
 	if (device_is_registered(&codec->dev)) {
 		hda_widget_sysfs_exit(codec);
 		device_del(&codec->dev);
+		snd_hdac_bus_remove_device(codec->bus, codec);
 	}
 }
 EXPORT_SYMBOL_GPL(snd_hdac_device_unregister);
-- 
2.13.1
