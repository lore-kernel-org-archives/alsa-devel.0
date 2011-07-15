From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8983: Initial driver
Date: Fri, 15 Jul 2011 16:14:22 +0100
Message-ID: <20110715151422.GA989@opensource.wolfsonmicro.com>
References: <1310734290-21216-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20110715144738.GC11154@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 76E742412D
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jul 2011 17:14:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110715144738.GC11154@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 15, 2011 at 11:47:41PM +0900, Mark Brown wrote:
> On Fri, Jul 15, 2011 at 01:51:30PM +0100, Dimitris Papastamos wrote:
> > The WM8983 is a low power, high quality stereo CODEC
> > designed for portable multimedia applications. Highly flexible
> > analogue mixing functions enable new application features,
> > combining hi-fi quality audio with voice communication.
> 
> I've applied this but there's one issue you should fix up later:
> 
> > +	/* mute all outputs and set PGAs to minimum gain */
> > +	for (i = WM8983_LOUT1_HP_VOLUME_CTRL;
> > +	     i <= WM8983_OUT4_MONO_MIX_CTRL; ++i)
> > +		snd_soc_update_bits(codec, i, 0x40, 0x40);
> 
> I know you're doing this to minimise artifacts on initial bias raise but
> we should really be doing this without affecting the default register
> settings.

Well, what about using the cache_bypass option to write directly to the
HW?

Thanks,
Dimitris
