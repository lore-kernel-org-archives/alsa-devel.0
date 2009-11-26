From: Ondrej Zary <linux@rainbow-software.org>
Subject: tea575x-tuner: fix mute
Date: Thu, 26 Nov 2009 21:41:15 +0100
Message-ID: <200911262141.17143.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail1-out1.atlantis.sk [80.94.52.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 4361E24563
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 21:41:26 +0100 (CET)
Content-Disposition: inline
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

Fix mute state reporting in tea575x-tuner.
This fixes mute function in kradio on SF64-PCR radio card.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-source-2.6.31-orig/sound/i2c/other/tea575x-tuner.c	2009-09-10 00:13:59.000000000 +0200
+++ linux-source-2.6.31/sound/i2c/other/tea575x-tuner.c	2009-11-26 21:30:28.000000000 +0100
@@ -225,7 +225,7 @@ static int vidioc_s_ctrl(struct file *fi
 	case V4L2_CID_AUDIO_MUTE:
 		if (tea->ops->mute) {
 			tea->ops->mute(tea, ctrl->value);
-			tea->mute = 1;
+			tea->mute = ctrl->value;
 			return 0;
 		}
 	}

-- 
Ondrej Zary
