From: Robert Jarzmik <rjarzmik@free.fr>
Subject: [PATCH] Change of cold reset and ac97 register cache
Date: 16 Jan 2008 23:24:56 +0100
Message-ID: <87k5m91k93.fsf@polgara.paysbobval>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id E7F7424464
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 23:24:57 +0100 (CET)
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 52A1D5FE47
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 23:24:57 +0100 (CET)
Received: from polgara (mur31-2-82-243-122-54.fbx.proxad.net [82.243.122.54])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 1687D5FD81
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 23:24:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=

This patch synchronizes wm9713 AC97 register cache and hardware registers 
upon reset.

The actual implementation of the wm9713 codec provides a cache of AC97
registers. After cold reset, the cache and hardware are not in sync. When
using wm9713 logic, oring a GPIO triggers many other GPIOS.

The solution of this patch reads from hardware to cache upon cold reset.
Another one would be to write the cache to hardware upon init. If decided so,
I would gladly change my patch.

--
Robert Jarzmik


--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment; filename=wm9713.diff
Content-Description: Cold reset of wm9713

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 6e3c6af..62c6c02 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1014,6 +1014,9 @@ EXPORT_SYMBOL_GPL(wm9713_dai);
 
 int wm9713_reset(struct snd_soc_codec *codec, int try_warm)
 {
+	int i;
+	u16 *cache = codec->reg_cache;
+
 	if (try_warm && soc_ac97_ops.warm_reset) {
 		soc_ac97_ops.warm_reset(codec->ac97);
 		if (!(ac97_read(codec, 0) & 0x8000))
@@ -1023,6 +1026,14 @@ int wm9713_reset(struct snd_soc_codec *codec, int try_warm)
 	soc_ac97_ops.reset(codec->ac97);
 	if (ac97_read(codec, 0) & 0x8000)
 		return -EIO;
+
+	for (i = 2; i < ARRAY_SIZE(wm9713_reg) << 1; i+=2) {
+		if (i == AC97_POWERDOWN || i == AC97_EXTENDED_MID ||
+		    i == AC97_EXTENDED_MSTATUS || i > 0x66)
+			continue;
+		cache[i>>1] = ac97_read(codec, i);
+	}
+	
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm9713_reset);

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--
