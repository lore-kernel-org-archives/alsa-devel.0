From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add MAX9850 codec driver
Date: Mon, 7 Mar 2011 17:14:55 +0000
Message-ID: <20110307171455.GI1829@sirena.org.uk>
References: <1299501913-3772-1-git-send-email-christian.glindkamp@taskit.de>
	<20110307134857.GA16691@opensource.wolfsonmicro.com>
	<20110307170420.GC7619@taskit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7583A244D7
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 18:14:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110307170420.GC7619@taskit.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Glindkamp <christian.glindkamp@taskit.de>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2011 at 06:04:20PM +0100, Christian Glindkamp wrote:

> As all ready said, I can't really test these changes at the moment but
> will at least compile test them. Additionally, alsa master currently
> does not build here for the arm architecture. Further comments below.

I'm not sure what tree you're building against but mainline ASoC builds
fine on ARM.  ASoC changes should be against the latest for- branch of:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

(see MAINTAINERS).

> > > +	/* enable zero-detect */
> > > +	snd_soc_update_bits(codec, MAX9850_GENERAL_PURPOSE, 1, 1);
> > > +	/* enable charge pump, disable everything else */
> > > +	snd_soc_write(codec, MAX9850_ENABLE, 0x30);

> > DAPM?

> Charge pump could also be a supply for the Output Mixer. Have to find
> out how to toggle two bits at once via dapm (preferably without
> resorting to callbacks).

If you implement two widgets of the same type DAPM will try to compress
them down into a single register write when updating so the effect will
be to do a single update to both bits.
