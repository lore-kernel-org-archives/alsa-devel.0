From: <Ashwin.Chandra@corel.com>
Subject: Re: Alsa Issue - Sound playback starts on left
	speaker	only
Date: Thu, 26 Jun 2008 05:02:09 +0800
Message-ID: <6AA7F928714999469B70E7707C87F82C5316C6@TW-EVS02.corelcorp.corel.ics>
References: <6AA7F928714999469B70E7707C87F82C531570@TW-EVS02.corelcorp.corel.ics><4860AF67.7060507@cox.net><6AA7F928714999469B70E7707C87F82C5315A8@TW-EVS02.corelcorp.corel.ics>
	<s5hlk0tolt4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from twmail.corel.com (twmail.corel.com [220.128.92.8])
	by alsa0.perex.cz (Postfix) with ESMTP id E9F7624498
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 23:01:56 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <s5hlk0tolt4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,
Some more findings: mplayer run in alsa native mode doesn't have the
issue. A dump of /proc/asound/.../sub0/* is identical in both my player
and mplayer-alsa mode, yet mine still suffers from left speaker issue.
Is there something I am not setting properly?


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Wednesday, June 25, 2008 3:23 AM
To: Ashwin Chandra
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Alsa Issue - Sound playback starts on left
speaker only

At Wed, 25 Jun 2008 01:52:16 +0800,
<Ashwin.Chandra@corel.com> wrote:
> 
> I have an Intel ALC861VD. Other players (mplayer, smplayer, aplay)
don't
> seem to exhibit this problem. Is there any workaround I can do in my
> application so that upon first time sound playback, I can get it to
play
> on both channels?

Check /proc/asound/card0/pcm0p/sub0/* files and compare between
working and non-working states.  I guess the working case uses OSS
emulation or 16bit format.

If so, try to add the following to ~/.asoundrc:

  defaults.pcm.dmix.format S16_LE


Takashi

> 
> -----Original Message-----
> From: stan [mailto:ghjeold_i_mwee@cox.net] 
> Sent: Tuesday, June 24, 2008 1:25 AM
> To: Ashwin Chandra
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Alsa Issue - Sound playback starts on left
> speaker only
> 
> Ashwin.Chandra@corel.com wrote:
> >  
> >
> > Hello,
> >
> > I am having an issue with my playback application where upon
playback
> > start, only the left speaker is outputted. But if I mute and unmute
> > (either through my application or using alsamixer), the sound
playback
> > resumes on both left and right speakers. This only happens on a
> > particular system too (out of 5 systems). But I know it is my issue
> > because mplayer or smplayer works fine.
> >
> >  
> >
> > I believe I am setting the correct HW params (ie. 2 channels), etc.
> >
> >  
> >
> > Any ideas?
> >
> >  
> >
> > Thanks!
> >
> >   
> The ICE1724 driver has exactly this behavior.  It is a known bug and
has
> 
> been there for years.
> You don't say what chip is having the problem, but I would guess that 
> this is it.  Most people
> just program a script to adjust the volume at startup to cure it.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
