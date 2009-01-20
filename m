From: Brian Rhodes <bgr@acdstar.com>
Subject: ASoC: pxa2xx-i2s
Date: Tue, 20 Jan 2009 08:31:12 -0600
Message-ID: <4975E030.5080905@acdstar.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070706050201050302040705"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from manowar.linespeed.net (linespeed.net [75.146.159.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 3898E103807
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 15:31:18 +0100 (CET)
Received: from [192.168.2.94] (acd [75.146.173.145]) (authenticated bits=0)
	by manowar.linespeed.net (8.14.1/8.14.1) with ESMTP id n0KEVF2h029774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 08:31:17 -0600
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

This is a multi-part message in MIME format.
--------------070706050201050302040705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

i2s replay is not being enabled properly on occasion on my pxa270 
board.  Current code is touching SACR1 in hw_params which I believe is 
not correct.  That should be configured in trigger before enabling i2s.  
Record is not disabled for playback mode.  Any invalid data in the 
transmit fifo causes deadlock and replay is being disabled.

I have been able to reproduce it in kernel 2.6.26 as well as Linus' git 
tree using speaker-test.  (repeatedly starting and stopping).  I've 
verified that this fix prevents (at least) this condition.

Please review this patch and let me know if there is anything I have 
overlooked.

Thanks

--------------070706050201050302040705
Content-Type: text/plain;
 name="pxa2xx-i2s-clean-startup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pxa2xx-i2s-clean-startup.patch"

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 517991f..6cda7f1 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -211,12 +211,10 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (!(SACR0 & SACR0_ENB)) {
 
 		SACR0 = 0;
-		SACR1 = 0;
 		if (pxa_i2s.master)
 			SACR0 |= SACR0_BCKD;
 
 		SACR0 |= SACR0_RFTH(14) | SACR0_TFTH(1);
-		SACR1 |= pxa_i2s.fmt;
 	}
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		SAIMR |= SAIMR_TFS;
@@ -257,6 +255,12 @@ static int pxa2xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		SACR1 = pxa_i2s.fmt | SACR1_DRPL | SACR1_DREC;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			SACR1 &= ~SACR1_DRPL;
+		} else {
+			SACR1 &= ~SACR1_DREC;
+		}
 		SACR0 |= SACR0_ENB;
 		break;
 	case SNDRV_PCM_TRIGGER_RESUME:

--------------070706050201050302040705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070706050201050302040705--
