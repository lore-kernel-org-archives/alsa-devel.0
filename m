From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 2/2] ASoC: fsl: select SND_SOC_FSL_SAI or SND_SOC_FSL_SSI
 depending on SoC type
Date: Wed, 13 Jan 2016 08:10:40 -0600
Message-ID: <56965AE0.40706@tabi.org>
References: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-3-git-send-email-LW@KARO-electronics.de>
 <569545EB.4080307@tabi.org> <20160113133810.167d2dbb@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160113133810.167d2dbb@ipc1.ka-ro>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>, Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Lothar Wa=C3=9Fmann wrote:
> Why? If more than one of the IMX6 SoCs are selected, both interfaces
> may be selected at the same time without any harm.

Oh, ok.  I thought the point behind the patch was that you *souldn't*=20
enable the the SSI driver on an i.MX6UL.
