From: Juergen Beisert <jbe@pengutronix.de>
Subject: [PATCH][sound/SOC] Do not register platform sound device unconditionally
Date: Mon, 28 Nov 2011 15:11:39 +0100
Message-ID: <201111281511.40633.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Registering a SOC device and also changing register unconditionally fails on
kernels which support more than one machine in one binary. Do it only if the
platform matches.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>

diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic32x4.c
index 054110b..c5cfb8a 100644
--- a/sound/soc/imx/mx27vis-aic32x4.c
+++ b/sound/soc/imx/mx27vis-aic32x4.c
@@ -96,6 +96,10 @@ static int __init mx27vis_aic32x4_init(void)
 {
 	int ret;
 
+	if (!machine_is_imx27_visstrim_m10())
+		/* return happy. We run on a totally different machine */
+		return 0;
+
 	mx27vis_aic32x4_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!mx27vis_aic32x4_snd_device)
 		return -ENOMEM;

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
