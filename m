From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Re: [PATCH] 6fire: fix DMA issues with URB
 transfer_buffer usage
Date: Wed, 7 Aug 2013 15:59:07 +0200
Message-ID: <20130807155907.dfea021b3b73fcac33e4323d@zoho.com>
References: <20130806115324.23908.18291.stgit@localhost6.localdomain6>
 <s5h7gfx7jsw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D4CC265491
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 15:59:18 +0200 (CEST)
In-Reply-To: <s5h7gfx7jsw.wl%tiwai@suse.de>
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
Cc: Jussi Kivilinna <jussi.kivilinna@iki.fi>, alsa-devel@alsa-project.org, Torsten Schenk <torsten.schenk@zoho.com>, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 07 Aug 2013 14:43:43 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 06 Aug 2013 14:53:24 +0300,
> Jussi Kivilinna wrote:
> > 
> > Patch fixes 6fire not to use stack as URB transfer_buffer. URB
> > buffers need to be DMA-able, which stack is not. Furthermore,
> > transfer_buffer should not be allocated as part of larger device
> > structure because DMA coherency issues and patch fixes this issue
> > too.

Thanks for the information. There is another section where this applies
in midi.c/midi.h. I can post a patch later.

> > 
> > Patch is only compile tested.
> 
> The changes look OK, but I'd like to let it checked with a real
> hardware before putting to stable kernel.
> 
> Torsten, could you check this?

The patch works nicely.

I'm just wondering if instead of calling kmalloc() every time it'd be
better to put a global sender_buffer and a mutex into the comm_runtime
struct and lock it every time a writeX is performed. This also would
have the advantage that message blocks would never overlap which
currently is possible.

I can prepare a patch on top of this one and send it later, if you
agree.

Thanks,
Torsten

> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jussi Kivilinna <jussi.kivilinna@iki.fi>
> > ---
> >  sound/usb/6fire/comm.c |   38 ++++++++++++++++++++++++++++++++
> > +----- sound/usb/6fire/comm.h |    2 +-
> >  2 files changed, 34 insertions(+), 6 deletions(-)
> > 
> > diff --git a/sound/usb/6fire/comm.c b/sound/usb/6fire/comm.c
> > index 9e6e3ff..23452ee 100644
> > --- a/sound/usb/6fire/comm.c
> > +++ b/sound/usb/6fire/comm.c
> > @@ -110,19 +110,37 @@ static int usb6fire_comm_send_buffer(u8
> > *buffer, struct usb_device *dev) static int usb6fire_comm_write8
> > (struct comm_runtime *rt, u8 request, u8 reg, u8 value)
> >  {
> > -	u8 buffer[13]; /* 13: maximum length of message */
> > +	u8 *buffer;
> > +	int ret;
> > +
> > +	/* 13: maximum length of message */
> > +	buffer = kmalloc(13, GFP_KERNEL);
> > +	if (!buffer)
> > +		return -ENOMEM;
> >  
> >  	usb6fire_comm_init_buffer(buffer, 0x00, request, reg,
> > value, 0x00);
> > -	return usb6fire_comm_send_buffer(buffer, rt->chip->dev);
> > +	ret = usb6fire_comm_send_buffer(buffer, rt->chip->dev);
> > +
> > +	kfree(buffer);
> > +	return ret;
> >  }
> >  
> >  static int usb6fire_comm_write16(struct comm_runtime *rt, u8
> > request, u8 reg, u8 vl, u8 vh)
> >  {
> > -	u8 buffer[13]; /* 13: maximum length of message */
> > +	u8 *buffer;
> > +	int ret;
> > +
> > +	/* 13: maximum length of message */
> > +	buffer = kmalloc(13, GFP_KERNEL);
> > +	if (!buffer)
> > +		return -ENOMEM;
> >  
> >  	usb6fire_comm_init_buffer(buffer, 0x00, request, reg, vl,
> > vh);
> > -	return usb6fire_comm_send_buffer(buffer, rt->chip->dev);
> > +	ret = usb6fire_comm_send_buffer(buffer, rt->chip->dev);
> > +
> > +	kfree(buffer);
> > +	return ret;
> >  }
> >  
> >  int usb6fire_comm_init(struct sfire_chip *chip)
> > @@ -135,6 +153,12 @@ int usb6fire_comm_init(struct sfire_chip *chip)
> >  	if (!rt)
> >  		return -ENOMEM;
> >  
> > +	rt->receiver_buffer = kzalloc(COMM_RECEIVER_BUFSIZE,
> > GFP_KERNEL);
> > +	if (!rt->receiver_buffer) {
> > +		kfree(rt);
> > +		return -ENOMEM;
> > +	}
> > +
> >  	urb = &rt->receiver;
> >  	rt->serial = 1;
> >  	rt->chip = chip;
> > @@ -153,6 +177,7 @@ int usb6fire_comm_init(struct sfire_chip *chip)
> >  	urb->interval = 1;
> >  	ret = usb_submit_urb(urb, GFP_KERNEL);
> >  	if (ret < 0) {
> > +		kfree(rt->receiver_buffer);
> >  		kfree(rt);
> >  		snd_printk(KERN_ERR PREFIX "cannot create comm
> > data receiver."); return ret;
> > @@ -171,6 +196,9 @@ void usb6fire_comm_abort(struct sfire_chip
> > *chip) 
> >  void usb6fire_comm_destroy(struct sfire_chip *chip)
> >  {
> > -	kfree(chip->comm);
> > +	struct comm_runtime *rt = chip->comm;
> > +
> > +	kfree(rt->receiver_buffer);
> > +	kfree(rt);
> >  	chip->comm = NULL;
> >  }
> > diff --git a/sound/usb/6fire/comm.h b/sound/usb/6fire/comm.h
> > index 6a0840b..780d5ed 100644
> > --- a/sound/usb/6fire/comm.h
> > +++ b/sound/usb/6fire/comm.h
> > @@ -24,7 +24,7 @@ struct comm_runtime {
> >  	struct sfire_chip *chip;
> >  
> >  	struct urb receiver;
> > -	u8 receiver_buffer[COMM_RECEIVER_BUFSIZE];
> > +	u8 *receiver_buffer;
> >  
> >  	u8 serial; /* urb serial */
> >  
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
> 
