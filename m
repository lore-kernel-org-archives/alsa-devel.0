From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Fri, 22 Feb 2013 00:22:30 +1030
Message-ID: <20130221135230.GA12678@marvin.atrad.com.au>
References: <s5hzjzbql3a.wl%tiwai@suse.de>
 <20130216112505.GE4164@marvin.atrad.com.au>
 <s5h8v6ncpcp.wl%tiwai@suse.de>
 <20130217125316.GA25824@marvin.atrad.com.au>
 <s5h1ucedgge.wl%tiwai@suse.de> <s5hzjyzi8a5.wl%tiwai@suse.de>
 <20130220121055.GA23804@marvin.atrad.com.au>
 <s5hip5ni0ur.wl%tiwai@suse.de>
 <20130221121540.GA11524@marvin.atrad.com.au>
 <CAN8ccibAsWUVCcEem-ykcouJ6RXEG8k-eq9mPf7VV7qPied6nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 88113265005
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 14:52:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAN8ccibAsWUVCcEem-ykcouJ6RXEG8k-eq9mPf7VV7qPied6nw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, jwoithe@just42.net, peter.golden@btinternet.com, ullinux@ymail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 21, 2013 at 09:24:05PM +0800, Raymond Yau wrote:
> > > > > FYI, sound-unstable git tree test/hda-hp-mic branch contains the new
> > > > > patches.  Pass model=fujitsu-jwse option, and all features will be
> > > > > enabled
> >
> > I was able to test sound-unstable this evening (reporting a kernel version
> > of 3.8.0-rc7+).  I passed "model=fujitsu-jwse" as instructed.  The
> > "Headphone Mic" mode switch influences the headphone jack when it's
> > configured as an input as I expect is the intent.  The speaker still works
> > and the speaker/headphone controls behave as expected.  In short there
> > appear to be no regressions in these respects.
> 
> Can you confirm that the speaker really need this patch to work ?
> 
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=978e77e78cff7a85a31ad552ffd8afee319e8721

No.  The speaker required this patch:

  http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=e6e0ee507f630350d883bb3343e78cab30cad5e2

My point was that the latest code revision hasn't broken speaker and
headphone behaviour compared to that which I tested a few days ago.

The patch you referenced appears related to the ability to manually control
the mode of headphone pins.  This was a separate issue.

> Does the headphone Jack or Mic Jack  support imedpance sense to
> differentiate the Jack type or not  ?

To be honest I have no idea.  I have no personal interest in leaving this
decision up to automatic impedence sensing and so I have not looked into it. 
Even if the hardware was up to it it is important to retain the ability to
manually configure the jack mode, knowing that it will not change modes
automatically under any circumstances.  Live performance situations are
notorious for making automatic detectors do strange things at inopportune
times.

How can one tell if impedence sense is supported?

> The behaviour of this notebook and e8020 will be different from other
> notebook

In what way?  Is this related to the impedence sensing?

Even if impedence sensing is supported I think it's important that we don't
loose the ability to manually set jack modes.

> No auto Mic selection because CD and non detectable dock line in

That doesn't bother me for the same reasons as above.

Regards
  jonathan
