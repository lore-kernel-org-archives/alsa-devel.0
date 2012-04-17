From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] Add Wolfson Microelectronics WM8766
 codec ALSA driver
Date: Tue, 17 Apr 2012 15:59:29 +0100
Message-ID: <20120417145929.GA22575@sirena.org.uk>
References: <1334611118-10301-1-git-send-email-linux@rainbow-software.org>
	<1334611118-10301-3-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 241F310419F
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 16:59:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1334611118-10301-3-git-send-email-linux@rainbow-software.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 16, 2012 at 11:18:36PM +0200, Ondrej Zary wrote:
> Needed by Philips PSC724 subdriver. The code does not contain any
> card-specific bits so it can be used by any other ALSA driver.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

Please CC me (and ideally all of patches@opensource.wolfsonmicro.com)
on any drivers for Wolfson devices.  It's not like we're secretive!

> ---
>  include/sound/wm8766.h   |  160 ++++++++++++++++++++
>  sound/i2c/other/Makefile |    3 +-
>  sound/i2c/other/wm8766.c |  374 ++++++++++++++++++++++++++++++++++++++++++++++

No, this should be supported in ASoC - anything adding new code in
sound/i2c is *deeply* suspicious.

> +struct snd_wm8766_ops {
> +	void (*write)(struct snd_wm8766 *wm, u16 addr, u16 data);
> +};

You should in general use regmap rather than open coding register I/O
for I2C devices.

> +void snd_wm8766_init(struct snd_wm8766 *wm);
> +void snd_wm8766_set_if(struct snd_wm8766 *wm, u16 dac);
> +void snd_wm8766_set_master_mode(struct snd_wm8766 *wm, u16 mode);
> +void snd_wm8766_set_power(struct snd_wm8766 *wm, u16 power);
> +void snd_wm8766_volume_restore(struct snd_wm8766 *wm);
> +int snd_wm8766_build_controls(struct snd_wm8766 *wm);

I've not yet looked at the rest of the code but this looks awfully like
you've just invented a minimal version of the ASoC interfaces...
