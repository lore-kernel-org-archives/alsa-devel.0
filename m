From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: snd-usb-audio hangs modprobe if switching dv camera
 betw. webcam / usb mass storage mode
Date: Mon, 01 Aug 2005 13:18:42 +0200
Message-ID: <42EE0512.6050302@gmx.de>
References: <42EC96D0.7050000@gmx.de> <42ECB0D7.4030409@gmx.de> <42EDD139.1000306@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42EDD139.1000306@gmx.de>
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
>>thomas schorpp wrote:
>>
>>
>>>hello,
>>>
>>>this bug is in conjunction with the older
>>>"usb disconnect hangs keyboard" bug on lkml.
>>>
>>>module-init-tools / hotplug hangs with snd-usb-audio if i switch/remove
>>>usb camera as stated above, if  a client like kmix is attached.
>>>(strange, since this device has no mixers here).
>>>

sorry wrong driver, done this:

Aug  1 13:11:18 tom1 kernel: usb 1-2: USB disconnect, address 22
Aug  1 13:11:18 tom1 kernel: ALSA sound/usb/usbaudio.c:3275:
snd_usb_audio_disconnect
Aug  1 13:11:18 tom1 kernel: ALSA sound/usb/usbaudio.c:3284: 1
Aug  1 13:11:18 tom1 kernel: ALSA sound/usb/usbaudio.c:3289: 2
Aug  1 13:11:18 tom1 kernel: ALSA sound/usb/usbaudio.c:3296: free

... kill kmix ...

Aug  1 13:12:51 tom1 kernel: ALSA sound/usb/usbaudio.c:3301: freed
Aug  1 13:12:52 tom1 kernel: usb 1-2: new full speed USB device using
uhci_hcd and address 23
Aug  1 13:12:52 tom1 kernel: scsi9 : SCSI emulation for USB Mass Storage
devices


static void snd_usb_audio_disconnect(struct usb_device *dev, void *ptr)
{
	snd_usb_audio_t *chip;
	snd_card_t *card;
	struct list_head *p;

	if (ptr == (void *)-1L)
		return;
	
	snd_printk(KERN_ERR "snd_usb_audio_disconnect\n");

	chip = ptr;
	card = chip->card;
	down(&register_mutex);
	chip->shutdown = 1;
	chip->num_interfaces--;
	if (chip->num_interfaces <= 0) {
		snd_card_disconnect(card);
	snd_printk(KERN_ERR "1\n");
		/* release the pcm resources */
		list_for_each(p, &chip->pcm_list) {
			snd_usb_stream_disconnect(p, &usb_audio_driver);
		}
	snd_printk(KERN_ERR "2\n");
		/* release the midi resources */
		list_for_each(p, &chip->midi_list) {
			snd_usbmidi_disconnect(p, &usb_audio_driver);
		}
		usb_chip[chip->index] = NULL;
		up(&register_mutex);
	snd_printk(KERN_ERR "free\n");
		snd_card_free(card); <----- HANGS HERE
	} else {
		up(&register_mutex);
	}
	snd_printk(KERN_ERR "freed\n");


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
