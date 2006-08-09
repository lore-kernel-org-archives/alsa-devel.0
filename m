From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ALSA problems with 2.6.18-rc3
Date: Wed, 09 Aug 2006 16:57:15 -0400
Message-ID: <1155157036.26338.200.camel@mindpipe>
References: <44D8F3E5.5020508@ukonline.co.uk>
	 <200608091417.55431.gene.heskett@verizon.net>
	 <1155156090.26338.193.camel@mindpipe>
	 <200608091651.28077.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751081AbWHIU5V@vger.kernel.org>
In-Reply-To: <200608091651.28077.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Andrew Benton <b3nt@ukonline.co.uk>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-08-09 at 16:51 -0400, Gene Heskett wrote:
> On Wednesday 09 August 2006 16:41, Lee Revell wrote:
> [...]
> >> >Takashi-san,
> >> >
> >> >Does this help at all?  Many users are reporting that sound broke with
> >> >2.6.18-rc*.
> >> >
> >> >Lee
> >>
> >> Takashi-san's suggestion earlier today of running an "alsactl -F
> >> restore" seems to have fixed all those diffs right up, I now have good
> >> sound with an emu10k1 using an audigy 2 as card-0, running
> >> kernel-2.6.18-rc4.
> >
> >Distros should probably be using this as a default.  Otherwise, simply
> >adding a new mixer control will cause restoring mixer settings to fail.
> >
> >Lee
> 
> I already have the 'alsactl restore' in my rc.local.  Would there be any 
> harm in just adding the -F to that invocation, or will that just restore 
> it to a 'default' condition always.  Seems like it would, canceling 
> anything you have done & then did an 'alsactl store' to save..
> 

That's what I was suggesting - just add -F to the alsactl restore in
your init script.  It won't restore it to a default state - the only
difference is that it will do a better job restoring your mixer state if
new controls are added by a driver update.

alsactl --help:

  -F,--force      try to restore the matching controls as much as
possible

Lee
