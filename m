From: arnaud.patard@rtp-net.org
Subject: [patch 2/2] ASoC: kirkwood-i2s: Handle mute/unmute
	playback/record
Date: Sun, 11 Jul 2010 23:28:32 +0200
Message-ID: <20100711213507.270709988@rtp-net.org>
References: <20100711212830.815827907@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 492DE24507
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Jul 2010 23:52:47 +0200 (CEST)
Content-Disposition: inline; filename=kirkwood_unmute.patch
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

The controller has mute/unmute capability and some bootloader may mute
them at boot. If it's not handled, all things will seem to be working
but no sound will come out of the speaker/headphone.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Index: sound-2.6/sound/soc/kirkwood/kirkwood-i2s.c
===================================================================
--- sound-2.6.orig/sound/soc/kirkwood/kirkwood-i2s.c	2010-07-11 14:22:06.000000000 +0200
+++ sound-2.6/sound/soc/kirkwood/kirkwood-i2s.c	2010-07-11 14:36:54.000000000 +0200
@@ -193,7 +193,8 @@
 		/* configure audio & enable i2s playback */
 		value = readl(priv->io + KIRKWOOD_PLAYCTL);
 		value &= ~KIRKWOOD_PLAYCTL_BURST_MASK;
-		value &= ~(KIRKWOOD_PLAYCTL_PAUSE|KIRKWOOD_PLAYCTL_SPDIF_EN);
+		value &= ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE
+				| KIRKWOOD_PLAYCTL_SPDIF_EN);
 
 		if (priv->burst == 32)
 			value |= KIRKWOOD_PLAYCTL_BURST_32;
@@ -206,7 +207,7 @@
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* stop audio, disable interrupts */
 		value = readl(priv->io + KIRKWOOD_PLAYCTL);
-		value |= KIRKWOOD_PLAYCTL_PAUSE;
+		value |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
 		writel(value, priv->io + KIRKWOOD_PLAYCTL);
 
 		value = readl(priv->io + KIRKWOOD_INT_MASK);
@@ -222,14 +223,14 @@
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		value = readl(priv->io + KIRKWOOD_PLAYCTL);
-		value |= KIRKWOOD_PLAYCTL_PAUSE;
+		value |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
 		writel(value, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		value = readl(priv->io + KIRKWOOD_PLAYCTL);
-		value &= ~KIRKWOOD_PLAYCTL_PAUSE;
+		value &= ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE);
 		writel(value, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
@@ -262,7 +263,8 @@
 		value = readl(priv->io + KIRKWOOD_RECCTL);
 		value &= ~KIRKWOOD_RECCTL_BURST_MASK;
 		value &= ~KIRKWOOD_RECCTL_MONO;
-		value &= ~(KIRKWOOD_RECCTL_PAUSE | KIRKWOOD_RECCTL_SPDIF_EN);
+		value &= ~(KIRKWOOD_RECCTL_PAUSE | KIRKWOOD_RECCTL_MUTE
+			| KIRKWOOD_RECCTL_SPDIF_EN);
 
 		if (priv->burst == 32)
 			value |= KIRKWOOD_RECCTL_BURST_32;
@@ -276,7 +278,7 @@
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* stop audio, disable interrupts */
 		value = readl(priv->io + KIRKWOOD_RECCTL);
-		value |= KIRKWOOD_RECCTL_PAUSE;
+		value |= KIRKWOOD_RECCTL_PAUSE | KIRKWOOD_RECCTL_MUTE;
 		writel(value, priv->io + KIRKWOOD_RECCTL);
 
 		value = readl(priv->io + KIRKWOOD_INT_MASK);
@@ -292,14 +294,14 @@
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		value = readl(priv->io + KIRKWOOD_RECCTL);
-		value |= KIRKWOOD_RECCTL_PAUSE;
+		value |= KIRKWOOD_RECCTL_PAUSE | KIRKWOOD_RECCTL_MUTE;
 		writel(value, priv->io + KIRKWOOD_RECCTL);
 		break;
 
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		value = readl(priv->io + KIRKWOOD_RECCTL);
-		value &= ~KIRKWOOD_RECCTL_PAUSE;
+		value &= ~(KIRKWOOD_RECCTL_PAUSE | KIRKWOOD_RECCTL_MUTE);
 		writel(value, priv->io + KIRKWOOD_RECCTL);
 		break;
