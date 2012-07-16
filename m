From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] wss_lib: Fix resume on Yamaha OPL3-SAx
Date: Mon, 16 Jul 2012 08:30:18 +0200
Message-ID: <201207160830.18826.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
	by alsa0.perex.cz (Postfix) with ESMTP id CEE1224B88
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2012 08:30:39 +0200 (CEST)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Yamaha OPL3-SAx chips don't resume properly when playback is running -
garbage is played after resume. Restoring the CS4231_PLAYBK_FORMAT register
last fixes the problem.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1656,6 +1656,10 @@ static void snd_wss_resume(struct snd_wss *chip)
 			break;
 		}
 	}
+	/* Yamaha needs this to resume properly */
+	if (chip->hardware == WSS_HW_OPL3SA2)
+		snd_wss_out(chip, CS4231_PLAYBK_FORMAT,
+			    chip->image[CS4231_PLAYBK_FORMAT]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 #if 1
 	snd_wss_mce_down(chip);

-- 
Ondrej Zary
