From: "John Kacur" <jkacur@gmail.com>
Subject: Re: davinci_request_dma()
Date: Mon, 20 Oct 2008 11:17:41 +0200
Message-ID: <520f0cf10810200217t10193b1el7c69809b593866cb@mail.gmail.com>
References: <520f0cf10810160158y67c8330fg959f198d9026d680@mail.gmail.com>
	<20081016090810.GA3539@sirena.org.uk>
	<520f0cf10810160224o6fdc5235s946578544b9034f1@mail.gmail.com>
	<20081016100135.GC3539@sirena.org.uk>
	<520f0cf10810160305y673ba91btaf53e5ce4682aa77@mail.gmail.com>
	<20081016120837.GD3539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id A4BC01037F3
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 11:17:59 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id l35so948249waf.16
	for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2008 02:17:41 -0700 (PDT)
In-Reply-To: <20081016120837.GD3539@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 16, 2008 at 2:08 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Oct 16, 2008 at 12:05:41PM +0200, John Kacur wrote:
>> On Thu, Oct 16, 2008 at 12:01 PM, Mark Brown <broonie@sirena.org.uk> wrote:
>
>> > What are you looking to do - if you're looking for an ASoC driver for
>> > DaVinici that's the only one I'm aware of.
>
>> No, I'm looking at doing ASoC drivers in general, not for a DaVinci
>> processor specifically.
>
> PXA, OMAP or S3C24xx should all be good bets in terms of platform
> support.  Out of interest, what are you working on?
>

PXA appears to be incomplete too! s3c24xx looks like the only one that
might work. (at least with 2.6.26 mainline). If I'm not mistaken PXA
must also be living in an external git tree, and is only partially
implemented in the mainline kernel.

Thanks again for all the hints and info.
