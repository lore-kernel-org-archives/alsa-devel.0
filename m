From: Karl Beldan <karl.beldan@gmail.com>
Subject: [PATCH 0/4 v2] pxa2xx-i2s: Rework
Date: Wed, 13 May 2009 22:03:56 +0200
Message-ID: <4A0B27AC.5090101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id F1D9A1038E4
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 22:04:01 +0200 (CEST)
Received: by ewy23 with SMTP id 23so1084011ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 13:04:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

Following is a rework of the i2s code for the pxa.
I tested it with the ac97 clock as the master clock.

Feedbacks are welcome.


Diff with initial version:

- hw init from 1/4 is moved from pxa2xx_i2s_init to pxa2xx_i2s_probe
- moved 'removal of hw reset from pxa2xx_i2s_startup' from 3/4 to 1/4v2
- moved 'clk_put(clk_i2s) removal' from 2/4 to 3/4v2
- 3/4 was also removing FIFOs flushes, 3/4v2 consists of 'clk_put(clk_i2s)
removal' only,



-- 
Karl
