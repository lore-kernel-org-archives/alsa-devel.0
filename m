From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: [PATCH] snd-usb-us122l v0.4 for US-122L
Date: Tue, 15 Apr 2008 16:48:34 +0200
Message-ID: <200804151648.34466.fzu@wemgehoertderstaat.de>
References: <200803161956.42461.fzu@wemgehoertderstaat.de>
	<200804142129.54800.fzu@wemgehoertderstaat.de>
	<s5hfxtngq83.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 89C2D103804
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 16:48:42 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so3717926fka.0
	for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2008 07:48:39 -0700 (PDT)
In-Reply-To: <s5hfxtngq83.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 15. April 2008 schrieb Takashi Iwai:
> At Mon, 14 Apr 2008 21:29:54 +0200,
> Karsten Wiese wrote:
> > 
> > Hi,
> > 
> > there are 2 fixes since v0.3 here:
> >  - compiles & works for x86 32bit again.
> >  - hardware configuration is done via ioctl() instead of write().
> >    Fixing a bug that led to jackd not starting again after a stop.
> 
> diff --git a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
> index 6676a17..3c55dea 100644
> --- a/sound/usb/usbmidi.c
> +++ b/sound/usb/usbmidi.c
> (snip)
> +static void snd_usbmidi_us122l_output(struct snd_usb_midi_out_endpoint *ep)
> (snip)
> +	while (count < 9)
> +		((char *)ep->urb->transfer_buffer)[count++] = 0xFD;
> 
> Use memset().

will do.
> 
> diff --git a/sound/usb/usx2y/Makefile b/sound/usb/usx2y/Makefile
> index 9ac22bc..7489330 100644
> --- a/sound/usb/usx2y/Makefile
> +++ b/sound/usb/usx2y/Makefile
> @@ -1,3 +1,5 @@
>  snd-usb-usx2y-objs := usbusx2y.o usX2Yhwdep.o usx2yhwdeppcm.o
> +snd-usb-us122l-objs := us122l.o
>  
>  obj-$(CONFIG_SND_USB_USX2Y) += snd-usb-usx2y.o
> +obj-$(CONFIG_SND_USB_US122L) += snd-usb-us122l.o
> 
> Missing dependency to snd-usb-audio?
> Maybe we need to split a helper module...

don't understand. please explain.
> 
> +static void pt_version(struct usb_device *dev)
> +{
> +	int ret;
> +	u8 *buf = kmalloc(200, GFP_KERNEL);
> +	if (!buf)
> +		return;
> +
> +	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
> +			      'V',
> +			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> +			      0, 0, buf, 200, 1000);
> +	if (ret < 0) {
> +		P_DBG("%i", ret);
> +		goto out;
> +	}
> +	P_VDBG("%u %u %u", buf[0], buf[1], buf[2]);
> +	buf[ret] = 0;
> +	P_VDBG(".%s.", buf + 3);
> +
> +out:
> +	kfree(buf);
> +}
> 
> This function is only for debugging, no?

At least 1 of these is needed to make the thing work. Will check.
> 
> +static int pt_info(struct usb_device *dev)
> +{
> +	int ret;
> +	u8 *buf = kmalloc(200, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
> +			      'I',
> +			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> +			      0, 0, buf, 200, 1000);
> +	if (ret < 0) {
> +		P_DBG("%i", ret);
> +		goto out;
> +	}
> +	P_VDBG("0x%X", buf[0]);
> +	ret = buf[0];
> +
> +out:
> +	kfree(buf);
> +	return ret;
> +}
> 
> Ditto.
> 
> +static void pt_info_set(struct usb_device *dev, u8 v)
> +{
> +	int ret;
> +
> +	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
> +			      'I',
> +			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> +			      v, 0, NULL, 0, 1000);
> +	P_VDBG("%i", ret);
> +}
> 
> Ditto.
> 
> --- /dev/null
> +++ b/sound/usb/usx2y/usb_stream.h
> (snip)
> +
> +#define INTERFACE_VERSION 1
> +#define KERNEL_64 0x80000000
> 
> Should be more unique name as this seems imported by user-space
> apps...

Ok.
> 
> +#define USB_STREAM_INTERFACE_VERSION \
> +	((BITS_PER_LONG == 64 ? KERNEL_64 : 0) | INTERFACE_VERSION)
> +
> +#define SNDRV_USB_STREAM_IOCTL_SET_PARAMS \
> +	_IOW('H', 0x90, struct usb_stream_config)
> +
> +#if !__KERNEL__
> 
> Usually #ifndef __KERNEL__

will change.
> 
> +struct usb_iso_packet_descriptor {
> +	unsigned int offset;
> +	unsigned int length;		/* expected length */
> +	unsigned int actual_length;
> +	int status;
> +};
> 
> Why this is needed for !__KERNEL__ ?
> I see only struct usb_stream_config is required.

see the plugin. Userspace directly reads urbs.
> 
> +
> +#endif
> +
> +#define USB_STREAM_NURBS 4
> +struct usb_stream_config {
> +	unsigned version;
> +	unsigned sample_rate;
> +	unsigned period_frames;
> +	unsigned frame_size;
> +};
> 
> The codes below here should be hidden to user-space.
> If it's exported, then prepare more explicit struct.  For example,
> pointers may have different sizes on user-space.

Needed in user-space. Currently only 64Bit userspace works on 64Bit kernel.
Also 32bit user-space on 32bit kernel.
32bit user-space on 64bit kernel returns an error to the caller, please see
the plugin.
IMO 32bit user-space working on 64bit kernel can wait for "INTERFACE_VERSION 2"
> 
> 
> +#define P_WARN(fmt, ...) \
> +	printk(KERN_WARNING"%s %s:%i "fmt"\n", \
> +	       MODNAME, __func__, __LINE__, ## __VA_ARGS__);
> +
> +#define P_DBG(fmt, ...) \
> +	printk(KERN_DEBUG"%s %s:%i "fmt"\n", \
> +	       MODNAME, __func__, __LINE__, ## __VA_ARGS__);
> +
> +#define P_VDBG(fmt, ...)
> 
> Try to avoid own-printk macros as much as possible...

will fix.


thanks,
      Karsten
