From: mark@undertone.org
Subject: Re: testers for SB Extigy wanted
Date: Fri, 11 Oct 2002 12:55:15 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021011175515.GA32611@undertone.org>
References: <s5hlm55ciee.wl@alsa2.suse.de> <20021011141312.GA31835@undertone.org> <s5hbs61cazj.wl@alsa2.suse.de> <20021011143659.GA31907@undertone.org> <s5h8z15c8uq.wl@alsa2.suse.de> <20021011153411.GA32132@undertone.org> <s5h7kgpc6bi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h7kgpc6bi.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 11, 2002 at 06:02:09PM +0200, Takashi Iwai wrote:
> > > 	% aplay -Dplughw:1,0 foo.wav
> > > 
> > > and for capture
> > > 
> > > 	% arecord -Dplughw:1,0 -fcd bar.wav
> > 
> > I'd love to do this, but:
> > 
> > atrophy:/etc/modutils# amixer -c1
> > amixer: Mixer load error: hw:1
> > atrophy:/etc/modutils# alsamixer -c1
> > 
> > alsamixer: function snd_mixer_load failed: Invalid argument
> > atrophy:/etc/modutils# 
> 
> hmm, could you run "alsactl store" and show the generated
> /etc/asound.state (only for the second card is enough)?
> at least we can see whether the controls are parsed properly.

atrophy:~# alsactl store
alsactl: get_control:194: Cannot read control '2,0,0,Digital In Playback Source,0': Invalid argument

As a result, the state file does not generate entries for the extigy.

> ah, i forgot that you're using devfs.  you need more config entry in
> devfs.conf for /dev/dsp1...  sorry, i cannot tell more, since i'm not
> a devfs expert.

That's ok, I can handle that.

> > - have the volume knob on the front of the device work 
> 
> usually such a "hardware" control is independent from the software
> stuff, so it may work regardless what driver does.

I'll tell you as soon as I can, heh. It's actually a software-based
knob however, and has no electronic "hardware" component a la
"standard" volume controls.

> > - be able to control the output detection of the unit. apparently it
> >   can tell if you have 2, 4, or 5 speakers hooked up into it. the option
> >   can certainly be automatic (testable when i unplug the card and use it
> >   as a standalone), and I'm fairly certain it can be forced as well (as
> >   evidenced in windows). When I was able to use the hardware with the 
> >   current rc release of alsa, it forced 2 speaker selection.
> 
> i think this is because only one format was parsed correctly.
> the other formats with 6 channels were not parsed by some reason.
> 
> but i'm not sure how the driver can detect the plug status...

To my knowlege, the only three states are 2, 4, and 5 speakers. This
is reflected in the driver provided by CL in windows. 

> > - the remote ir stuff is cute but not really essential -- would be nice to 
> >   have hooks to attach triggers to or something.
> 
> this will not be implemented on the usb audio driver.
> it's a role of another input-driver, and a corresponding daemon.

Yup, no problem, I'm sure I'll be able to handle that as well.

-mark


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
