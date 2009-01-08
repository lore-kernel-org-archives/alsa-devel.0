From: Daniel Mack <daniel@caiaq.org>
Subject: Re: snd_usb_caiaq bug?
Date: Thu, 8 Jan 2009 23:11:53 +0100
Message-ID: <20090108221153.GB31383@buzzloop.caiaq.de>
References: <31e66c9e0901070741i2f6f363l9dc023223954ce2@mail.gmail.com>
	<s5hk597t6pm.wl%tiwai@suse.de>
	<31e66c9e0901071046v36112db7s757788bcf5beaeeb@mail.gmail.com>
	<907c05c70901071206y4bba38bej47f3eba51e6106d3@mail.gmail.com>
	<s5hy6xmhgp3.wl%tiwai@suse.de>
	<31e66c9e0901071659p63219af1wb392f50541cda7a0@mail.gmail.com>
	<31e66c9e0901071734t70c980a8t87f668f973b54635@mail.gmail.com>
	<s5h4p0at563.wl%tiwai@suse.de>
	<907c05c70901080626x83c3e2fn158d2938c4c8cbfd@mail.gmail.com>
	<s5h7i559845.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 62AED1037EB
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 23:11:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7i559845.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Marco Santamaria <marco.santamaria@gmail.com>, alsa-devel@alsa-project.org, Mysth-R <mysthr21@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Thu, Jan 08, 2009 at 03:37:30PM +0100, Takashi Iwai wrote:
> > every thing is Ok for me now. No more crash, no more messages in dmesg.
> > I just had a warning during compilation, but I think this is not really
> > important :
> > 
> > sound/usb/caiaq/caiaq-midi.c: In function \u2018snd_usb_caiaq_midi_output_done
> > \u2019:
> > sound/usb/caiaq/caiaq-midi.c:170: attention : unused variable \u2018buf\u2019
> > 
> > Perhaps this is not the same line (170) as you but, in my file, it concerns
> > the last function.
> 
> OK, it's simple to fix.
> The below is the latest version I committed now to sound git tree.
> It'll be pushed to 2.6.29 (and stable kernels) later.

Thanks a lot for your help - I was on vacation until now and had very
limited ways to follow that thread. I would, however, apprectiate the
driver version number would be increased for this change, as it makes
tracking of user error reports better trackable.

Do you want me to send in a patch for that or is it easier if you do
it yourself?

Thanks and best regards,
Daniel

> ---
> diff --git a/sound/usb/caiaq/caiaq-device.h b/sound/usb/caiaq/caiaq-device.h
> index f9fbdba..ab56e73 100644
> --- a/sound/usb/caiaq/caiaq-device.h
> +++ b/sound/usb/caiaq/caiaq-device.h
> @@ -75,6 +75,7 @@ struct snd_usb_caiaqdev {
>  	wait_queue_head_t ep1_wait_queue;
>  	wait_queue_head_t prepare_wait_queue;
>  	int spec_received, audio_parm_answer;
> +	int midi_out_active;
>  
>  	char vendor_name[CAIAQ_USB_STR_LEN];
>  	char product_name[CAIAQ_USB_STR_LEN];
> diff --git a/sound/usb/caiaq/caiaq-midi.c b/sound/usb/caiaq/caiaq-midi.c
> index 30b57f9..f19fd36 100644
> --- a/sound/usb/caiaq/caiaq-midi.c
> +++ b/sound/usb/caiaq/caiaq-midi.c
> @@ -59,6 +59,11 @@ static int snd_usb_caiaq_midi_output_open(struct snd_rawmidi_substream *substrea
>  
>  static int snd_usb_caiaq_midi_output_close(struct snd_rawmidi_substream *substream)
>  {
> +	struct snd_usb_caiaqdev *dev = substream->rmidi->private_data;
> +	if (dev->midi_out_active) {
> +		usb_kill_urb(&dev->midi_out_urb);
> +		dev->midi_out_active = 0;
> +	}
>  	return 0;
>  }
>  
> @@ -69,7 +74,8 @@ static void snd_usb_caiaq_midi_send(struct snd_usb_caiaqdev *dev,
>  	
>  	dev->midi_out_buf[0] = EP1_CMD_MIDI_WRITE;
>  	dev->midi_out_buf[1] = 0; /* port */
> -	len = snd_rawmidi_transmit_peek(substream, dev->midi_out_buf+3, EP1_BUFSIZE-3);
> +	len = snd_rawmidi_transmit(substream, dev->midi_out_buf + 3,
> +				   EP1_BUFSIZE - 3);
>  	
>  	if (len <= 0)
>  		return;
> @@ -79,24 +85,24 @@ static void snd_usb_caiaq_midi_send(struct snd_usb_caiaqdev *dev,
>  	
>  	ret = usb_submit_urb(&dev->midi_out_urb, GFP_ATOMIC);
>  	if (ret < 0)
> -		log("snd_usb_caiaq_midi_send(%p): usb_submit_urb() failed, %d\n",
> -				substream, ret);
> +		log("snd_usb_caiaq_midi_send(%p): usb_submit_urb() failed,"
> +		    "ret=%d, len=%d\n",
> +		    substream, ret, len);
> +	else
> +		dev->midi_out_active = 1;
>  }
>  
>  static void snd_usb_caiaq_midi_output_trigger(struct snd_rawmidi_substream *substream, int up)
>  {
>  	struct snd_usb_caiaqdev *dev = substream->rmidi->private_data;
>  	
> -	if (dev->midi_out_substream != NULL)
> -		return;
> -	
> -	if (!up) {
> +	if (up) {
> +		dev->midi_out_substream = substream;
> +		if (!dev->midi_out_active)
> +			snd_usb_caiaq_midi_send(dev, substream);
> +	} else {
>  		dev->midi_out_substream = NULL;
> -		return;
>  	}
> -	
> -	dev->midi_out_substream = substream;
> -	snd_usb_caiaq_midi_send(dev, substream);
>  }
>  
>  
> @@ -161,16 +167,14 @@ int snd_usb_caiaq_midi_init(struct snd_usb_caiaqdev *device)
>  void snd_usb_caiaq_midi_output_done(struct urb* urb)
>  {
>  	struct snd_usb_caiaqdev *dev = urb->context;
> -      	char *buf = urb->transfer_buffer;
>  	
> +	dev->midi_out_active = 0;
>  	if (urb->status != 0)
>  		return;
>  
>  	if (!dev->midi_out_substream)
>  		return;
>  
> -	snd_rawmidi_transmit_ack(dev->midi_out_substream, buf[2]);
> -	dev->midi_out_substream = NULL;
>  	snd_usb_caiaq_midi_send(dev, dev->midi_out_substream);
>  }
>

Acked-by: Daniel Mack <daniel@caiaq.de>
