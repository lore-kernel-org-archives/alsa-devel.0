From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: WL1273 FM Radio driver...
Date: Mon, 07 Feb 2011 15:34:08 +0200
Message-ID: <1297085648.15320.42.camel@masi.mnp.nokia.com>
References: <1297075922.15320.31.camel@masi.mnp.nokia.com>
	<4D4FDED0.7070008@redhat.com>
	<20110207120234.GE10564@opensource.wolfsonmicro.com>
	<4D4FEA03.7090109@redhat.com>
	<1297085233.15320.39.camel@masi.mnp.nokia.com>
	<20110207132821.GI10564@opensource.wolfsonmicro.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 88D5924333
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 14:34:13 +0100 (CET)
In-Reply-To: <20110207132821.GI10564@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, ext Mauro Carvalho Chehab <mchehab@redhat.com>, hverkuil@xs4all.nl, lrg@slimlogic.co.uk, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-02-07 at 13:28 +0000, ext Mark Brown wrote:
> On Mon, Feb 07, 2011 at 03:27:12PM +0200, Matti J. Aaltonen wrote:
> 
> > So you are suggesting a more or less complete rewrite, so that I'd
> > create a directory like media/radio/wl1273 and then place there all of
> > the driver files: wl1273-radio.c, wl1273-alsa.c and maybe wl1273-core.c?
> 
> Don't move the ASoC driver out of the ASoC code, it's a complete pain
> for maintaining it and only makes the problems with having to build v4l
> worse.

I won't do anything before we have some kind of consensus :-)

Cheers,
Matti
