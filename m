From: Peter L Jones <peter@drealm.org.uk>
Subject: Re: ALSA in 2.5.x
Date: Wed, 2 Oct 2002 18:54:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210021653.18662@advent.drealm.org.uk>
References: <Pine.LNX.4.33.0210021243280.653-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0210021243280.653-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wednesday 02 Oct 2002 11:44, Jaroslav Kysela wrote:
[snip]
> ALSA tree was fully synced with kernel yesterday. Not all changes are in
> 2.5.40. Please, wait for 2.5.41 or get the kernel sources from BitKeeper
> repository of 2.5.
>
> 						Jaroslav

Takashi,

The USB Audio/MIDI driver is out of date in 2.5.40bk1.

I'd go in and start coding a fix but it looks a little scary in there...  
(Okay, I admit it - I'm getting really rusty at C; these ".member = val" 
initialisers just look weird to me...)

-- Peter


Here's the usb_driver structure (from usb.h) with the usbaudio.c 
warnings/errors:

struct usb_driver {
        struct module *owner;
        const char *name;

        int (*probe) (struct usb_interface *intf,
                      const struct usb_device_id *id);
usbaudio.c:1311: warning: initialization from incompatible pointer type
ALSA: static void * usb_audio_probe(struct usb_device *dev, 
ALSA:                               unsigned int ifnum,
ALSA:                               const struct usb_device_id *id);

        void (*disconnect) (struct usb_interface *intf);
usbaudio.c:1312: warning: initialization from incompatible pointer type
ALSA: static void usb_audio_disconnect(struct usb_device *dev,
ALSA:                                  void *ptr);

        int (*ioctl) (struct usb_interface *intf, unsigned int code, void 
*buf);
        const struct usb_device_id *id_table;
        struct device_driver driver;
        struct semaphore serialize;

ALSA:        .driver_list =  LIST_HEAD_INIT(usb_audio_driver.driver_list),
ALSA: usbaudio.c:1313: structure has no member named `driver_list'
};



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
