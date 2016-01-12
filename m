From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 0/2] ASoC: fsl: make snd-soc-imx-sgtl5000 driver useable on i.MX6UL
Date: Tue, 12 Jan 2016 19:13:29 +0100
Message-ID: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

This patchset adds support for the i.MX6UL SoC to the imx-sgtl5000
sound driver.
The first patch makes the audmux setup optional for the driver, since
i.MX6UL does not have this unit.
The second patch selects the SAI interface rather than the SSI
interface for the i.MX6UL SoC.

A patch to make the corresponding DTB changes has been sent
separately.
