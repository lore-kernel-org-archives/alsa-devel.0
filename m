From: mark@undertone.org
Subject: Re: testers for SB Extigy wanted
Date: Fri, 11 Oct 2002 13:39:01 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021011183901.GA310@undertone.org>
References: <s5hlm55ciee.wl@alsa2.suse.de> <20021011141312.GA31835@undertone.org> <s5hbs61cazj.wl@alsa2.suse.de> <20021011143659.GA31907@undertone.org> <s5h8z15c8uq.wl@alsa2.suse.de> <20021011153411.GA32132@undertone.org> <s5h7kgpc6bi.wl@alsa2.suse.de> <s5h65w9c55m.wl@alsa2.suse.de> <20021011180023.GA32632@undertone.org> <s5hy994c09l.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hy994c09l.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 11, 2002 at 08:12:54PM +0200, Takashi Iwai wrote:
> please rebuild the alsa drivers with configure option
> "--with-debug=detect" ?  this will add more verbose debug outputs
> (ususally annoying).

Small typo in the patch, nothing big just a . that should be a >

> the attached patch will ignore the errors from the usb controller
> after a mixer control is inquired.  the error above shall be avoided
> by this patch.  please check the kernel messages.  so we can know
> which control is wrong, either wrongly inquired or due to a bug of usb
> controller module.

After I load the drivers:

Oct 11 13:36:48 atrophy kernel: PCI: Found IRQ 10 for device 00:08.0
Oct 11 13:36:49 atrophy kernel: usb.c: registered new driver snd-usb-audio
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:1: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:2 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:2: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:3 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:3: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:4 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:4: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:5 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:5: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:6 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:6: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:7 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:7: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:8 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:8: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:9 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:9: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:10 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:10: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:11 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:11: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:12 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:12: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:13 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:13: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:14 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:14: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:15 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:15: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1610: 4:1:16 : format type 0 is detected, processed as PCM
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:16: add audio endpoint 0x2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:2:1: add audio endpoint 0x86
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:2:2: add audio endpoint 0x86
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:2:3: add audio endpoint 0x86
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:2:4: add audio endpoint 0x86
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:2:5: add audio endpoint 0x86
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1601: 4:3:1 : format type 2 is not supported yet
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1601: 4:3:2 : format type 3 is not supported yet
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [2] FU [PCM Playback Switch] ch = 1, val = 0/1
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [2] FU [PCM Playback Volume] ch = 1, val = -25600/0
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:1370: [5] SU [Digital In Playback Source] items = 2
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [6] FU [Digital In Switch] ch = 1, val = 0/1
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [6] FU [Digital In Volume] ch = 1, val = -25600/0
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [8] FU [Line Playback Switch] ch = 1, val = 0/1
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [8] FU [Line Playback Volume] ch = 2, val = -25600/0
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [8] FU [Line Playback Volume] ch = 1, val = -25600/0
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:1167: [15] PU [3D Stereo Extender Switch] ch = 1, val = 0/0
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [10] FU [Mic Playback Switch] ch = 1, val = 0/1
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [10] FU [Mic Playback Volume] ch = 1, val = -25600/0
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:1167: [17] PU [Up Down Switch] ch = 1, val = 0/0
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:1167: [17] PU [Up Down Mode Select] ch = 1, val = 0/0
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:1370: [11] SU [Capture Source] items = 3
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [12] FU [Capture Switch] ch = 1, val = 0/1
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [12] FU [Capture Volume] ch = 1, val = -25600/0
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [18] FU [Master Playback Switch] ch = 1, val = 0/1
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [18] FU [Master Playback Volume] ch = 6, val = -25600/0
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [18] FU [Master Playback Volume] ch = 1, val = -25600/0
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [18] FU [Tone Control - Bass] ch = 1, val = -48/48
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [18] FU [Tone Control - Treble] ch = 1, val = -48/48
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [28] FU [Speaker Playback Switch] ch = 1, val = 0/1
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [22] FU [Digital Out Playback Switch] ch = 1, val = 0/1
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [23] FU [Digital Out1 Playback Switch] ch = 1, val = 0/1
Oct 11 13:36:49 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:808: [25] FU [Digital Out2 Playback Switch] ch = 1, val = 0/1

> also, please check /proc/asound/card0/stream* files again.
> now there should be more entries in them (is it only one?).

There is only one:

atrophy:/proc/asound/card1# more stream0 
Creative Technology Ltd. : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 2
    Format: S16_LE
    Channels: 3
    Endpoint: 2 OUT (ASYNC)
    Rates: 22050
  Interface 1
    Altset 3
    Format: S16_LE
    Channels: 5
    Endpoint: 2 OUT (ASYNC)
    Rates: 22050
  Interface 1
    Altset 4
    Format: S16_LE
    Channels: 5
    Endpoint: 2 OUT (ASYNC)
    Rates: 22050
  Interface 1
    Altset 5
    Format: S16_LE
    Channels: 6
    Endpoint: 2 OUT (ASYNC)
    Rates: 22050
  Interface 1
    Altset 6
    Format: S16_LE
    Channels: 6
    Endpoint: 2 OUT (ASYNC)
    Rates: 22050
  Interface 1
    Altset 7
    Format: S16_LE
    Channels: 3
    Endpoint: 2 OUT (ASYNC)
    Rates: 44100
  Interface 1
    Altset 8
    Format: S16_LE
    Channels: 5
    Endpoint: 2 OUT (ASYNC)
    Rates: 44100
  Interface 1
    Altset 9
    Format: S16_LE
    Channels: 5
    Endpoint: 2 OUT (ASYNC)
    Rates: 44100
  Interface 1
    Altset 10
    Format: S16_LE
    Channels: 6
    Endpoint: 2 OUT (ASYNC)
    Rates: 44100
  Interface 1
    Altset 11
    Format: S16_LE
    Channels: 6
    Endpoint: 2 OUT (ASYNC)
    Rates: 44100
  Interface 1
    Altset 12
    Format: S16_LE
    Channels: 3
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 13
    Format: S16_LE
    Channels: 5
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 14
    Format: S16_LE
    Channels: 5
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 15
    Format: S16_LE
    Channels: 6
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 16
    Format: S16_LE
    Channels: 6
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000
  Interface 2
    Altset 2
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 16000
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 24000
  Interface 2
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 32000
  Interface 2
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 48000


-mark



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
