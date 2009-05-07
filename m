From: Karl Beldan <karl.beldan@gmail.com>
Subject: [PATCH 0/4] pxa2xx-i2s: Rework
Date: Fri, 08 May 2009 01:44:45 +0200
Message-ID: <4A03726D.5010301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 906BD103886
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 01:44:32 +0200 (CEST)
Received: by ewy23 with SMTP id 23so1673525ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 07 May 2009 16:44:32 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.miao@marvell.com>, Russell King <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

Following is a rework of the i2s code for the pxa.
I tested it with the ac97 clock as the master clock.

Tests feedbacks are welcome.


-- 
Karl
