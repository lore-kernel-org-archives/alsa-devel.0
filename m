From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESEND][PATCH] ASoC: ams-delta: Convert to use
 snd_soc_register_card()
Date: Thu, 4 Oct 2012 18:50:26 +0100
Message-ID: <20121004175025.GU4360@opensource.wolfsonmicro.com>
References: <20120906073633.GC22330@opensource.wolfsonmicro.com>
 <1582731.dIkBtAuyKn@vclass>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1582731.dIkBtAuyKn@vclass>
Sender: linux-omap-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 03, 2012 at 12:46:57PM +0200, Janusz Krzysztofik wrote:
> The old method of registering with the ASoC core by creating a
> "soc-audio" platform device no longer works for Amstrad Delta sound card
> after recent changes to drvdata handling (commit
> 0998d0631001288a5974afc0b2a5f568bcdecb4d, 'device-core: Ensure drvdata =
> NULL when no driver is bound'.

Applied, thanks.
