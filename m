From: mark@undertone.org
Subject: Re: Re: btw
Date: Thu, 17 Oct 2002 09:44:40 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021017144440.GA14352@undertone.org>
References: <20021014191214.GB6704@undertone.org> <20021014192959.GA6792@undertone.org> <20021014193407.GA6821@undertone.org> <s5h8z106km8.wl@alsa2.suse.de> <20021015175750.GA8918@undertone.org> <s5hof9u666f.wl@alsa2.suse.de> <20021016194055.GA11982@undertone.org> <s5h8z0x5v3r.wl@alsa2.suse.de> <20021017134235.GA14241@undertone.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20021017134235.GA14241@undertone.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In a bit of good news, although playing back streams dont really want
to work, if I use the line in on the card and shove in the output from
my onboard sound card, I actually get sound of the card now while it
is connected via usb to the laptop. Earlier, the only way to get sound
of the card while booted into linux was to disconnect it completely
and use it as a stand-alone device in the same manner. As a result, I
can test a couple of the mixer settings for you. I'm using alsamixer
for this, doing it by hand via amixer would take a while . . .

The first 4 master controls control front,back, and center-woofer. Not
sure about the exchange with the last two, I only have a 4.1 sound
system hooked up into the device. "Master 1" is a general master that
controls all sound. Bass and treble follow... The PCM interface I
can't test, due to the same earlier problems. Line and Line 1 seem to
do the same thing for me at the moment. I would guess that "line" is
for the specific line in 1/8 jack im using in the front of the unit,
and that "line 1" is a general control for all input lines... it didnt
control the mic though. Only the "Mic" control controls the mic. 

Now on to the "odd" stuff ... I cant test the digital in and outs. I
just don't have another optical audio device here. The "Speaker"
interface seems like a master mute button. All other interfaces, uh,
don't seem to do anything. If you can suggest better ways to test, I'm
all ears. I could do more extensive testing if you like, but uh hmm
not sure exactly how the logistics of that would work out in real
life, heh.

Still cant seem to control the CMSS functionality (fake surround
sound). When the sound card has the usb hooked into the machine, the
CMSS switch is "locked" into whatever state it was in before
communicating with the machine. If its any hint, it would appear as
though all the front-panel controls (except the power) are disabled
once the device is communicating via usb. This includes the CMSS
button and two software-controled gain knobs for the Mic and master
volume. I say software controled because there is no internal,
traditional "hardware" mechanism with the knobs, its just a physical
interface to the gain levels I can otherwise control via software.

-Mark

(I have a feeling that the pcm in/out works just fine and I'm not
using the alsa software properly . . )


On Thu, Oct 17, 2002 at 08:42:35AM -0500, mark@undertone.org wrote:
> On Thu, Oct 17, 2002 at 10:26:48AM +0200, Takashi Iwai wrote:
> > ah, since 8000Hz 8 bit is not supported on this device.
> > please use plughw instead of hw, that is,
> > 
> > 	% aplay -Dplughw:1,0 foo.wav
> 
> atrophy:~# aplay -Dplughw:1,0 foo.wav
> Playing raw data 'foo.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
> ALSA lib pcm_hw.c:428:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE failed: Invalid argument
> aplay: set_params:813: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  U8
> SUBFORMAT:  STD
> SAMPLE_BITS: 8
> FRAME_BITS: 8
> CHANNELS: 1
> RATE: 8000
> PERIOD_TIME: (124988 124989)
> PERIOD_SIZE: (999 1000)
> PERIOD_BYTES: (999 1000)
> PERIODS: (4 5)
> BUFFER_TIME: 500000
> BUFFER_SIZE: 4000
> BUFFER_BYTES: 4000
> TICK_TIME: 10000
> atrophy:~# 
> 
> I've tried an entire array of different wav's in different formats,
> all with similar debugging output.
> 
> I've also tried installing various modules and drivers in a vain and
> blind attempt to just get it to play the stream. What "is supported"
> natively by the driver?
> 
> > for the control (mixer) interface, no second zero, that is, use
> > '-Dhw:1'.  (btw, it's equitvalent "amixer -c 1").
> 
> Yes, I've been able to mix the thing properly now. Thanks. Uh, I'm
> guessing the code is the best place to actually get a decent
> description why this is?
> 
> > > I compiled both controler modules and have tried using them
> > > interchangably. Same result. There is no difference in the stream0
> > > file - checked with a diff.
> > 
> > you can check this also via the output of 'lsusb -v'.
> 
> Only differences were fairly cosmetic:
> 
> atrophy:~/alsa# diff uhci usb-uhci 
> 15c15
> <   iProduct                2 USB UHCI-alt Root Hub
> ---
> >   iProduct                2 USB UHCI Root Hub
> 50c50
> < Bus 001 Device 002: ID 041e:3000 Creative Labs 
> ---
> > Bus 001 Device 005: ID 041e:3000 Creative Labs 
> 
> I had to disconnect my minihub and connect only the extigy by itself
> in order to use the usb-uhci driver. I normally only use uhci, as I
> need to use a usb mouse and the extigy, which requires a hub that
> doesnt like usb-uhci.
> 
> Given the output above, I'm probably doing something rather silly
> again with regards to some kind of random compatibility issue. I am
> still running the mixer with the debug hack you put in.
> 
> -mark
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: viaVerio will pay you up to
> $1,000 for every account that you consolidate with us.
> http://ad.doubleclick.net/clk;4749864;7604308;v?
> http://www.viaverio.com/consolidator/osdn.cfm
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
