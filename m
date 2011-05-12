From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RESEND][PATCH] ASoC: Update omap/ams-delta for TTY
	API change
Date: Fri, 13 May 2011 00:36:07 +0200
Message-ID: <201105130036.25433.jkrzyszt@tis.icnet.pl>
References: <201105121929.50301.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id B60F61037E3
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 00:37:17 +0200 (CEST)
In-Reply-To: <201105121929.50301.jkrzyszt@tis.icnet.pl>
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
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, patches@opensource.wolfsonmicro.com, Felipe Balbi <balbi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Following the receive_buf() change to return the number of bytes 
received, the cx20442 CODEC driver was updated to report that we 
accepted all the data that was offered to us. Do the same with the 
corresponding Amstrad Delta sound card level wrapper function, which is 
actually registered as the tty line discipline callback instead of the 
the CODEC function, which it then calls.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
Resend because of line wrap, sorry.
Janusz

 sound/soc/omap/ams-delta.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- git/sound/soc/omap/ams-delta.c.orig	2011-04-09 00:39:54.000000000 +0200
+++ git/sound/soc/omap/ams-delta.c	2011-05-12 18:50:33.000000000 +0200
@@ -331,7 +331,7 @@ static int cx81801_hangup(struct tty_str
 }
 
 /* Line discipline .recieve_buf() */
-static void cx81801_receive(struct tty_struct *tty,
+static unsigned int cx81801_receive(struct tty_struct *tty,
 				const unsigned char *cp, char *fp, int count)
 {
 	struct snd_soc_codec *codec = tty->disc_data;
@@ -347,7 +347,7 @@ static void cx81801_receive(struct tty_s
 		/* Initialize timer used for config pulse generation */
 		setup_timer(&cx81801_timer, cx81801_timeout, 0);
 
-		v253_ops.receive_buf(tty, cp, fp, count);
+		ret = v253_ops.receive_buf(tty, cp, fp, count);
 
 		/* Link hook switch to DAPM pins */
 		ret = snd_soc_jack_add_pins(&ams_delta_hook_switch,
@@ -358,10 +358,10 @@ static void cx81801_receive(struct tty_s
 				"Failed to link hook switch to DAPM pins, "
 				"will continue with hook switch unlinked.\n");
 
-		return;
+		return count;
 	}
 
-	v253_ops.receive_buf(tty, cp, fp, count);
+	ret = v253_ops.receive_buf(tty, cp, fp, count);
 
 	for (c = &cp[count - 1]; c >= cp; c--) {
 		if (*c != '\r')
@@ -381,6 +381,7 @@ static void cx81801_receive(struct tty_s
 						AMS_DELTA_LATCH2_MODEM_CODEC);
 		break;
 	}
+	return count;
 }
 
 /* Line discipline .write_wakeup() */
