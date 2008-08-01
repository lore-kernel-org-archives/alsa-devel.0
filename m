From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/14] ASoC: Allow codecs to override
	register display
Date: Fri, 1 Aug 2008 19:10:39 +0100
Message-ID: <20080801181037.GF11735@sirena.org.uk>
References: <20080801100003.GA16420@rakim.wolfsonmicro.main>
	<9e4733910808010750x69e71cd2i21eb0b448e11544a@mail.gmail.com>
	<s5hiquk4v4g.wl%tiwai@suse.de>
	<20080801153538.GA11735@sirena.org.uk>
	<s5hfxpo4twd.wl%tiwai@suse.de>
	<9e4733910808010913x46a4f57fm316b013984ac6b1c@mail.gmail.com>
	<20080801161613.GA2076@rakim.wolfsonmicro.main>
	<s5hd4ks4rrm.wl%tiwai@suse.de>
	<20080801171818.GD11735@sirena.org.uk>
	<9e4733910808011037n497e89adj4c6c04623de4b108@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E7C4D1037ED
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 20:10:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910808011037n497e89adj4c6c04623de4b108@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 01, 2008 at 01:37:09PM -0400, Jon Smirl wrote:
> On 8/1/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> >    For example, if we were to display a register value anywhere else a
> >    different interface would be required to allow codecs to override the
> >    display there.

> But you are stuck with the override. You don't know how to display or
> even read the 256 bit registers present on the TI chips.

Yes, absolutely - this is my point.  I have no problem at all with
having the ability to override the register display, it seems useful.

> There are more fundamental issues, struct snd_kcontrol doesn't have a
> field for storing the register address, it is being carried around in
> the private_value data.

Yes, I don't see the implementation being enormously elegant.  We should
have enough information to figure it out, though.
