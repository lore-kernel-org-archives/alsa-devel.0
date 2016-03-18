From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: USB Sound oops in Linus's latest tree
Date: Fri, 18 Mar 2016 16:17:43 -0700
Message-ID: <20160318231743.GB6909@kroah.com>
References: <20160318222625.GA1200@kroah.com>
 <CAKocOOOHOt+VLioHt0qcOA_sGnLynMW99RBaARgZbysr8Nf4kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKocOOOHOt+VLioHt0qcOA_sGnLynMW99RBaARgZbysr8Nf4kw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mauro Carvalho Chehab (Google+)" <reply-109152370613783863478-YufVqqjVJEdOwrogniBlMUEOCMrvLtNR@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 18, 2016 at 05:00:25PM -0600, Shuah Khan wrote:
> On Fri, Mar 18, 2016 at 4:26 PM,
> Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> > Hi,
> >
> > I'm getting the following oops with my USB sound device using Linus's
> > latest tree of the moment, which has the sound tree pull in it.  Anyone
> > seen this before?
> >
> 
> Hi Greg,
> 
> Nicolai Stange sent in a fix for this problem - I can't find the link to this.
> It is coming in through Linux Media tree.

Thanks, Nicolai sent a link, your inline patch was somehow corrupted :(

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
