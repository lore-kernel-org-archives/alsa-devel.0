From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Re: [partialy fixed] Creamware Noah, snd-usb-audio
	capable?
Date: Tue, 24 Feb 2004 20:07:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077649635.2433.1.camel@chief.local>
References: <Pine.HPX.4.33n.0402200947200.13625-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402200947200.13625-100000@studcom.urz.uni-halle.de>
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

Clemens Ladisch wrote:
> Hartmut Geissbauer wrote:
> > > > The only thing that's missing now are the two playback ports.
> > >
> > > Please show the output of "lsusb -v".
> >
> >       bInterfaceNumber        2
> >       iInterface              4 Noah Audio Out
> >       bAlternateSetting       1
> >         bFormatType             1 (FORMAT_TYPE_I)
> >         bNrChannels             2
> >         bBitResolution         16
> >         tSamFreq[ 0]        44100
> >           Transfer Type            Isochronous
> >           Synch Type               Asynchronous
> 
> The descriptors look OK.
> 
> Are there any messages in the system log (dmesg) when the driver is
> loaded?  If not, please compile ALSA again after running configure
> with the --with-debug=detect parameter, and try again.
> 
Please look at the messages attached. It seems, there's something odd with
the playback endpoint.

---------------------------------------------
usb 1-2.4: new full speed USB device using address 5
usb 1-2.4: new device strings: Mfr=1, Product=2, SerialNumber=0
drivers/usb/core/message.c: USB device number 5 default language ID
0x409
usb 1-2.4: Product: CreamWare Noah Synthesizer
usb 1-2.4: Manufacturer: CreamWare GmbH
drivers/usb/core/usb.c: usb_hotplug
usb 1-2.4: registering 1-2.4:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
usb 1-2.4: registering 1-2.4:1.1 (config #1, interface 1)
drivers/usb/core/usb.c: usb_hotplug
snd-usb-audio 1-2.4:1.1: usb_probe_interface
snd-usb-audio 1-2.4:1.1: usb_probe_interface - got id
ALSA sound/usb/usbaudio.c:2331: 5:2:1 : no or invalid class specific
endpoint descriptor
ALSA sound/usb/usbaudio.c:2392: 5:3:1: add audio endpoint 0x87
ALSA sound/usb/usbaudio.c:2392: 5:3:2: add audio endpoint 0x87
ALSA sound/usb/usbaudio.c:2392: 5:3:3: add audio endpoint 0x87
ALSA sound/usb/usbmidi.c:812: MIDIStreaming version 01.00
ALSA sound/usb/usbmidi.c:849: EP 81: 1 jack(s)
ALSA sound/usb/usbmidi.c:838: EP 02: 1 jack(s)
ALSA sound/usb/usbmidi.c:782: created 1 output and 1 input ports
usb 1-2.4: registering 1-2.4:1.2 (config #1, interface 2)
drivers/usb/core/usb.c: usb_hotplug
usb 1-2.4: registering 1-2.4:1.3 (config #1, interface 3)
drivers/usb/core/usb.c: usb_hotplug
usb 1-2.4: registering 1-2.4:1.4 (config #1, interface 4)
drivers/usb/core/usb.c: usb_hotplug
------------------------------------------------

Driver version: alsa 1.0.2c
kernel 2.6.3 (unpatched)
 
Kindly regards, Hartmut
-- 
Hartmut Geissbauer <nwgbh@swissonline.ch>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
