From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] tea575x: remove useless input ioctls
Date: Sat, 11 Jun 2011 15:37:29 +0200
Message-ID: <201106111537.32037.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail1-out1.atlantis.sk [80.94.52.55])
	by alsa0.perex.cz (Postfix) with ESMTP id C080224440
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Jun 2011 15:37:36 +0200 (CEST)
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
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Remove empty and useless g_input and s_input ioctls.
This fixes one fail of v4l2-compliance test.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.39-rc2-/sound/i2c/other/tea575x-tuner.c	2011-06-11 15:29:18.000000000 +0200
+++ linux-2.6.39-rc2/sound/i2c/other/tea575x-tuner.c	2011-06-11 15:29:51.000000000 +0200
@@ -269,19 +269,6 @@ static int tea575x_s_ctrl(struct v4l2_ct
 	return -EINVAL;
 }
 
-static int vidioc_g_input(struct file *filp, void *priv, unsigned int *i)
-{
-	*i = 0;
-	return 0;
-}
-
-static int vidioc_s_input(struct file *filp, void *priv, unsigned int i)
-{
-	if (i != 0)
-		return -EINVAL;
-	return 0;
-}
-
 static const struct v4l2_file_operations tea575x_fops = {
 	.owner		= THIS_MODULE,
 	.unlocked_ioctl	= video_ioctl2,
@@ -293,8 +280,6 @@ static const struct v4l2_ioctl_ops tea57
 	.vidioc_s_tuner     = vidioc_s_tuner,
 	.vidioc_g_audio     = vidioc_g_audio,
 	.vidioc_s_audio     = vidioc_s_audio,
-	.vidioc_g_input     = vidioc_g_input,
-	.vidioc_s_input     = vidioc_s_input,
 	.vidioc_g_frequency = vidioc_g_frequency,
 	.vidioc_s_frequency = vidioc_s_frequency,
 };


-- 
Ondrej Zary
