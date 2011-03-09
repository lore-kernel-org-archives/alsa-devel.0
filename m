From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: omap: rx51: Enable McBSP2 sidetone
Date: Wed,  9 Mar 2011 11:25:00 +0200
Message-ID: <1299662700-25220-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0F565244AC
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 10:23:30 +0100 (CET)
Received: by ewy28 with SMTP id 28so81635ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 01:23:28 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

McBSP sidetone is needed in telephony applications. McBSP sidetone is a
configurable FIR filter that forms a loopback from McBSP input to output.
This patch enables the McBSP2 sidetone ALSA controls so that it can be used
on Nokia RX-51/N900.

Sidetone feature can be tested with following commands:

	(set up codec input and output paths)
	# Enable and configure sidetone
	amixer -D hw:0 set 'McBSP2 Sidetone' on
	amixer set -D hw:0 'McBSP2 Sidetone Channel 0' 32767
	echo 32767 >/sys/devices/platform/omap-mcbsp.2/st_taps
	# Do not loop audio via CPU
	arecord -f dat >/dev/null |aplay /dev/zero

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/omap/rx51.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 055e447..d098622 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -331,6 +331,10 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 	snd_soc_limit_volume(codec, "TPA6130A2 Headphone Playback Volume", 42);
 
+	err = omap_mcbsp_st_add_controls(codec, 1);
+	if (err < 0)
+		return err;
+
 	snd_soc_dapm_sync(dapm);
 
 	/* AV jack detection */
-- 
1.7.2.3
