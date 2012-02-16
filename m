From: Axel Lin <axel.lin@gmail.com>
Subject: ASoC: A missing entry in wm2200_bclk_rates_cd array?
Date: Thu, 16 Feb 2012 17:17:41 +0800
Message-ID: <1329383861.2861.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9339E244AE
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 10:17:51 +0100 (CET)
Received: by pbbrp2 with SMTP id rp2so2456328pbb.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 01:17:50 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
WM2200_NUM_BCLK_RATES is 12.
It looks like there is a missing entry in wm2200_bclk_rates_cd array.

static int wm2200_bclk_rates_cd[WM2200_NUM_BCLK_RATES] = {
        5644800,
        2882400,
        1881600,
        1411200,
        705600,
        470400,
        352800,
        176400,
        117600,
        88200,
        58800,
};

Axel
