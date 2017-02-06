From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: Fwd: Regression: Line6 Toneport stops working on 4.10-rc5
Date: Mon, 6 Feb 2017 11:18:44 +0100
Message-ID: <20170206101844.GA10982@kroah.com>
References: <CAH7_RC8_i0id7YRqzW37qtq3B7BrWfwDU-fXmBADBx0Mej7vsw@mail.gmail.com>
 <CAH7_RC8NA5KJ=eB63fxXnUwk7kkgJAT=p6K29EncrYcgE-utTg@mail.gmail.com>
 <20170126074724.GA9837@kroah.com>
 <CAH7_RC9RmhF0eBf7phh_2NROL65_Rw=8Jd2Wf9TsURhkASOuMw@mail.gmail.com>
 <20170126093002.GA787@kroah.com>
 <CAH7_RC8Ma6c+VHvQ8i0BHDmA_B5qdrPXNQkBAy2Z0MbCHumrnQ@mail.gmail.com>
 <20170127165429.GA19745@kroah.com>
 <CAH7_RC-Lvjyr8o8By27enPNzumigSRFbHEiLp4v+Qmg5if73Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAH7_RC-Lvjyr8o8By27enPNzumigSRFbHEiLp4v+Qmg5if73Xg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrej Krutak <dev-/tK0A0Qp8GRaa/9Udqfwiw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Igor Zinovev <zinigor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 06, 2017 at 01:01:56PM +0300, Igor Zinovev wrote:
> Hello again!
> 
> Thanks for the advice, but bisecting the whole tree took me quite a
> while and I ended up stuck because booting on some bisect states has
> led my system to run without some devices, like wireless and sound. So
> I tried to bisect the sound/usb/line6 path. It turns out that this
> commit is the point where it breaks for me:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/sound/usb/line6?id=f6a0dd107ad0c8b59d1c9735eea4b8cb9f460949
> 
> In fact, when I apply the reverse patch on top of 4.10-rc7, it fixes
> the problem for me.

Wonderful, thanks so much for tracking this down!

> Should I bring some of the people that are mentioned in the commit
> into this conversation?

I've done so now.  Andrej and Takashi, the above patch causes a
regression for Igor, any thoughts?  Should we just revert it?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
