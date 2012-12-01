From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [FT C400, PATCH RFC,
	v4 02/10] usb-audio: correct sync ep init
Date: Sat, 1 Dec 2012 23:47:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212012329580.2250@xoschi>
References: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
 <1354143341-1623-3-git-send-email-eldad@fogrefinery.com>
 <s5hk3t4alc0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B59F261743
 for <alsa-devel@alsa-project.org>; Sat,  1 Dec 2012 23:47:13 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so577199bkc.38
 for <alsa-devel@alsa-project.org>; Sat, 01 Dec 2012 14:47:12 -0800 (PST)
In-Reply-To: <s5hk3t4alc0.wl%tiwai@suse.de>
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
Cc: Grant Diffey <gdiffey@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>, George Willian Condomitti <georgecondomitti@gmail.com>, Jeffrey Barish <jeff_barish@earthlink.net>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


Hi Takashi,

On Thu, 29 Nov 2012, Takashi Iwai wrote:
> At Wed, 28 Nov 2012 23:55:33 +0100,
> Eldad Zack wrote:
> >  /*
> > + * Configure the sync ep using the rate and pcm format of the data ep.
> > + */
> > +static int configure_sync_endpoint(struct snd_usb_substream *subs)
> > +{
> > +	int ret;
> > +	struct list_head *p;
> > +	struct audioformat *sync_fp;
> > +	int sync_channels = 0;
> > +	int sync_period_bytes = subs->period_bytes;
> > +	int direction = subs->direction ^ 1;
> 
> Better to rename for avoiding misunderstanding.
> "direction" sounds like the direction of this substream.

Thanks for the pointer. I ended up getting rid rid of it 
altogether, since the following is redundant:

> > +	struct snd_usb_substream *sync_subs =
> > +		&subs->stream->substream[direction];
> > +
> > +	if (sync_subs->ep_num != subs->sync_endpoint->ep_num) {
> > +		snd_printk(KERN_ERR "%s: cannot find the sync ep (direction %d, found %x, wanted %x).\n",
> > +			__func__, direction,
> > +				subs->stream->substream[direction].ep_num,
> > +				subs->sync_endpoint->ep_num);
> > +		return -EINVAL;
> > +	}
> 
> This sanity check would suit better where the implicit_fb is checked.
> It doesn't have to be performed at each time.
> 
> And, the whole restriction you introduced is only for implicit fb
> case, no?

Yes, I took a closer look and saw that the only way for the 
sync_endpoint member to be at all initialized is when it is 1) implicit 
fb, 2) in the same stream as the data and in the opposite direction,
so there's no point in checking that at all.

> > +	/*
> > +	 * Try to find a format with a number of channels matching
> > +	 * the data substream. If no such format was found, pick one
> > +	 * with non zero channel number at random.
> > +	 */
> > +	list_for_each(p, &sync_subs->fmt_list) {
> Cleaner to use list_for_each_entry().
> (Yes, there are other codes using list_for_each() there, but remember
>  how old the usb-audio driver code is :)

Thanks again, it looks more concise that way. I'll see if it is possible 
to clean up other spots the same way and post later.

> Can be simplified like
> 
> 		if (!sync_channels || fp->channels == sub->channels) {
> 			sync_channels = fp->channels;
> 			sync_fp = fp;
> 		}
> 
> But, I wonder whether you don't have to check other parameters such as
> rate, format, etc?

Yes, especially since both rate and format will influence the period 
bytes count and then the usb host driver will error out. It is unlikely
that such a configuration exist, which doesn't support the same rate
and PCM format in both direction, but it is worth checking.

Patch follows.

Cheers,
Eldad
