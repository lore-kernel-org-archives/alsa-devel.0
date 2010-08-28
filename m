From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 0/2] ASoC: Add iPAQ RX1950 sound support
Date: Sat, 28 Aug 2010 10:49:34 +0300
Message-ID: <1282981776-10014-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AB0FD245C7
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 09:50:16 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2496233eyd.38
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2010 00:50:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Vasily
List-Id: alsa-devel@alsa-project.org

These two patches are necessary to add sound support for
iPAQ RX1950 PDA, appropriate mach-rx1950.c patch is missing,
as it depends on battery and LEDs patches which are still not
merged nor reviewed.

First patch improves situation with power consumption for uda1380
and also fixes suspend/resume.

Second patch just adds glue driver.
