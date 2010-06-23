From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DaVinci: Added support for stereo I2S
Date: Thu, 24 Jun 2010 00:24:16 +0100
Message-ID: <ACF70CBE-6096-431C-A5A1-E3700642EB53@opensource.wolfsonmicro.com>
References: <1277303635-5675-1-git-send-email-lamiaposta71@gmail.com> (sfid-20100623_154205_545825_0E9CDE5F)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277303635-5675-1-git-send-email-lamiaposta71@gmail.com> (sfid-20100623_154205_545825_0E9CDE5F)
Sender: linux-kernel-owner@vger.kernel.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, Raffaele Recalcati <raffaele.recalcati@bticino.it>, Davide Bonfanti <davide.bonfanti@bticino.it>, Russell King <linux@arm.linux.org.uk>, Chaithrika U S <chaithrika@ti.com>, Troy Kisky <troy.kisky@boundarydevices.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 23 Jun 2010, at 15:33, Raffaele Recalcati wrote:

> From: Raffaele Recalcati <raffaele.recalcati@bticino.it>
> 
> 	Added audio playback support with [frame sync master - clock master] mode
> 	and with [frame sync master - clock slave].
> 	Clock slave can be important when the external codec need system clock
> 	and bit clock synchronized.
> 	In the clock master case there is a FIXME message in the source code, because we
> 	(Davide and myself) have guessed a frequency of 122000000 that seems the base
> 	to be divided.
> 	This patch has been developed against the
> 		http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git
> 	git tree and has been tested on bmx board (similar to dm365 evm, but using
> 	uda1345 as external audio codec).
> 
> Signed-off-by: Raffaele Recalcati <raffaele.recalcati@bticino.it>
> Signed-off-by: Davide Bonfanti <davide.bonfanti@bticino.it>

I'd pretty much echo what Liam said - I'm not 100% sure from your description what the
patch is supposed to do and the code isn't particularly clear either. It *looks* like you're
trying to add a new clock source, but from the description this appears to be an
externally visible clock which makes it very unclear why you have to guess the frequency.