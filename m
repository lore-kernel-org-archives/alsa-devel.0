From: Pavel Machek <pavel@ucw.cz>
Subject: Re: System with multiple arizona (wm5102) codecs
Date: Mon, 14 Sep 2015 22:11:21 +0200
Message-ID: <20150914201120.GA21210@amd>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150914115255.GE11200@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

> > I've got an embedded system with two arizona / wm5102 codecs.
> > 
> > Unfortunately, kernel does not seem to be ready for that
> > configuration.
> > 
> > In particular, drivers/regulator/arizona-ldo1.c and
> > drivers/regulator/arizona-micsupp.c register system-wide "MICVDD" and
> > "LDO1" regulators, but with two codecs in the system, we really have
> > wm5102-codec.1.MICVDD, wm5102-codec.2.MICVDD, wm5102-codec.1.LDO1 and
> > wm5102-codec.2.LDO1.
> > 
> > That got me second codec working in two-codec configuration, but first
> > one still stops working as soon as two codecs are enabled.
> > 
> > If you have idea what else needs fixing, let me know.
> > 
> > Best regards,
> 
> I must confess I haven't ever tested a system with two Arizona
> CODECs connected. Yes it seems you would get clashes on the
> regulator names, I guess that would need to be fixed up. If you
> were doing so wm831x-ldo.c would probably make a reasonable
> example.
> 
> I guess you would need to be careful with the machine driver as
> well, you will need to use a snd_soc_codec_conf structure for at
> least one (although I would do both) of the CODECs to give  a
> prefix for all the widget/control names, otherwise those will
> clash and everything will probably behave very strangely. See
> sound/soc/samsung/bells.c for an example doing this for wm9081.

Thanks a lot for pointers. I did split wm5102_dapm_widgets into two
structures, and modified them by hand (but probably did not get all
the right fields)... and thought that there must be better way.

> Those are the only two things that spring to mind at the moment
> but keep me informed on how you are getting on and I will let you
> know if I can come up with any other traps.

I guess I'll have to undo my horrible hacks, first.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
