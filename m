From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] cs4270: add support for slave
	mode	configurations
Date: Wed, 25 Feb 2009 16:45:41 +0100
Message-ID: <20090225154541.GF11203@buzzloop.caiaq.de>
References: <1235569041-856-1-git-send-email-daniel@caiaq.de>
	<20090225153444.GC31637@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C2BDD103810
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 16:45:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090225153444.GC31637@sirena.org.uk>
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

On Wed, Feb 25, 2009 at 03:34:45PM +0000, Mark Brown wrote:
> On Wed, Feb 25, 2009 at 02:37:21PM +0100, Daniel Mack wrote:
> 
> >  	reg = snd_soc_read(codec, CS4270_MODE);
> >  	reg &= ~(CS4270_MODE_SPEED_MASK | CS4270_MODE_DIV_MASK);
> > -	reg |= cs4270_mode_ratios[i].speed_mode | cs4270_mode_ratios[i].mclk;
> > +	reg |= cs4270_mode_ratios[i].mclk;
> > +
> > +	if (cs4270->slave_mode)
> > +		reg |= CS4270_MODE_SLAVE;
> > +	else
> > +		reg |= cs4270_mode_ratios[i].speed_mode;
> 
> Shouldn't this be clearing MODE_SLAVE if it's in master mode? 

MODE_SLAVE is unset by the CS4270_MODE_SPEED_MASK mask:

#define CS4270_MODE_SPEED_MASK	0x30
#define CS4270_MODE_SLAVE	0x30

> Since
> we're doing a read/modify/write here it'd probably just be as easy to
> set or clear the bit when setting the DAI format rather than storing the
> data and setting it here.

I though so too, but the problem is that the bits that select the speed
mode are the same that select the slave mode. Hence, if I write to the
register in set_dai_fmt(), I'd have to add a special case in the other
part again. Doing it this looked much cleaner to me. Does that make
sense?

Daniel
