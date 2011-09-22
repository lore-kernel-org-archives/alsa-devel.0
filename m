From: Axel Lin <axel.lin@gmail.com>
Subject: ASoC: Is there a missing entry in wm5100_bclk_rates_dat array?
Date: Thu, 22 Sep 2011 18:40:17 +0800
Message-ID: <1316688017.2355.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,
I just found the size of wm5100_bclk_rates_dat array is 19,
but there are only 18 entries initialized in current code.
I'm not sure if there is a missing entry in wm5100_bclk_rates_dat array
or not. Could you help to check it again?

#define WM5100_NUM_BCLK_RATES 19

static int wm5100_bclk_rates_dat[WM5100_NUM_BCLK_RATES] = {
        32000,
        48000,
        64000,
        96000,
        128000,
        192000,
        384000,
        512000,
        768000,
        1024000,
        1536000,
        2048000,
        3072000,
        4096000,
        6144000,
        8192000,
        12288000,
        24576000,
};

Thanks,
Axel
