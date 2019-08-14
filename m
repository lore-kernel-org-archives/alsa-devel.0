From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Fix an OOB bug in parse_audio_mixer_unit
Date: Wed, 14 Aug 2019 12:09:21 +0300
Message-ID: <20190814090921.GO1935@kadam>
References: <20190814023625.21683-1-benquike@gmail.com>
 <s5hzhkcb6dh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C416F803F4
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 11:09:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzhkcb6dh.wl-tiwai@suse.de>
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
Cc: Mathias Payer <mathias.payer@nebelwelt.net>, security@kernel.org, Wenwen Wang <wang6495@umn.edu>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>, Hui Peng <benquike@gmail.com>, Allison Randal <allison@lohutok.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 14, 2019 at 08:36:42AM +0200, Takashi Iwai wrote:
> On Wed, 14 Aug 2019 04:36:24 +0200,
> Hui Peng wrote:
> > 
> > The `uac_mixer_unit_descriptor` shown as below is read from the
> > device side. In `parse_audio_mixer_unit`, `baSourceID` field is
> > accessed from index 0 to `bNrInPins` - 1, the current implementation
> > assumes that descriptor is always valid (the length  of descriptor
> > is no shorter than 5 + `bNrInPins`). If a descriptor read from
> > the device side is invalid, it may trigger out-of-bound memory
> > access.
> > 
> > ```
> > struct uac_mixer_unit_descriptor {
> > 	__u8 bLength;
> > 	__u8 bDescriptorType;
> > 	__u8 bDescriptorSubtype;
> > 	__u8 bUnitID;
> > 	__u8 bNrInPins;
> > 	__u8 baSourceID[];
> > }
> > ```
> > 
> > This patch fixes the bug by add a sanity check on the length of
> > the descriptor.
> > 
> > Signed-off-by: Hui Peng <benquike@gmail.com>
> > Reported-by: Hui Peng <benquike@gmail.com>
> > Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
> > ---
> >  sound/usb/mixer.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> > index 7498b5191b68..38202ce67237 100644
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -2091,6 +2091,15 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
> >  	struct usb_audio_term iterm;
> >  	int input_pins, num_ins, num_outs;
> >  	int pin, ich, err;
> > +	int desc_len = (int) ((unsigned long) state->buffer +
> > +			state->buflen - (unsigned long) raw_desc);
> > +
> > +	if (desc_len < sizeof(*desc) + desc->bNrInPins) {
> > +		usb_audio_err(state->chip,
> > +			      "descriptor %d too short\n",
> > +			      unitid);
> > +		return -EINVAL;
> > +	}
> >  
> >  	err = uac_mixer_unit_get_channels(state, desc);
> >  	if (err < 0) {
> 
> Hm, what is the desc->bLength value in the error case?
> 
> Basically the buffer boundary is already checked against bLength in
> snd_usb_find_desc() which is called from obtaining the raw_desc in the
> caller of this function (parse_audio_unit()).
> 
> So, if any, we need to check bLength for the possible overflow like
> below.
> 
> 
> thanks,
> 
> Takashi
> 
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -744,6 +744,8 @@ static int uac_mixer_unit_get_channels(struct mixer_build *state,
>  		return -EINVAL;
>  	if (!desc->bNrInPins)
>  		return -EINVAL;
> +	if (desc->bLength < sizeof(*desc) + desc->bNrInPins)
> +		return -EINVAL;

VERSION 1 and 2 already have a different check:

	if (desc->bLength < sizeof(*desc) + desc->bNrInPins + 1)
		return 0; /* no bmControls -> skip */

So something is possibly off by one.  It's just version 3 which doesn't
have a check.

regards,
dan carpenter
