From: Mark Knecht <markknecht@attbi.com>
Subject: Re: HDSP 9652 MIDI IN - stuck notes
Date: 28 Feb 2003 04:56:34 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046436995.1264.5.camel@Godzilla>
References: <1046321261.2626.28.camel@Godzilla>
	<s5h3cm8k3g7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cm8k3g7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2003-02-28 at 04:14, Takashi Iwai wrote:
> At 26 Feb 2003 20:47:41 -0800,
> Mark Knecht wrote:
> > 
> >    If I then change my keyboard to drive the HDSP 9652 input 1 (Alsa
> > 64:0) and change the connections internally to drive all of outputs, I
> > get stuck notes pretty much immediately. It seems a bit worse with the
> > sustain pedal, but does not seem to be effected at all by controllers.
> > It is heavily effected by the MIDI note density. If I hit only one or
> > two notes, I'm not likely to get it, but using the sustain pedal I can
> > create the problem in under a minute.
> > 
> >    To be sure it's the input and not the outputs (as much as I can be) I
> > have external synths attached to the Alsa outputs on 64:0, 72:0 and
> > 72:1. When I get a stuck note, I seem to get it on both internal soft
> > synths and all three external hardware synths at the same time. For this
> > reason I deduce that it is the HDSP input that is not clearing out
> > whatever event queue that holds this stuff and somehow the note never
> > shuts off.
> 
> to be sure, the configuration which doesn't work is like below, ok?
> 
> 	HDSP MIDI1 input -> softsynth
> 
> and/or
> 	
> 	HDSP MIDI1 input -> HDSP MIDI1 output -> external device

Both don't work, and when they fail, they both fail at the same time in
the same way, with a note stuck on. That's why I titled the thread HDSP
MIDI In - stuck notes. (I'm actually using MIDI 0, not MIDI 1)

                  -> softsynth
                  |
HDSP MIDI 0 ------
                  |
                  -> HDSP MIDI 0 output -> external synth

Using the USB MIDI in does not fail:

                  -> softsynth
                  |
MidiSport 0 ------
                  |
                  -> HDSP MIDI 0 output -> external synth

> 
> at least, we need to check whether the interrupts for MIDI are
> generated properly.
> please try the following.
> 
> 1. connect HDSP MIDI1 input to HDSP MIDI1 output via aconnect.
> 2. trigger a note from MIDI1 input.
>    check whether the IRQ count in /proc/interrupts (for HDSP)
>    increases.
>    during this test, don't use HDSP audio.
> 

mark@Godzilla card1]$ more /proc/interrupts
           CPU0
  0:      62488          XT-PIC  timer
  1:        816          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:        749          XT-PIC  usb-uhci, usb-uhci, usb-uhci, eth0
  8:          1          XT-PIC  rtc
 10:         94          XT-PIC  hdsp
 11:          5          XT-PIC  ohci1394
 12:       7033          XT-PIC  PS/2 Mouse
 14:       8556          XT-PIC  ide2
 15:       9005          XT-PIC  ide3
NMI:          0
ERR:          0
[mark@Godzilla card1]$



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
