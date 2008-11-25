From: David Brownell <david-b@pacbell.net>
Subject: Re: [alsa-devel] [PATCH] ASoC: Fix TW4030 Kconfig dependency
Date: Tue, 25 Nov 2008 10:54:28 -0800
Message-ID: <200811251054.29156.david-b@pacbell.net>
References: <1227587172-9523-1-git-send-email-arunks@mistralsolutions.com> <200811242044.13438.david-b@pacbell.net> <20081125153013.GH12414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20081125153013.GH12414@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: arunks@mistralsolutions.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, steve@sakoman.com
List-Id: alsa-devel@alsa-project.org

On Tuesday 25 November 2008, Mark Brown wrote:
> Might it be an idea to have the relevant machine drivers select the
> TWL4030 support? =A0This would prevent them disabling it but the chip=
 is
> such a basic part of these systems that that doesn't seem unreasonabl=
e.

I'm not sure what you mean by "machine driver" ... there seem
to be two:  arch/arm/mach-omap2/board-*.c for everything except
ALSA, and then sound/soc/omap/*.c for the ASoC bits.

As a rule, it's worth avoiding "select" in Kconfig; it doesn't
work well, since it won't even report missing dependencies much
less fix the trivial ones.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
