From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v3 0/1] ASoC: Add HP iPAQ H1940 support
Date: Mon, 13 Sep 2010 12:47:17 +0300
Message-ID: <1284371238-25924-1-git-send-email-anarsoul@gmail.com>
References: <20100913090543.GG16606@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 04E2824609
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 11:48:33 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2577971ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2010 02:48:33 -0700 (PDT)
In-Reply-To: <20100913090543.GG16606@rakim.wolfsonmicro.main>
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

v3: - removed module alias
