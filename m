From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Re: snd-usb-audio and midisport1x1 little hack fixes
	hotplug pb
Date: Tue, 16 Mar 2004 18:51:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1079459473.2579.7.camel@chief.local>
References: <Pine.HPX.4.33n.0403161750550.9632-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0403161750550.9632-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Mathieu Geli <geli@enseirb.fr>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Apparently, snd_usb_audio_disconnect hangs before returning.  Please
> try to insert printk's in snd_usbmidi_disconnect as Takashi suggestes.
> 

I removed the quick hack from Mathieu and inserted snd_printk's in snd_usbmidi_disconnect.

The new function:

void snd_usbmidi_disconnect(struct list_head* p, struct usb_driver *driver)
{
        snd_usb_midi_t* umidi;
        int i;

        umidi = list_entry(p, snd_usb_midi_t, list);
        snd_printk(KERN_INFO "after list_entry\n");

//      usb_driver_release_interface(driver, umidi->iface);
        for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
        snd_printk(KERN_INFO "in for with i=%d\n",i);

                snd_usb_midi_endpoint_t* ep = &umidi->endpoints[i];
                if (ep->out && ep->out->urb)
                        usb_unlink_urb(ep->out->urb);
                        snd_printk(KERN_INFO "usb_unlink_urb out\n");

                if (ep->in && ep->in->urb)
                        usb_unlink_urb(ep->in->urb);
                        snd_printk(KERN_INFO "usb_unlink_urb in\n");

        }
        usb_driver_release_interface(driver, umidi->iface);
        snd_printk(KERN_INFO "after usb_driver_release_interface\n");
}

The output from dmesg I got:

ohci_hcd 0000:00:02.0: urb e2e2b4c0 path 2.4 ep1in 5e160000 cc 5 --> status -110
hub 1-2:1.0: port 4, status 100, change 1, 12 Mb/s
usb 1-2.4: USB disconnect, address 5
usb 1-2.4: usb_disable_device nuking all URBs
usb 1-2.4: unregistering interface 1-2.4:1.0
ALSA sound/usb/usbaudio.c:2924: snd_usb_audio_disconnect called, refcount = 1
ALSA sound/usb/usbmidi.c:710: after list_entry
ALSA sound/usb/usbmidi.c:714: in for with i=0
usb 1-2.4: hcd_unlink_urb e2e2b640 fail -22
ALSA sound/usb/usbmidi.c:719: usb_unlink_urb out
usb 1-2.4: hcd_unlink_urb e2e2b4c0 fail -22
ALSA sound/usb/usbmidi.c:723: usb_unlink_urb in
ALSA sound/usb/usbmidi.c:714: in for with i=1
usb 1-2.4: hcd_unlink_urb e2e2b3c0 fail -22
ALSA sound/usb/usbmidi.c:719: usb_unlink_urb out
ALSA sound/usb/usbmidi.c:723: usb_unlink_urb in
ALSA sound/usb/usbaudio.c:2924: snd_usb_audio_disconnect called, refcount = 0


Remember this is the output for a 4x4. (If this matters)

Kindly regards, Hartmut




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
