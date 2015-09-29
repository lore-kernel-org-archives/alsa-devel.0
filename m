From: Rick Mann <rmann@latencyzero.com>
Subject: Found bugs in tlv320aic3x.c driver,
	how do I report them?
Date: Tue, 29 Sep 2015 03:38:02 -0700
Message-ID: <B9E728AE-223C-4BA7-961A-ED107AF03407@latencyzero.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id AB812260449
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 12:38:04 +0200 (CEST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id E4306205A8
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 06:38:03 -0400 (EDT)
Received: from [192.168.15.51] (c-50-168-55-93.hsd1.ca.comcast.net
 [50.168.55.93])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6A893C00022
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 06:38:03 -0400 (EDT)
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
List-Id: alsa-devel@alsa-project.org

Hi. I came across some bugs in sound/soc/codecs/tlv320aic3x.c, wherein it writes non-zero values to reserved registers on the tlv320aic3104 (I found it in 4.1.4, but it's still in 4.3-rc3). I have an untested proposed patch. But I don't know anything about how to report it or offer it.

What should I do? Thanks.

For reference:

$ git diff -- sound/soc/codecs/tlv320aic3x.c
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 51c4713..79c0ca0 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1509,14 +1509,24 @@ static int aic3x_init(struct snd_soc_codec *codec)
        snd_soc_write(codec, PGAL_2_LLOPM_VOL, DEFAULT_VOL);
        snd_soc_write(codec, PGAR_2_RLOPM_VOL, DEFAULT_VOL);
 
-       /* Line2 to HP Bypass default volume, disconnect from Output Mixer */
-       snd_soc_write(codec, LINE2L_2_HPLOUT_VOL, DEFAULT_VOL);
-       snd_soc_write(codec, LINE2R_2_HPROUT_VOL, DEFAULT_VOL);
-       snd_soc_write(codec, LINE2L_2_HPLCOM_VOL, DEFAULT_VOL);
-       snd_soc_write(codec, LINE2R_2_HPRCOM_VOL, DEFAULT_VOL);
-       /* Line2 Line Out default volume, disconnect from Output Mixer */
-       snd_soc_write(codec, LINE2L_2_LLOPM_VOL, DEFAULT_VOL);
-       snd_soc_write(codec, LINE2R_2_RLOPM_VOL, DEFAULT_VOL);
+       if (aic3x->model == AIC3X_MODEL_3104) {
+               /* On tlv320aic3014, these registers are reserved and must be written 0 */
+               snd_soc_write(codec, LINE2L_2_HPLOUT_VOL, 0);
+               snd_soc_write(codec, LINE2R_2_HPROUT_VOL, 0);
+               snd_soc_write(codec, LINE2L_2_HPLCOM_VOL, 0);
+               snd_soc_write(codec, LINE2R_2_HPRCOM_VOL, 0);
+               snd_soc_write(codec, LINE2L_2_LLOPM_VOL, 0);
+               snd_soc_write(codec, LINE2R_2_RLOPM_VOL, 0);
+       } else {
+               /* Line2 to HP Bypass default volume, disconnect from Output Mixer */
+               snd_soc_write(codec, LINE2L_2_HPLOUT_VOL, DEFAULT_VOL);
+               snd_soc_write(codec, LINE2R_2_HPROUT_VOL, DEFAULT_VOL);
+               snd_soc_write(codec, LINE2L_2_HPLCOM_VOL, DEFAULT_VOL);
+               snd_soc_write(codec, LINE2R_2_HPRCOM_VOL, DEFAULT_VOL);
+               /* Line2 Line Out default volume, disconnect from Output Mixer */
+               snd_soc_write(codec, LINE2L_2_LLOPM_VOL, DEFAULT_VOL);
+               snd_soc_write(codec, LINE2R_2_RLOPM_VOL, DEFAULT_VOL);
+       }
 
        switch (aic3x->model) {
        case AIC3X_MODEL_3X:


-- 
Rick Mann
rmann@latencyzero.com
