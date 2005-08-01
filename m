From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: snd-usb-audio hangs modprobe if switching dv camera
 betw. webcam / usb mass storage mode
Date: Mon, 01 Aug 2005 09:37:29 +0200
Message-ID: <42EDD139.1000306@gmx.de>
References: <42EC96D0.7050000@gmx.de> <42ECB0D7.4030409@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42ECB0D7.4030409@gmx.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

thomas schorpp wrote:
> thomas schorpp wrote:
> 
>>hello,
>>
>>this bug is in conjunction with the older
>>"usb disconnect hangs keyboard" bug on lkml.
>>
>>module-init-tools / hotplug hangs with snd-usb-audio if i switch/remove
>>usb camera as stated above, if  a client like kmix is attached.
>>(strange, since this device has no mixers here).
>>
>>if its not unavoidable, pls fix soon, thx. vanilla kernel 2.6.12.0.
>>
>>Jul 31 10:35:58 tom1 kernel: usb 1-2: USB disconnect, address 3
>>...
>>killall kmix
>>...
>>
>>Jul 31 10:42:08 tom1 kernel: usb 1-2: new full speed USB device using
>>uhci_hcd and address 4
>>Jul 31 10:42:08 tom1 kernel:
>>/usr/src/spca5xx-20050701/drivers/usb/spca5xx.c: USB SPCA5XX camera
>>found. Aiptek DV3500 Mpeg4
>>Jul 31 10:42:08 tom1 kernel:
>>/usr/src/spca5xx-20050701/drivers/usb/spca5xx.c: [spca5xx_probe:8652]
>>Camera type JPEG
>>Jul 31 10:42:08 tom1 kernel: ALSA sound/usb/usbaudio.c:2570: 4:3:1: add
>>audio endpoint 0x86
>>
>>y
>>tom
>>
> 
> 
> /*
>  * Frees the device.
>  */
> static void usX2Y_usb_disconnect(struct usb_device* device, void* ptr)
> {
> 	if (ptr) {
> 		usX2Ydev_t* usX2Y = usX2Y((snd_card_t*)ptr);
> 		struct list_head* p;

xxx check busy here and return "-EIBUSY" xxx ?


> 		usX2Y->chip.shutdown = 1;
> 		usX2Y->chip_status = USX2Y_STAT_CHIP_HUP;
> 		usX2Y_unlinkSeq(&usX2Y->AS04);
> 		usb_kill_urb(usX2Y->In04urb);
> 		snd_card_disconnect((snd_card_t*)ptr); <--- err handler? (1)
> 		/* release the midi resources */
> 		list_for_each(p, &usX2Y->chip.midi_list) {
> 			snd_usbmidi_disconnect(p, &snd_usX2Y_usb_driver);
> 		}
> 		if (usX2Y->us428ctls_sharedmem)
> 			wake_up(&usX2Y->us428ctls_wait_queue_head);
> 		snd_card_free((snd_card_t*)ptr); <---- hang
> 	}
> }
> 

> 	/* wait, until all devices are ready for the free operation */
> 	wait_event(card->shutdown_sleep, card->files == NULL); <--- hang
> 

PEOPLE, i know its common unix behaviour not to remove busy drivers with
files open,
but You cant just hang the whole usb-system and modprobe then with an
infinite signal wait.

the driver *must not* enter the disconnection it must signal modprobe /
hotplug to print a "busy" message and return.

y
tom








-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
