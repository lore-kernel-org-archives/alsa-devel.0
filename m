From: "Edward Wildgoose" <Ed@Wildgooses.com>
Subject: Re: Digi96 Full Duplex problem with 16bit samples
Date: Tue, 22 Apr 2003 17:56:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <031901c308f0$16793000$cb40a8c0@FRiskMan.com>
References: <02d301c308e4$120d8ef0$cb40a8c0@FRiskMan.com> <200304221816.08151.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Yep, thanks.  I did that test already with aplay and arecord.  I didn't make
it clear, but that's what I meant by the "I have tested with aply +
arecord".  Thanks for confirming that this is OK though

I'm not sure how to debug this completely though.  The problem is actually
that something in mythtv is dying when trying to simultaneously open the
/dev/dsp device for reading and writing.  This works fine with my Audigy 1
under alsa, however, with the RME driver it mysteriously hangs or returns an
error message about being unable to set 16 bit samples.

I think I am reproducing this problem with the sox command below.  Could you
please try this on your setup and see if you get the same error?

This would appear to indicate that there is some sort of problem with 16 bit
full duplex OSS emulation?  Is there a better test I could do to narrow it
down to this being the problem?

It seems strange that this would be a problem on an RME card - if asked to
guess I would have assumed that it was hard to get the thing to run in less
than 16 bit mode!

Thanks

>
> Unfortunately, the analog part of my Digi96/8 PAD is broken (I only get
> noise), so I cannot test that it really works, however, I tried running
> these two commands at the same time:
>
> cat /dev/zero | aplay -D 'hw:0' -f S16_LE -c 2 -r 44100
> arecord -D 'hw:0' -c 2 -r 44100 -f S16_LE > /dev/null
>
> and it worked without complaints. Not much help... but I guess I can at
> least say that it is unlikely to be a problem in the rme96 driver.
>
> /Anders Torger
>
> On Tuesday 22 April 2003 17.30, Edward Wildgoose wrote:
> > I have a new Digi96/8 PAD card (very impressed with the sound
> > quality), however, I am trying to use it with MythTV to record and
> > playback TV. Either analogue recording or playback work fine, but any
> > attempt to do simultaneous analogue record AND playback is failing.
> >
> > I have tested with aplay + arecord and the card does full duplex
> > analogue without a problem.  The only difference with MythTv seems to
> > be that it uses OSS emulation via the /dev/dsp device (this is this
> > OSS isn't it?).  To try and simulate this I tried the following:
> >
> > gentoo linux-2.4.20 # sox -t ossdsp -r 44100 -w -c 2 /dev/dsp -t
> > ossdsp -r 44100 -w -c 2 /dev/dsp
> >
> > Which gives the error:
> > sox: Unable to set the sample size to 16
> >
> > If however, I remove the "-w" flag from the above then everything
> > works OK. It appears that full duplex works in 8 bit mode, but not 16
> > bit mode?
> >
> > Can anyone confirm or deny this, and is there a workaround to get
> > full duplex (other than coding up a proper ALSA layer for MythTv)? I
> > am using alsa 0.92 and I have also tried 0.90rc6 (and it's on gentoo
> > if this makes a difference).
> >
> > Any help would be appreciated,
>
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
