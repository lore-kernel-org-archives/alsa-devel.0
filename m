From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] soc-dai: add bitfields for
	hardware	I2S formats
Date: Thu, 5 Mar 2009 10:53:57 +0000
Message-ID: <20090305105357.GB2416@sirena.org.uk>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<20090304223057.GD10731@sirena.org.uk>
	<20090304231223.GB20915@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DD43610386C
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 11:53:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304231223.GB20915@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 05, 2009 at 12:12:23AM +0100, Daniel Mack wrote:
> On Wed, Mar 04, 2009 at 10:30:58PM +0000, Mark Brown wrote:

> > devices on the link.  Have you considered handling this through that,
> > perhaps through adding a virtual thing to configure (eg, a
> > PXA_SSP_FRAME_CLOCKS)?

> I thought about that but then I condidered it's actually the wrong place
> for such a setting. I see two statements the board file has to make:

The other option would be to use the TDM mode interface to set this up
since that's roughly what it is; my main concern here is that we already
have two ways of doing this and I'd like to try to keep the number down
for consistency.

> It could be possible to express that in clk division rations, but it is
> actually a lot more straight forward to make that setting once rather
> then changing it over and over again.

I think it's all much of a muchness in terms of complexity whatever
option is chosen.

> > I guess cs4270.c ought to be enforcing this if it's added...

> cs4270.c would need that flag to be set or fail otherwise. Don't know if
> that really makes life easier for board support files that are not
> mainline. Want me to do that?

If this gets merged it's probably for the best (at least when it's in
slave mode).  Or add a hint to that effect.

> > FF_I2S should probably be something else since something might need this
> > for non-I2S devices - _BIT, perhaps?

> For non-I2S devices, we could re-use the same bit space as they will
> never appear in the same format word anyway, right?

Yes, I'm just thinking we should be able to use the same name for this
with every format.
