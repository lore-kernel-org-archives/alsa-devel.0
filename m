From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Re: [partialy fixed] Creamware Noah, snd-usb-audio
	capable?
Date: Wed, 18 Feb 2004 19:59:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077130780.4682.32.camel@chief.local>
References: <Pine.HPX.4.33n.0402180856160.27415-200000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402180856160.27415-200000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

Clemens Ladisch wrote:
> > Might the patch(the code in it) for usbaudio.c you posted before be
> > helpfull for the program?
> 
> No. Please remove the patch.
> 

Done, except of the entries in usbquirks.h. Is it still needed?
(OK, I fetched Kernel 2.6.3 today and made the entries there.)

> Then compile the attached program (it requires libusb), and run it by
> hand; after that, load snd-usb-audio.
> 

That worked perfectly. The device is switching to config 2,
snd-usb-audio is been loaded by the kernel, and the midi devices
appeared in kaconect. Six capture ports are available as well.

I recorded a wav with arecord via capture one and two. And it sounded
good.

With Rosegarden I played a song via the Noah Midi Out. And the device is
playing. ;-)

Now by playing around with the settings in the build-in menu of the
synthesizer, I discovered an entry named USBCom, that isn't described in
the (so far well done) manual. You can switch it between Windows and
Mac/Linux. I rememberd that I updated the firmware. (Now: 1.4.23, if
anyone else is interested) So this menu entry might belong to this
update.

OK, with this setting, it is _not_ necessary to switch the configuration
with your small but excellent tool to 2. There's now only _one_
configuration  available, which represents  the audio and midi devices.
(Former configuration 2)

The only thing that's missing now are the two playback ports.

---------- snip from /proc/asound/devices
128: [4- 0]: ctl
136: [4- 0]: raw midi
152: [4- 0]: digital audio capture
---------end of snip

BTW: I removed all snd-usb-audio related entries from modprobe.conf.
First to avoid snd-usb-audio is loaded by the alsasound script.
Second, not to get "empty cards" in /proc/asound 
I only left the snd cards_limit=6 for the maximum number of my
soundcards at all.

emu10k1 (used as my primary sounddevice)
intel8x0 (onboard, used only for midi In and Out)
ice1712 (used for hard disk recording)
virmidi
noah
midisport


Thank you very much for your excellent help to getting to this state of
a working device.

Kindly regards, Hartmut

-- 
Hartmut Geissbauer <nwgbh@swissonline.ch>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
