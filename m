From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCHv2] ASoC: Overhaul Samsung drivers
Date: Fri, 22 Oct 2010 17:30:38 +0900
Message-ID: <1287736238-11846-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id D1E8D24333
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 10:38:07 +0200 (CEST)
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
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, mcuelenaere@gmail.com, cw00.choi@samsung.com, ben-linux@fluff.org, june.bae@samsung.com, sw.youn@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Hi,

Submitting revised patch series.

Patches 11 through 16 apply to Kgene's tree, rest apply to
Mark Brown's.

Since v1:
a) Use case 16 in set_bfs and default for error
b) Better code comments.
c) Use switch case in i2sv2_i2s_set_clkdiv
d) Use SNDRV_PCM_RATE_8000_96000
e) MAX_I2S -> SAMSUNG_I2S_SECOFF
f) Local namespace cleanup with i2s driver.
------------

Here come patches overhauling the Samsung ASoC support.

The AC97, PCM, SPDIF and ASoC-DMA related code has merely undergone
cosmetic changes - symbol, device & driver renaming and file moving.

A new I2S controller driver has been added to manage Samsung SoCs since
S3C64XX. Older driver has been changed only as is necessary.
Regarding I2S, I have left the s3c24xx series untouched because the
controllers are too different to run by a common driver. S3C2412's I2S
does have some similarities, but not important enough to warrant impact
on new driver design.
The new I2S driver has been designed around the notion of features/quirks.
The newer SoCs have revised version of I2S_0(usually) than previous ones.
So, I2S block is 'specified' in the platform code and the driver works on
that configuration.
For now, Secondary I2S DAI works only with System-DMAC. I2S-Internal DMA
and SRAM will be enabled later.

Testing:-
  Simple testing of 5.1 channel and hardware mixing seems to work (though
there seems to be some issue with symmetric_rates in soc-core.c which
would be tried to fix later as saperate issue).
 I would appreciate any test-results for GONI and SMARTQ.

I suggest the patches 13,14,16 & 17 go via Kgene's Tree, and the rest via ASoC
tree due to tight dependencies.

1). ASoC: Samsung: Remove redundant AQUILA driver
2). ASoC: Samsung: Rename DMA device
3). ARM: Samsung: Define common audio-dma device
4). ASoC: Samsung: Rename ASoC DMA driver
5). ASoC: Samsung: Rename AC97 platform device
6). ASoC: Samsung: Rename AC97 driver
7). ASoC: Samsung: Rename PCM driver
8). ASoC: Samsung: Generalize DMA driver namespace
9). ASoC: Samsung: Rename s3c64xx I2S device
10). ASoC: Samsung: Add common I2S driver
11). ARM: S3C64XX: I2S: Upgrade platform device
12). ARM: S5P6440: I2S: Upgrade platform device
13). ARM: S5P6442: I2S: Upgrade platform device
14). ARM: S5PC100: I2S: Upgrade platform device
15). ARM: S5PV210: I2S: Upgrade platform device
16). ARM: S5PV310: Add audio platform devices
17). ASoC: SMARTQ: Move to use new I2S driver
18). ASoC: GONI: Move to use new I2S driver
19). ASoC: SMDK64XX: Move to use new I2S driver
20). ASoC: S3C64XX: Remove obsoleted I2S drivers
21). ASoC: SMDK64XX: Rename for other platforms
22). ASoC: SMDK_WM8580: Enable for SMDKC100
23). ASoC: Samsung: Generalize Kconfig symbols
24). ASoC: Samsung: Rename from s3c24xx to samsung


Thanks,
Jassi
