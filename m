From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Broken emu10k/SB Live driver?
Date: Mon, 7 Oct 2002 20:20:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210072016410.1255-100000@pnote.perex-int.cz>
References: <20021007175818Z16477-7588+3006@nic.funet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021007175818Z16477-7588+3006@nic.funet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Juhana Sadeharju <kouhia@nic.funet.fi>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Oct 2002, Juhana Sadeharju wrote:

> Hello. There is something odd going on with emu10k/SB Live driver.
> I have drivers version 0.90rc1.
> 
> First, the capture faders and switches seems to not work as
> one could figure out by reading the "SB-Live-mixer.txt".
> Second, after unintuitively capturing the Drive/line-in2, the
> signal levels differs with respect to MS Windows drivers.
> 
> In MS Windows I have recorded audio from a tuner. The signal levels
> peaks approximately at -6 dB as one could expect from standard
> broadcasting. So, this could indicate that Alsa has something wrong,
> but I'm not sure. Because Alsa produces higher level signal, there
> is a change that Alsa is clipping/distorting the signal.
> 
> People like me who want to move from MS Windows to GNU/Linux
> thinks that it is the Alsa which works badly. You merely have to
> prove us that Alsa works ok. Please do so now.
> 
>  -*-
> 
> The signal paths should be so that it is possible to record
> the data directly from A/D converter without additional gains
> or filterings. Does Alsa work this way? Can you provide me
> a complete signal path diagram of the Alsa driver?

It should, but you know, all samples goes through the DSP, so it depends 
on the firmware.

>  -*-
> 
> There is something weird in the mixer with SB Live/line-in2:
> It does not make any difference even if recording mode
> is on or off, or if capture levels are 0 or 100.
> 
> The description in "alsa-kernel/Documentation/SB-Live-mixer.txt" and
> the real system does not match.
> 
> Well, it would be nice if the diagrams would look like the following:
> 
> 
>   capture <--------------------------------------------------
>               |      |      |                     |         |
>              mute   mute   mute                  mute      mute
>               |      |      |                     |         |
>             fader  fader  fader                 fader     fader
>               |      |      |                     |         |
>              line   line2  mic    etc.
> 
>   monitor <--------------------------------------------------
>               |      |      |                     |         |
>              mute   mute   mute                  mute      mute
>               |      |      |                     |         |
>             fader  fader  fader                 fader     fader
>               |      |      |                     |         |
>              line   line2  mic    etc.
> 
> 
> There is a Drive/line-in2 mute button in MS Windows but not in Alsa.
> Only way to mute is to turn the common recording/playing fader down,

What is common recording/playing fader? Name?

> in which case the recording is not possible (should be because I may
> only dislike listening). Note that the line-in2 capture fader and switch
> has no effect whatsoever -- because the system seems to be broken.
>
>
> This must also mean that it is not possible to apply effects to
> line-in2: because line-in2 cannot be muted I would hear both the
> line-in2 and the effect return (of effected line-in2), causing
> phase effects and other problems. Because wave is also missing
> the mute, what would be recorded? Perhaps not the plain line-in2,
> but mix of line-in2 and the effect return. How it is?
> It would be important to be able to record the line-in2 only.

Line2 cannot be muted for playback but can be turned off for capture.

>  -*-
> 
> Can somebody verify these problems? Plug audio input to Drive/line-in2
> and report the alsamixer settings when recording. Does the capture
> fader or switch affect the recording? Please, verify by trying.

I have no LiveDrive or LiveDrive II. It might be possible that I/O pins of 
EMU10K1 might be connected differently than our firmware expects. It might 
be bug of firmware or other.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
