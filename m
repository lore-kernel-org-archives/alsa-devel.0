From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v4 0/3] ASoC: Add iPAQ RX1950 support
Date: Sun, 29 Aug 2010 20:11:09 +0300
Message-ID: <1283101872-6410-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1D8822442D
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 19:11:40 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2719614ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2010 10:11:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, marek.vasut
List-Id: alsa-devel@alsa-project.org

These three patches are necessary to add sound support for
iPAQ RX1950 PDA, appropriate mach-rx1950.c patch is missing,
as it depends on battery and LEDs patches which are still not
merged nor reviewed.

First patch improves situation with power consumption for uda1380
and also fixes suspend/resume.

Second patch just adds glue driver.

Third patch fixes s3c_device_iis name and exports s3c_device_pcm
for all s3c24xx-based devices.
