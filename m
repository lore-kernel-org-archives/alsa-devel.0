From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Problem with USB Class 2 Audio Driver
Date: Tue, 24 Aug 2010 09:52:59 +0200
Message-ID: <201008240952.59903.oneukum@suse.de>
References: <054801cb40c9$70349710$509dc530$@com> <4C72DB6A.5080601@cinti.net> <20100824070601.GK17833@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100824070601.GK17833-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: "J. Gordon Rankin" <waudio-P3U7sUXGDiZeoWH0uzbU5w@public.gmane.org>, Demian Martin <demianm_1-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 24. August 2010, 09:06:02 schrieb Daniel Mack:
> On Mon, Aug 23, 2010 at 04:34:50PM -0400, J. Gordon Rankin wrote:
> > Part of the problem could be that everything is working
> > synchronously. The reading of the USB drive and the outputting to
> > the USB converter are both happening  in sync because the
> > application would work this way.
> 
> True. But for the USB side of the story, there is a reserved part of the
> bandwidth for isochronous (real-time) data which is guaranteed for
> exacty such scenarios, so bulk data bursts wont't kill the stream.

Yes, but note that this works one-way. The audio can still starve the disk.
You need to check in the device descriptors, how much bandwidth
the audio device will take. Then you need to compute whether the
rest left to the disk is enough. 

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
