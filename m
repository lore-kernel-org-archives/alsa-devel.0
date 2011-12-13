From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/19] mx27vis-aic32x4: only register when running on the
 right machine
Date: Tue, 13 Dec 2011 14:40:48 +0800
Message-ID: <20111213064047.GD7148@opensource.wolfsonmicro.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
 <1323757911-25217-6-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323757911-25217-6-git-send-email-eric@eukrea.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Javier Martin <javier.martin@vista-silicon.com>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 13, 2011 at 07:31:38AM +0100, Eric B=E9nard wrote:
> without this fix, a kernel compiled with imx_v4_v5_defconfig
> and running on a cpuimx25sd leads to :

I'll apply this but a better fix is to convert the driver to be a norma=
l
platform driver and only register the device on the appropraite boards.
