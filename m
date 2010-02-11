From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: safe support for rewind in ALSA
Date: Thu, 11 Feb 2010 14:52:52 +0800
Message-ID: <4f3252891002102252vb6d7a94l76fb78e33da37775@mail.gmail.com>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<20100201180139.GC15509@sirena.org.uk>
	<alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>
	<alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
	<alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>
	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
	<alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>
	<4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
	<4B72B665.3060903@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f171.google.com (mail-pz0-f171.google.com
	[209.85.222.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 30DB224396
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 07:52:54 +0100 (CET)
Received: by pzk1 with SMTP id 1so1059438pzk.16
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 22:52:52 -0800 (PST)
In-Reply-To: <4B72B665.3060903@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/10 Clemens Ladisch <clemens@ladisch.de>

> Raymond Yau wrote:
> > ...
> > The rest of those sound cards which have period_mins = 1 are regarded as
> > broken by PA developer  (e.g. intel8x0 ,emu10k1 , ens1371 , ... ) and
> aplay
> > did not work with one period per buffer too.
> >
> > what is the hardware requirement for the driver to support one period per
> > buffer ?
>
> That the hardware can be programmed to generate only one interrupt per
> buffer.
>
> > if none of the those driver can be fixed
> >  why don't we change the period_min of all those broken drivers from 1 to
> 2
> > ?
>
> Because period_min has nothing to do with the brokenness.  PA wants to
> use as few periods as possible because it does not use period interrupts
> but the DMA pointer, and it's the latter that is broken.
>
>
> Regards,
> Clemens
>

Are the one period per buffer designed for specific purpose such as
playing/looping the pre-loaded soundfont ?

Other than pulseaudio , are there any application use this mode  properly
without glitch ?

Do you mean that PA only wake up once when configure sound card to use two
periods per buffer ?

if sound card only support non-interleaved mode and exactly two periods ,
even if you limit the rewind of application pointer to the period boundary
is not 100% safe if the sound card pre-fetch audio using DMA

Most sound cards hardware register only provide the number of  sample
processed
