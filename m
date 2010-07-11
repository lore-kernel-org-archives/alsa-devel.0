From: arnaud.patard@rtp-net.org
Subject: [patch 1/2] ASoC: Fix kirkwood i2s mono playback
Date: Sun, 11 Jul 2010 23:28:31 +0200
Message-ID: <20100711213505.842221724@rtp-net.org>
References: <20100711212830.815827907@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B01824508
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Jul 2010 23:52:47 +0200 (CEST)
Content-Disposition: inline; filename=kirkwood_fix_mono_playback.patch
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
Cc: broonie@opensource.wolfsonmicro.com, tbm@cyrius.com, Arnaud Patard <arnaud.patard@rtp-net.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Kirkwood controller needs to be informed if the audio stream is mono
or not. Failing to do so will result in playing at the wrong speed.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Index: sound-2.6/sound/soc/kirkwood/kirkwood-i2s.c
===================================================================
--- sound-2.6.orig/sound/soc/kirkwood/kirkwood-i2s.c	2010-07-10 21:53:35.000000000 +0200
+++ sound-2.6/sound/soc/kirkwood/kirkwood-i2s.c	2010-07-11 13:01:55.000000000 +0200
@@ -153,6 +153,15 @@
 	default:
 		return -EINVAL;
 	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		value &= ~KIRKWOOD_PLAYCTL_MONO_MASK;
+		if (params_channels(params) == 1)
+			value |= KIRKWOOD_PLAYCTL_MONO_BOTH;
+		else
+			value |= KIRKWOOD_PLAYCTL_MONO_OFF;
+	}
+
 	writel(i2s_value, priv->io+i2s_reg);
 	writel(value, priv->io+reg);
 
Index: sound-2.6/sound/soc/kirkwood/kirkwood.h
===================================================================
--- sound-2.6.orig/sound/soc/kirkwood/kirkwood.h	2010-07-11 12:08:30.000000000 +0200
+++ sound-2.6/sound/soc/kirkwood/kirkwood.h	2010-07-11 12:10:56.000000000 +0200
@@ -49,6 +49,9 @@
 #define KIRKWOOD_PLAYCTL_BURST_32		(1<<11)
 #define KIRKWOOD_PLAYCTL_PAUSE			(1<<9)
 #define KIRKWOOD_PLAYCTL_SPDIF_MUTE		(1<<8)
+#define KIRKWOOD_PLAYCTL_MONO_MASK		(3<<5)
+#define KIRKWOOD_PLAYCTL_MONO_BOTH		(3<<5)
+#define KIRKWOOD_PLAYCTL_MONO_OFF		(0<<5)
 #define KIRKWOOD_PLAYCTL_I2S_MUTE		(1<<7)
 #define KIRKWOOD_PLAYCTL_SPDIF_EN		(1<<4)
 #define KIRKWOOD_PLAYCTL_I2S_EN		(1<<3)
