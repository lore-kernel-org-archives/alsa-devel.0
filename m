From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Push snd_soc_write() and
 snd_soc_read() into the source file
Date: Wed, 3 Nov 2010 12:30:35 -0400
Message-ID: <20101103163032.GB16377@opensource.wolfsonmicro.com>
References: <1288640671-13554-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1288792308.6871.3.camel@dplaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B2E22442D
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 17:30:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288792308.6871.3.camel@dplaptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 03, 2010 at 01:51:48PM +0000, Dimitris Papastamos wrote:
> On Mon, 2010-11-01 at 15:44 -0400, Mark Brown wrote:
> > +unsigned int snd_soc_write(struct snd_soc_codec *codec,
> > +			   unsigned int reg, unsigned int val)
> > +{
> > +	dev_dbg(codec->dev, "write %x = %x\n", reg, val);
> > +	return codec->driver->write(codec, reg, val);
> > +}
> > +EXPORT_SYMBOL_GPL(snd_soc_write);

> This sort of debugging output is already present in soc-cache.c.  I
> guess it should be removed from soc-cache.c since it is duplicated
> across all different write() I/O types.

That's the idea; this is much fewer lines of code and also covers all
the MFDs and whatnot that can't use the soc-cache code for whatever
reasons.
