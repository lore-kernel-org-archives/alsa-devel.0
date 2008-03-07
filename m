From: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Subject: Re: [Alsa-user] Newbie question - cannot get sound to
	work in Ubuntu
Date: Fri, 7 Mar 2008 16:15:11 +0100
Message-ID: <200803071615.11398.cave.dnb2m97pp@aliceadsl.fr>
References: <909985268.20080229192431@ptoye.com>
	<200803041943.43308.cave.dnb2m97pp@aliceadsl.fr>
	<275732031.20080305224831@ptoye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B1712460E
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 16:15:27 +0100 (CET)
In-Reply-To: <275732031.20080305224831@ptoye.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 05 March 2008 23:48, Peter Toye wrote:
> Nigel,
>
> Thanks. My comments are below.
>
> Best regards,
>
> Peter
> mailto:alsa@ptoye.com
> www.ptoye.com
>
> -------------------------
>
> Tuesday, March 4, 2008, 6:43:43 PM, you wrote:
> > Hi Peter. I've spent most of the afternoon (as I have nothing better to
> > do) googling your problem, and there are a few things you can try. First
> > though, do you have a live cd of Gutsy Gibbon, or Knoppix that you can
> > bootup with, and see if you have the sounds working?
>
> That's very kind of you to take so much time.
>
> I booted up from a live Gutsy Gibbon CD (the one I used to create my
> system) and it's quite interesting. Typing "alsamixer" in a terminal
> session brings up the mixer OK! But with a seriously confusing set of
> controls, only some of which seem to have much connection with the sound
> card. And the "line in" column in the "capture" view doesn't have a fader
> associated, which seems a bit odd. Maybe there's something I don't
> understand here.
>
> And I can use the GNOME utilities to record and play back. Didn't have time
> to try the command-line versions. Won't have time until Friday at the
> earliest.
>
> > Now moving on to my googling stuff.

> lspci -v output:
> 00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
> 07) Subsystem: Creative Labs CT4830 SBLive! Value
>         Flags: bus master, medium devsel, latency 64, IRQ 10
>         I/O ports at d400 [size=32]
>         Capabilities: [dc] Power Management version 1
>
> 00:0b.1 Input device controller: Creative Labs SB Live! Game Port (rev 07)
>         Subsystem: Creative Labs Gameport Joystick
>         Flags: bus master, medium devsel, latency 64
>         I/O ports at dc00 [size=8]
>         Capabilities: [dc] Power Management version 1

> > Alsamixer when opened shows the default card (card0), but have a look at
> > the manpages for alsamixer. I now open these in a webbrowser as
> > man:alsamixer. To start alsamixer for other cards you have the -c option.
> > For example, alsamixer -c0  brings up the default cards mixer settings.
> > alsamixer -c1 brings up the mixer settings for card 1, and so on.
>
> If I type alsamixer -c0 the mixer comes up with the same options as the CD
> boot (see above). I thought that -c0 was the default, but it doesn't seem
> to be.

Hi Peter. It's getting a bit surreal now, as typing alsamixer, is ( under 
normal circumstances)  the same as typing alsamixer -c0. For the sake of 
those on the alsa-devel list I've put the error you get when just typing 
alsamixer as user below.
Typing "alsamixer" in a terminal window gives:
"alsamixer: function snd_ctl_open failed for default: No such device"
Whereas typing alsamixer -c0 opens alsamixer.

At least you have access to the mixer settings now, although you say that some 
of the controls appear to be a bit bizarre.

Would you download this script from:
http://hg.alsa-project.org/alsa/raw-file/tip/alsa-info.sh

There are a bunch of options now available for the script, so after making it 
executable, run it as user as below.
./alsa-info.sh --with-amixer --with-alsactl --with-configs

The script will trawl out a bunch of stuff about your sounds, and upload it to 
pastebin. Just post back the link to the pastebin site when you reply.

Not sure about an easy Alsa guide.

All the best.

Nigel.
