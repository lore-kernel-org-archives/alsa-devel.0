From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH v4 09/15] ALSA: usb-audio: conditional
 interface altsetting
Date: Mon, 7 Oct 2013 20:00:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1310071920480.1353@anubis>
References: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
 <1381091480-23636-10-git-send-email-eldad@fogrefinery.com>
 <s5h7gdps72z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 8563926509E
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 20:00:44 +0200 (CEST)
Received: by mail-bk0-f48.google.com with SMTP id my13so2732055bkb.7
 for <alsa-devel@alsa-project.org>; Mon, 07 Oct 2013 11:00:44 -0700 (PDT)
In-Reply-To: <s5h7gdps72z.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Nikolay Martynov <mar.kolya@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org



On Mon, 7 Oct 2013, Takashi Iwai wrote:

> At Sun,  6 Oct 2013 22:31:14 +0200,
> Eldad Zack wrote:
> > 
> > On some devices, if the endpoint for the other direction is in use,
> > setting one interface will shutdown the other (in use) endpoint.
> > This patch moves all of the alternate setting operations for pcm
> > ops to one function which checks if we can do so.
> > 
> > If current alternate is 0, it is safe to set.
> 
> Is this check needed for all devices?

I'm not sure, I only have this one device to test with.
I asked once on the list if this behavior (when the alts is set to 0,
the endpoint stops if it is running) or does it only happen on implicit
feedback, but got no response.

> The combination of playback and capture streams in snd_usb_substream
> is casual, just depending on the enumeration.  It doesn't always mean
> that these are coupled.  For non-implicit-fb devices, won't this
> result in a false positive?

The worst that can happen is that the altsetting will not go back to 0, 
if the other substream is in use. Is that an issue?

> 
> Also...
> 
> > +static int subs_set_interface(struct snd_usb_substream *subs, int ifnum,
> > +			      int altsetting)
> > +{
> > +	struct snd_usb_substream *other_subs;
> > +	int err;
> > +
> > +	snd_printdd(KERN_DEBUG "%s: Requested set interface %d alts %d\n",
> > +		    __func__, ifnum, altsetting);
> > +
> > +	if (subs == NULL)
> > +		return usb_set_interface(subs->dev, ifnum, altsetting);
> 
> It must lead to Oops.

Yes, that's bad code. :/
Thank you for pointing it out!

Although it won't get triggered, since it won't get any NULL subs from 
any callsite as far as I see. I'll remove this and add WARN_ON(!subs).

Cheers,
Eldad
