From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Re: Creamware Noah, snd-usb-audio capable?
Date: Tue, 17 Feb 2004 18:04:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077037445.3938.15.camel@chief.local>
References: <Pine.HPX.4.33n.0402171255310.21550-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402171255310.21550-100000@studcom.urz.uni-halle.de>
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
> > I tried it vice versa. (first unloading snd-usb-audio then plugging the
> > device)
> > Now it appears in /proc/bus/usb/devices
> 
> I guess "it" is the device and not the audio interfaces.
> 

OK, the device. But to me it looks like, the audio interfaces are
detected correctly as well.

-------------snip-------------------------- 
T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  2
P:  Vendor=1107 ProdID=0102 Rev= 1.00
S:  Manufacturer=CreamWare GmbH
S:  Product=CreamWare Noah Synthesizer
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 6 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=   8 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=   8 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
C:  #Ifs= 5 Cfg#= 2 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 4 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=83(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
I:  If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
I:  If#= 2 Alt= 1 #EPs= 2 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
E:  Ad=08(O) Atr=05(Isoc) MxPS= 184 Ivl=1ms
E:  Ad=89(I) Atr=01(Isoc) MxPS=   3 Ivl=1ms
I:  If#= 3 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
I:  If#= 3 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
E:  Ad=87(I) Atr=0d(Isoc) MxPS= 184 Ivl=1ms
I:  If#= 3 Alt= 2 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
E:  Ad=87(I) Atr=0d(Isoc) MxPS= 368 Ivl=1ms
I:  If#= 3 Alt= 3 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
E:  Ad=87(I) Atr=0d(Isoc) MxPS= 552 Ivl=1ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=   8 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=   8 Ivl=0ms
--------------------snip end -----------------

> > But the output /var/log/messages seems a little bit bad in the end.
> >
> > kernel: usb 1-2.4: configuration #1 chosen from 2 choices
> > kernel: usb 1-2.4: registering 1-2.4:1.0 (config #1, interface 0)
> > kernel: drivers/usb/core/usb.c: usb_hotplug
> > usb.agent[2413]: Keeping default configuration with /sys//devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2.4
> > kernel: snd-usb-audio 1-2.4:1.0: usb_probe_interface
> > kernel: snd-usb-audio 1-2.4:1.0: usb_probe_interface - got id
> > kernel: usb 1-2.4: usb_disable_device nuking non-ep0 URBs
> > kernel: usb 1-2.4: unregistering interface 1-2.4:1.0
> 
> The last two lines _may_ be correct when the configuration changes.
> 
> Could you try to re-load snd-usb-audio (now, hopefully, with the new
> configuration)?
> 

No I'm not able, because snd-usb-audio is in use. Don't ask me from
whom. lsmod won't tell me.

Module                  Size  Used by
snd_usb_audio          70710  1

ERROR: Removing 'snd_usb_audio': Device or resource busy

It isn't released even if I unplug the device. 

> 
> If that doesn't work, it would be possible to write a separate program
> that switches the configuration, so that the audio driver can be
> loaded later.
> 
Am I right, that this separate program is handled by hotplug?

Might the patch(the code in it) for usbaudio.c you posted before be
helpfull for the program?

BTW: How many devices/"cards" is the snd-usb-audio driver able to
handle?

Regards, Hartmut

-- 
Hartmut Geissbauer <nwgbh@swissonline.ch>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
