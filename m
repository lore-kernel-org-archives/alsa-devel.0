From: "Geoffrey D. Bennett" <g@b4.vu>
Subject: Re: [PATCH V6 RESEND] ALSA: usb-audio: Scarlett Gen 2
	mixer interface
Date: Sat, 20 Jul 2019 00:38:48 +0930
Message-ID: <20190719150848.GA11924@b4.vu>
References: <20190717155105.GA4198@b4.vu> <s5hd0i7nxue.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from b4.vu (b4.vu [203.16.231.147])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 275D0F800B2
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2019 17:08:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd0i7nxue.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Thu, Jul 18, 2019 at 05:53:13PM +0200, Takashi Iwai wrote:
[...]
> Thanks, the patch looks almost good, but it's already too late for
> 5.3, so I'm going to queue this for 5.4 after 5.3 merge window is
> closed in this week.

Thank you. I really appreciate your assistance and feedback.

> But, before that, maybe one more refresh would be appreciated.
> Namely,
> 
> - We need a verification of the fixed pipe before actually submitting
>   urb.  scarlett2_usb() calls with usb_sndctrlpipe(), and this pipe
>   has to be verified beforehand.  See the commit 801ebf1043ae for
>   details.

I had a look at that commit, and I think I don't need to change
scarlett2_usb() because it calls snd_usb_ctl_msg() which already calls
the snd_usb_pipe_sanity_check() function to verify the pipe.

I'm thinking though that scarlett2_mixer_status_create() which does
something like this:

  struct usb_device *dev = mixer->chip->dev;
  unsigned int pipe = usb_rcvintpipe(dev, SCARLETT2_USB_INTERRUPT_ENDPOINT);
  ...
  usb_fill_int_urb(mixer->urb, dev, pipe, ...);
  usb_submit_urb(mixer->urb, GFP_KERNEL);

probably needs this added:

  if (snd_usb_pipe_sanity_check(dev, pipe))
          return -EINVAL;

Do you agree?

> - Some pointers seem to be initialized as "0".  Use NULL instead.

Will fix.

Regards,
Geoffrey.
