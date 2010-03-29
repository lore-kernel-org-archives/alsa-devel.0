From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] bug in spi and i2c dual	buses
	codecs
Date: Mon, 29 Mar 2010 19:48:50 +0100
Message-ID: <20100329184849.GF13239@sirena.org.uk>
References: <3c17e3571003282324t2b0cf67aj93dc3c4d1e6c8ae5@mail.gmail.com>
	<20100329094938.GB29441@rakim.wolfsonmicro.main>
	<8bd0f97a1003291125t77aa762eida59cd4a112927ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8bd0f97a1003291125t77aa762eida59cd4a112927ae-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 29, 2010 at 02:25:02PM -0400, Mike Frysinger wrote:
> On Mon, Mar 29, 2010 at 05:49, Mark Brown wrote:

> > Yes, this is expected behaviour. ??It's not been a practical problem -
> > the combination of audio built in and one of the buses modular is far
> > from common.

> knowingly breaking randconfig is viewed as a bad thing by people on lkml

Right, the machine drivers need to take care of this when they select
the CODEC drivers like SND_SOC_ALL_CODECS does (at least with drivers
for the platforms where people care about that, anyway - I'm not going
to insist on it for random machines that hardly ever get built).

This isn't exactly something that's been introduced just recently, we've
been doing this for some considerable time - well over a year.
