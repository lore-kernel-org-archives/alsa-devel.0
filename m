From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: USB sound auto-suspend not working
Date: Wed, 18 Dec 2013 09:51:46 +0100
Message-ID: <1387356706.1554.1.camel@linux-fkkt.site>
References: <20131217225548.GA3029@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131217225548.GA3029@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2013-12-17 at 14:55 -0800, Sarah Sharp wrote:
> Hi Oliver and Takashi,
> 
> I've noticed that in the last couple kernel releases or so, I can't get
> USB webcams to suspend.  It turns out that the USB sound interface is
> keeping the device active, even when the device is not playing sound.
> This goes back as far as 3.10, but I haven't tried older kernels.  This
> is testing on Ubuntu 13.10.
> 
> Commit 88a8516a2128a6d078a106ead48092240e8a138f "ALSA: usbaudio:
> implement USB autosuspend" went into kernel 2.6.39.  The commit message
> says the device is prevented from suspending if the pcm or midi channel
> files are open.
> 
> I plugged in a USB speaker, and ran lsof to see which files were open
> (output is attached).  AFAICT, only the USB sound device's control files
> are open, and I don't have any midi files.

Is that sensible? In case of a webcam the problem is input, not output.

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
