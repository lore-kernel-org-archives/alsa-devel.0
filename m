From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: ASoC for TI OMAP - Multiformat ASoC DAI link
 driver?
Date: Thu, 3 Apr 2008 09:13:41 +0300
Message-ID: <20080403091341.f93628d4.jarkko.nikula@nokia.com>
References: <20080402134538.67d67d6e.jarkko.nikula@nokia.com>
	<20080402114820.GB7977@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id B669C103812
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Apr 2008 08:13:33 +0200 (CEST)
In-Reply-To: <20080402114820.GB7977@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2 Apr 2008 12:48:20 +0100
"ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> > I looked shortly asoc-v2-dev branch and now this type field is gone.
> > Does it mean that there you can have DAI link driver which supports
> > multiple formats in set_fmt callback?
> 
> I don't know if anyone has ever actually done that but there should be
> nothing in the core which has a problem with doing it - if there is we
> should fix it up since this is a perfectly reasonable use case and
> affects a number of other modern processors too.
> 
I think I'll let my first ASoC v1 McBSP DAI link driver to support
only I2S. I don't know do we even have OMAP boards using some another
format with audio codec.

Audio link to bluetooth chip is an another case, like a secondary DAI
link & codec, and requires anyway transition to ASoC v2 as I have
understood.

-- 
Jarkko
