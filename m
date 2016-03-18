From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: USB Sound oops in Linus's latest tree
Date: Fri, 18 Mar 2016 16:04:59 -0700
Message-ID: <20160318230459.GA6531@kroah.com>
References: <20160318222625.GA1200@kroah.com>
 <871t77o19c.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <871t77o19c.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolai Stange <nicstange-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 18, 2016 at 11:43:43PM +0100, Nicolai Stange wrote:
> Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> writes:
> 
> > Hi,
> >
> > I'm getting the following oops with my USB sound device using Linus's
> > latest tree of the moment, which has the sound tree pull in it.  Anyone
> > seen this before?
> 
> Yes, and a fix is on its way:
> 
>   http://lkml.kernel.org/g/1458045306-4170-1-git-send-email-nicstange-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Ah, great, thanks for this.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
