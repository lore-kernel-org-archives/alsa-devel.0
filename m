From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] USB: fix gathering of interface associations
Date: Thu, 14 Jun 2012 08:48:40 -0700
Message-ID: <20120614154840.GH17140@kroah.com>
References: <1339525432-22039-1-git-send-email-zonque@gmail.com>
 <4FD9C7D2.8030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FD9C7D2.8030506-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ml_all-+8pbQKgpUcE@public.gmane.org, ivanperrone-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, sergio tabanelli <sergio.tabanelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 14, 2012 at 01:15:30PM +0200, Daniel Mack wrote:
> On 12.06.2012 20:23, Daniel Mack wrote:
> > TEAC's UD-H01 (and probably other devices) have a gap in the interface
> > number allocation of their descriptors:
> 
> I now got a report from Sergio Tabanelli who tried this patch on real
> hardware, and he confirmed the fix. I added some more people to the
> patch description and copied stable@ as well.
> 
> Greg, can can this go through your tree?

Yup, I'll take it now, thanks.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
