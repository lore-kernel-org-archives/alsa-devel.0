From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/7] ASoC: Fix Zylonite voice
	interface	stereo configurations
Date: Wed, 25 Feb 2009 16:54:59 +0000
Message-ID: <20090225165458.GF31637@sirena.org.uk>
References: <20090225104701.GA20221@rakim.wolfsonmicro.main>
	<1235558902-20314-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20090225160617.GH11203@buzzloop.caiaq.de>
	<20090225162241.GE31637@sirena.org.uk>
	<20090225164113.GI11203@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C8E6B2438A
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 17:55:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090225164113.GI11203@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 25, 2009 at 05:41:13PM +0100, Daniel Mack wrote:

> Is there a thread you can point me to or where have people reported such
> things? Grep'ing the archives did unveil anything regarding this.

Private e-mail only, sorry.

> > The I2S frame length depends on the number of bits per sample.

> Well, as far as I got it, these are different things in the register
> set. The I2S frame is 64 bits per definition (32 bits for each channel),
> and this is what the cs4270 requires to use.

Ah, that's not true of I2S devices in general - most only require as
many bit clocks as they have data.  I've only ever tested with such
devices.

> The particular problem with the PXA SSP mode is that I've not yet seen a
> configuration (neighter in slave nor in master mode) where it sends out
> 16 bits of left channel information, followed by 16 bits of zeros, then
> 16 bits of right channel and finally another 16bits of zeros (which
> exactly what they talk about in the 'i2s via ssp' application note).
> Has anyone ever got that?

Not to my knowledge.
