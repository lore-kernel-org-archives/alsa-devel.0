From: cliffw@easystreet.com
Subject: Re: usb-audio - kernel oops 2.5.72
Date: Tue, 24 Jun 2003 22:20:41 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306250520.h5P5KfXM005653@oldred.easystreet.com>
References: <tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Message from Takashi Iwai <tiwai@suse.de>
   of "Tue, 24 Jun 2003 11:54:51 +0200." <s5hk7bbx0k4.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: cliffw@easystreet.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> At Mon, 23 Jun 2003 23:54:46 -0700,
> cliffw@easystreet.com wrote:
> > 
> > > At Sun, 22 Jun 2003 20:45:09 -0700,
> > > cliffw@easystreet.com wrote:
> > > > 
> > > > 
> > > > Am attempting to get linux-2.5.72 + snd-usb-audio happening.

> > > please try the cvs version.

> 
> Takashi
> 
ALSA cvs + linux-2.5.72-mm3
-----------------
Startup and jackd start - dmesg
jackd --tmpdir=/mnt/ramfs -v -d alsa -d usb-audio:0,0 -r 44100
----------------------------
ehci_hcd 0000:00:10.3: GetStatus port 1 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:0: port 1, status 501, change 1, 480 Mb/s
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
hub 1-0:0: port 1 not reset yet, waiting 10ms
hub 1-0:0: port 1 not reset yet, waiting 10ms
ehci_hcd 0000:00:10.3: port 1 full speed --> companion
ehci_hcd 0000:00:10.3: GetStatus port 1 status 003801 POWER OWNER sig=j  
CONNECT
drivers/usb/host/uhci-hcd.c: d400: wakeup_hc
hub 2-0:0: port 1, status 101, change 1, 12 Mb/s
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 1, assigned address 3
usb 2-1: new device strings: Mfr=0, Product=1, SerialNumber=0
usb 2-1: Product: USB Audio
drivers/usb/core/usb.c: usb_hotplug
usb 2-1: usb_new_device - registering interface 2-1:0
drivers/usb/core/usb.c: usb_hotplug
snd-usb-audio 2-1:0: usb_device_probe
snd-usb-audio 2-1:0: usb_device_probe - got id
drivers/usb/core/usb.c: snd-usb-audio driver claimed interface c132652c
drivers/usb/core/usb.c: snd-usb-audio driver claimed interface c1326658
usb 2-1: usb_new_device - registering interface 2-1:1
drivers/usb/core/usb.c: usb_hotplug
usb 2-1: usb_new_device - registering interface 2-1:2
drivers/usb/core/usb.c: usb_hotplug
ALSA sound/usb/usbaudio.c:685: cannot submit datapipe for urb 0, err = -22
----------------------------------------
jackd
--------------------------------------
JACK compiled with System V SHM support
running with uid=500 and euid=0, will not try to use capabilites
1277 waiting for signals
loading driver ..
new client: alsa_pcm, id = 1 type 1 @ 0x80580e8 fd = -1
creating alsa driver ... usb-audio:0,0|1024|2|44100|swmon|swmeter|rt
open
port alsa_pcm:capture_1 has mixdown = 0x40017e70
registered port alsa_pcm:capture_1, offset = 4096
port alsa_pcm:capture_2 has mixdown = 0x40017e70
registered port alsa_pcm:capture_2, offset = 8192
port alsa_pcm:playback_1 has mixdown = 0x40017e70
registered port alsa_pcm:playback_1, offset = 0
port alsa_pcm:playback_2 has mixdown = 0x40017e70
registered port alsa_pcm:playback_2, offset = 0
++ jack_rechain_graph():
client alsa_pcm: internal client, execution_order=0.
-- jack_rechain_graph()
starting engine
ALSA lib pcm_hw.c:494:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed: Broken 
pipe
could not start playback (Broken pipe)
----------------------------------
aplay -D usb-audio:0,0 Peak.wav
Playing WAVE 'Peek.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
aplay: set_params:810: Channels count non available
---------------------------------------
ALSA sound/usb/usbaudio.c:685: cannot submit datapipe for urb 0, err = -22
------------------------------------------
cliffw





-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
