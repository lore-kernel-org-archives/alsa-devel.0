From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Allow passing platform_data to
	devices	attached to AC97 bus
Date: Tue, 21 Jul 2009 19:27:54 +0100
Message-ID: <20090721182754.GA28955@sirena.org.uk>
References: <200907211633.14388.marek.vasut@gmail.com>
	<20090721145323.GA8991@rakim.wolfsonmicro.main>
	<s5hd47u2hjc.wl%tiwai@suse.de>
	<200907211940.21638.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A8241103869
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 20:27:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907211940.21638.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 21, 2009 at 07:40:21PM +0200, Marek Vasut wrote:
> Dne ??t 21. ??ervence 2009 17:16:07 Takashi Iwai napsal(a):

> +struct wm97xx_touch_pdata {
> +	int	irq;
> +	bool	irq_inverted;

The IRQ is not touch-specific, it should be part of the main platform
data.  I can't see anything in the patch actually using this or any
other part of the touch platform data, though...

> +	int	cont_rate;
> +	int	pen_int;
> +	int	pressure;
> +	int	ac97_touch_slot;
> +
> +};

As I said previously this should be able to completely replace the
existing touch configuration.  That means the entire mach_ops structure,
plus all the stuff that can be configured via module options (including
the new option for the WM1616).
