From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH RESEND v6 0/3] ASoC: Add iPAQ RX1950 support
Date: Mon, 30 Aug 2010 11:28:06 +0300
Message-ID: <1283156889-5544-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 52D7D2413A
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 10:28:46 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2929756eyd.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 01:28:45 -0700 (PDT)
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

v2: - make mixer regs dirty after power-down, not after power-up
v3: - improve glue driver init code (handle errors)
v4: - adapt patches for multi-component
v5: - handle return values in rx1950_uda1380 init code;
- use gpio_set_value instead of gpio_direction_output in
spk_power;
- uda1380: improve code alignment in set_bias
v6: - use gpio_is_valid to check gpio validity
