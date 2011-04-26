From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-dsp questions
Date: Tue, 26 Apr 2011 11:18:49 +0100
Message-ID: <20110426101848.GA23812@sirena.org.uk>
References: <BANLkTi=jmoZOvxe=29Et=C6YYHrFZ58evw@mail.gmail.com>
	<1303810865.3332.57.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AA7A24332
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 12:18:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1303810865.3332.57.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: pl bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 26, 2011 at 10:41:05AM +0100, Liam Girdwood wrote:
> On Mon, 2011-04-25 at 17:01 -0500, pl bossart wrote:
> > To prepare next week's ALSA-Asoc meeting, I reviewed Liam's
> > dsp-upstream code, and I am a bit unclear on the 'no_host_mode'
> > supported by some DAIs. Apparently these are regular ALSA PCM
> > substreams, except that there are no data exchanges to/from the host.

> Ah, this part is WIP and will not be part of the initial submission. We
> are currently using this for audio between the MODEM and ABE that does
> not pass through the CPU. 

This is roughly the same thing I've been talking about for digital DAPM
links.  I've got code which runs at the minute but the implementation
sucks too much, should be able to pull out some of the preparation work
in the next day or so.

> > - is this really important that such PCM devices be known in
> > userspace? Or are they declared only so that ALSA controls are enabled
> > for these streams?

> The intention is that userspace apps would know there is no data, but
> this is probably better discussed at conference. It may also require an
> alsa-lib update too.

Personally I think we should just hide them, but it's fairly painful to
do that immediately due to the ALSA core infrastructure we're using.  If
we refactor to reduce this or to support masking PCMs in the core this
should be less of an issue.
