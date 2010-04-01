From: Daniel Mack <daniel@caiaq.de>
Subject: Re: C-Media CMI8738-LX noise in recording from line in
Date: Thu, 1 Apr 2010 13:14:04 +0200
Message-ID: <20100401111404.GK30801@buzzloop.caiaq.de>
References: <20100401031825.557be2bc@romy.gusto> <4BB46CE6.1000103@ladisch.de>
	<20100401130055.2a9d616e@romy.gusto>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 417F110388A
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 13:14:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100401130055.2a9d616e@romy.gusto>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars Schotte <lars.schotte@schotteweb.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(please don't top-post)

On Thu, Apr 01, 2010 at 01:00:55PM +0200, Lars Schotte wrote:
> OK. but the question is, does it put noise in recording in windows as
> well?

Does it? Given that nobody else here happens to have the same audio
card, I believe you're on your own to find out whether this is a
hardware or driver issue.

> I maybe solved it w/ activating the old hd audio integraded snd
> card, whichs broken, but line-in works and i tried it recording w/ it
> and that works perfectly. you say, that the cards never going to have a
> good sound quality. I am sure it doesnt, but what I am getting isnt
> even good enough. there is written on the box that I can record with it
> in 44khz and so on, cd quality and whatever, so is it a lie?

"44khz and so on" just tells you how the ADC/DAC works, it says nothing
about the analog audio performance. So, vendors can screw the entire
analog path and still claim they operating on CD quality digitally, yes.
Welcome to the real world.

> i tried out manipulating w/ the mixer, believe me, however, i ll post
> some output later, but the settings can not be set better, because the
> only relevant setting here is the line-in and that is already on
> maximum. the second thing that i dont understand about this card is,
> that when I play sth at line-in, the sound is perfect, but the
> recording is crappy. so does it have a line-in to line-out passthrough?

Is there any software active to enable that pass-thru? Or is that a
hardare feature?

> but then hows that possible that I can regulate it on my mixer and even
> mute line-in completely?

Maybe you should provide the output you have been asked for, namely
your mixer settings and the output of the alsa-info.sh script.

And the information about how the same hardware performs under Windows
would also help you and other understand where the problem might be.

HTH,
Daniel


> On Thu, 01 Apr 2010 11:52:38 +0200
> Clemens Ladisch <clemens@ladisch.de> wrote:
> 
> > Lars Schotte wrote:
> > > The soundcard has following chipset - C-Media CMI8738-LX.
> > 
> > This chip was designed before on-board sound devices were common, and
> > manages to have worse analog sound quality than many of those,
> > especially on its inputs.
> > 
> > > So I try to record from the line in input, ...
> > > its too silent and there is a lot of noise in it.
> > 
> > Even if your current mixer settings are suboptimal and can be improved
> > (please show the output of "amixer contents" or the alsa-info output),
> > be aware that this card never will have good quality.
> > 
> > 
> > Regards,
> > Clemens
