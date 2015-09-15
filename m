From: Pavel Machek <pavel@ucw.cz>
Subject: Re: System with multiple arizona (wm5102) codecs
Date: Tue, 15 Sep 2015 10:35:52 +0200
Message-ID: <20150915083552.GA14780@amd>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
 <20150915061832.GA25442@amd>
 <20150915080648.GG11200@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150915080648.GG11200@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

> > > I must confess I haven't ever tested a system with two Arizona
> > > CODECs connected. Yes it seems you would get clashes on the
> > > regulator names, I guess that would need to be fixed up. If you
> > > were doing so wm831x-ldo.c would probably make a reasonable
> > > example.
> > > 
> > > I guess you would need to be careful with the machine driver as
> > > well, you will need to use a snd_soc_codec_conf structure for at
> > > least one (although I would do both) of the CODECs to give  a
> > > prefix for all the widget/control names, otherwise those will
> > > clash and everything will probably behave very strangely. See
> > > sound/soc/samsung/bells.c for an example doing this for wm9081.
> > > 
> > > Those are the only two things that spring to mind at the moment
> > > but keep me informed on how you are getting on and I will let you
> > > know if I can come up with any other traps.
> > 
> > It seems that davinci-evm takes data from device tree, but then uses
> > statically-allocated evm_soc_card, which would lead to problems in
> > dual-codec config....?
> 
> That somewhat depends on how you plan on doing things. I had
> assumed you would be having a single machine driver with both
> CODECs connected to it, in which case the statically allocated
> snd_soc_card wouldn't be a problem. However, if you wanted to
> have two seperate machine drivers with a single CODEC connected
> to each then you would have an issue.
> 
> I guess either approach is reasonable and probably just depends
> on what your end goal is.

The way dts is set up in my case, I ended up with two
snd_soc_cards. It seems to work for me now (on old kernel and with
some rather extreme hacks).

I'll most likely clean it up and get into mainline-ready form, but it
will take some time. If you want to see the ugly patches, let me know.

Thanks and best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
