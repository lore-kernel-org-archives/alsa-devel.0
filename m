From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: lowercase wm8978 codec name to
 match its only user and other codecs
Date: Sun, 19 Sep 2010 20:45:31 +0100
Message-ID: <20100919194530.GA20255@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
	<Pine.LNX.4.64.1009171214281.4988@axis700.grange>
	<20100917125319.GF4322@rakim.wolfsonmicro.main>
	<Pine.LNX.4.64.1009191756500.23955@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 37BA21037FC
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Sep 2010 21:45:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1009191756500.23955@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, linux-sh@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 19, 2010 at 05:59:50PM +0200, Guennadi Liakhovetski wrote:
> On Fri, 17 Sep 2010, Mark Brown wrote:

> > Better yet would be to rename this to wm8978 (and adjust the board).

> Well, what does "better" mean? That it's your suggestion or your 
> requirement for this patch to be accepted? I grepped codecs/ and have 
> found enough of both versions, so, maybe we can take it like this and then 
> decide upon a unified naming?

I mean I've already done a version that renames everything to wm8978.  I
don't like the other users for I2C devices terribly much either and will
post patches for at least the drivers I'm responsible for soon.
