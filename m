From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/5] aoa: fix toonie codec
Date: Tue, 18 Jul 2006 19:28:43 +0200
Message-ID: <15174.1759073504$1153248221@news.gmane.org>
References: <20060718172841.046446000@sipsolutions.net>>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1BCB5242
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 20:43:23 +0200 (MEST)
Content-Disposition: inline; filename=aoa-toonie-fix.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch fixes the toonie codec to be actually usable.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/codecs/snd-aoa-codec-toonie.c	2006-07-18 11:40:32.363476868 +0200
+++ linux-2.6-fetch/sound/aoa/codecs/snd-aoa-codec-toonie.c	2006-07-18 11:52:29.783476868 +0200
@@ -51,6 +51,13 @@ static struct transfer_info toonie_trans
 	{}
 };
 
+static int toonie_usable(struct codec_info_item *cii,
+			 struct transfer_info *ti,
+			 struct transfer_info *out)
+{
+	return 1;
+}
+
 #ifdef CONFIG_PM
 static int toonie_suspend(struct codec_info_item *cii, pm_message_t state)
 {
@@ -69,6 +76,7 @@ static struct codec_info toonie_codec_in
 	.sysclock_factor = 256,
 	.bus_factor = 64,
 	.owner = THIS_MODULE,
+	.usable = toonie_usable,
 #ifdef CONFIG_PM
 	.suspend = toonie_suspend,
 	.resume = toonie_resume,
@@ -79,19 +87,20 @@ static int toonie_init_codec(struct aoa_
 {
 	struct toonie *toonie = codec_to_toonie(codec);
 
+	/* nothing connected? what a joke! */
+	if (toonie->codec.connected != 1)
+		return -ENOTCONN;
+
 	if (aoa_snd_device_new(SNDRV_DEV_LOWLEVEL, toonie, &ops)) {
 		printk(KERN_ERR PFX "failed to create toonie snd device!\n");
 		return -ENODEV;
 	}
 
-	/* nothing connected? what a joke! */
-	if (toonie->codec.connected != 1)
-		return -ENOTCONN;
-
 	if (toonie->codec.soundbus_dev->attach_codec(toonie->codec.soundbus_dev,
 						     aoa_get_card(),
 						     &toonie_codec_info, toonie)) {
 		printk(KERN_ERR PFX "error creating toonie pcm\n");
+		snd_device_free(aoa_get_card(), toonie);
 		return -ENODEV;
 	}
 

--


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
