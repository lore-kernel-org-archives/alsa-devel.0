From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: Distorted audio from microphone (Logitech C310)
Date: Tue, 16 May 2017 07:58:43 +0200
Message-ID: <20170516055843.GB25379@kroah.com>
References: <f1f024c9-114d-4e4d-994a-1971b10e3f0a@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f1f024c9-114d-4e4d-994a-1971b10e3f0a-5tc4TXWwyLM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Domker_ <domker2-5tc4TXWwyLM@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 15, 2017 at 03:29:09PM +0200, Domker_ wrote:
> My webcam Logitech C310 have a distored microphone audio on kernel 4.10.15-1
> and 4.11.0-1. (on 4.9.27-1 and the older ones is fine).
> The distortion effect is as if I spoke very, very fast (like a damn Mickey
> Mouse)
> 
> I checked and the bug occurs on both computers I have. (with the same
> camera/different sound cards, hardware and different Linux distributions)
> The bug always occurs when running a system with a kernel newer than 4.9.x.
> 
> The camera has two internal microphones.
> Secound kernel 4.11.0-1 (x86_64) compiled from kernel.org!
> 
> (tested under Linux Arch and Linux Manjaro)

Hm, maybe the Linux sound developers can help out here (added to cc:)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
