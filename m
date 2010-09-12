From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2 0/1] ASoC: Add HP iPAQ H1940 support
Date: Sun, 12 Sep 2010 15:18:46 +0300
Message-ID: <1284293927-15983-1-git-send-email-anarsoul@gmail.com>
References: <1284288909-5961-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 00098246F0
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Sep 2010 14:20:03 +0200 (CEST)
Received: by eye27 with SMTP id 27so1391337eye.38
	for <alsa-devel@alsa-project.org>; Sun, 12 Sep 2010 05:20:03 -0700 (PDT)
In-Reply-To: <1284288909-5961-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel <alsa-devel@alsa-project.org>, Ben Dooks <ben-linux@fluff.org>, Arnaud Patard (Rt
List-Id: alsa-devel@alsa-project.org

This patch depends on gpiolib support for h1940 latch access,
here's link to patch in ml archive:

http://www.spinics.net/lists/arm-kernel/msg98042.html

I hope Ben will find some time to merge it into his tree
before 2.6.37 merge window :)

v2: - printk replaced via dev_err;
- added module alias
