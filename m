From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Dynamically registering a codec
Date: Thu, 14 May 2009 19:49:28 +0100
Message-ID: <20090514184927.GB13483@rakim.wolfsonmicro.main>
References: <9e4733910905131218t174b3b7cxc0e5c2fd5f5a0a06@mail.gmail.com>
	<20090513224424.GB24973@sirena.org.uk>
	<9e4733910905140844h1899bb60p19309953905b51d3@mail.gmail.com>
	<1242317750.31458.1782.camel@finisterre>
	<9e4733910905140943u7f8e5151tbaba86938bf9e77e@mail.gmail.com>
	<1242322832.31458.1911.camel@finisterre>
	<9e4733910905141057t64c515a2n8473a26da852fdfd@mail.gmail.com>
	<9e4733910905141115p2f682f0bwf16ae3eab5d22618@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 61F48244AD
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 20:49:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905141115p2f682f0bwf16ae3eab5d22618@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 02:15:17PM -0400, Jon Smirl wrote:

> I'm juggling too many balls. ASoC needs some more rework to make the
> modules load dynamically.  The codecs need to implement .id_table.

ASoC is fine here, please take a look at drivers like wm8903 - the DAI
registration functions are all about letting things take advantage of
this.   I'll be insisting that all CODEC drivers do this at some point
but it's not yet blocking anything else.  Like I say, AC97 is a bit
special due to general lack of infrastructure for it.
