From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: Re: snd-usb-audio syncronisation problem
Date: Fri, 22 Feb 2008 16:51:41 +0200
Message-ID: <43e8c7320802220651r25ac78d7pecca63f3e1d48249@mail.gmail.com>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
	<47BEC97A.3030507@ladisch.de>
	<43e8c7320802220545m6ccf8c7fr13a9390563d7df7@mail.gmail.com>
	<47BED4C2.4020501@ladisch.de>
	<43e8c7320802220619x4dfc049cv1f38a6fb8b1cb7a8@mail.gmail.com>
	<47BEDF9E.3000907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 53FFB103806
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 15:51:43 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id c6so289845gvd.24
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 06:51:42 -0800 (PST)
In-Reply-To: <47BEDF9E.3000907@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I got these results:

[...]
status 0 len 0
status 0 len 0
status 0 len 0
status 0 len 0
status 0 len 0
invalid freq 3145728
status 0 len 0
status 0 len 0
status 0 len 0
[...]

additional note:
freqn=393216, freqmax=401408, f=3145728

On Fri, Feb 22, 2008 at 4:43 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adrian Stancu wrote:
>  > It seems that retire_playback_sync_urb_hs gets called, but 'subs->feqm
>  > = f;' never gets called
>
>  Please try these printk's:
>
>                         ...
>                         spin_unlock_irqrestore(&subs->lock, flags);
>                 }
>                 else
>                         printk("invalid freq %u\n", f);
>         }
>         else
>                 printk("status %d len %u\n", urb->iso_frame_desc[0].status, urb->iso_frame_desc[0].actual_length);
>
>         return 0;
>  }
>
>
>  Regards,
>  Clemens
>
