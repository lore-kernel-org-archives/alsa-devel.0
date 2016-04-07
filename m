From: Kailang <kailang@realtek.com>
Subject: Re: Dell USB audio driver workaround
Date: Thu, 7 Apr 2016 10:07:25 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A3313B@RTITMBSV09.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A32FFC@RTITMBSV09.realtek.com.tw>
 <s5h1t6jxgh5.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A33059@RTITMBSV09.realtek.com.tw>
 <s5h37qzm63e.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A330E6@RTITMBSV09.realtek.com.tw>
 <s5h4mbd93c1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 24BCF264F34
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 12:07:28 +0200 (CEST)
In-Reply-To: <s5h4mbd93c1.wl-tiwai@suse.de>
Content-Language: zh-TW
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
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Thursday, April 07, 2016 5:27 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: Dell USB audio driver workaround
> 
> On Thu, 07 Apr 2016 09:05:52 +0200,
> Kailang wrote:
> > 
> >  
> > 
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Wednesday, April 06, 2016 5:37 PM
> > > To: Kailang
> > > Cc: (alsa-devel@alsa-project.org)
> > > Subject: Re: Dell USB audio driver workaround
> > > 
> > > On Wed, 06 Apr 2016 11:22:43 +0200,
> > > Kailang wrote:
> > > > 
> > > >  
> > > > 
> > > > > -----Original Message-----
> > > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > Sent: Wednesday, April 06, 2016 4:57 PM
> > > > > To: Kailang
> > > > > Cc: (alsa-devel@alsa-project.org)
> > > > > Subject: Re: Dell USB audio driver workaround
> > > > > 
> > > > > On Wed, 06 Apr 2016 08:29:12 +0200, Kailang wrote:
> > > > > > 
> > > > > > Hi Takashi,
> > > > > > 
> > > > > > Dell had USB dock.
> > > > > > Maybe firmware issue, the master volume always keep at 0x57.
> > > > > > Attach patch will fix it to keep at Max volume.
> > > > > > 
> > > > > > Could you help us to update it?
> > > > > 
> > > > > Well, I don't get how this patch works..
> > > > > 
> > > > > > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c index 
> > > > > > 4f85757..84d9a4e 100644
> > > > > > --- a/sound/usb/mixer.c
> > > > > > +++ b/sound/usb/mixer.c
> > > > > > @@ -846,6 +846,12 @@ static void 
> volume_control_quirks(struct 
> > > > > > usb_mixer_elem_info *cval,  {
> > > > > >  	struct snd_usb_audio *chip = cval->head.mixer->chip;
> > > > > >  	switch (chip->usb_id) {
> > > > > > +	case USB_ID(0x0bda, 0x4014): /* Dell workaround */
> > > > > > +		if (strstr(kctl->id.name, "Playback
> > > Volume") != NULL) {
> > > > > > +			cval->min = 0x0000;
> > > > > > +			cval->max = 0x0000;
> > > > > > +		}
> > > > > > +		break;
> > > > > 
> > > > > So, this means that this value has to be fixed to 0?
> > > > > If yes, can't we simply remove this volume instead?
> > > > 
> > > > Yes, but it need to set Max volume to 0. This is test 
> on my site.
> > > > Because it will rewrite 0x57 value to codec register when
> > > driver is loaded.
> > > > And keep 0x57 volume value all the time. So, Master volume
> > > will lower than windows machine.
> > > > This case which driver fail to build the alsa mixer(This is
> > > firmware cause it). So, no hardware volume control on this.
> > > > If the Max volume value is 0,  system will not set default
> > > value 0x57 for first time loading driver.
> > > 
> > > Which values (min/max) does this FU take and which values 
> are buggy?
> > Max value. 
> 
> Sorry, my question wasn't clear.  "What" min and max are 
> they?  min=0 and max=0x57?

Oh! Sorry. It's my wrong. I forgot.

Unit: 16
    Control: name="PCM Playback Volume", index=0
    Info: id=16, control=2, cmask=0x3, channels=2, type="S16"
    Volume: min=-16256, max=0, dBmin=-6350, dBmax=0

0x0 (codec reg)  = (-16256) (USB vloume level)
0x57(codec reg) = 0xEC00(USB vloume level)
0x7F(codec reg) = 0x0000 (USB vloume level)

> 
> And, your patch changes both min and max to be 0.  That is, 
> it accepts only 0.  Does it mean that this FU isn't any 
> proper volume control?

cval->max original is 0.
cval->min => I set it to 0. It will be not rewrite 0x57 value to codec.

> 
> 
> > But it is not buggy value. Min and Max value are all safe. 
> It got right value from firmware.
> > But if Max value > 0, maybe < 0x57, it will be not rewrited value.
> > Please look for belowing function. 
> > 
> > Our USB firmware fail for build alsa mixer. And we fixed 
> the firmware already.
> > But Dell didn't want to update firmware. Because they 
> release this MP more and more.
> > So, they request a workaround for this unit.
> > 
> > Below is in mixer.c
> > 
> > static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
> >      struct snd_ctl_elem_value *ucontrol) {  struct 
> > usb_mixer_elem_info *cval = kcontrol->private_data;  int c, 
> cnt, val, 
> > oval, err;  int changed = 0;
> >  
> >  if (cval->cmask) {
> >   cnt = 0;
> >   for (c = 0; c < MAX_CHANNELS; c++) {
> >    if (!(cval->cmask & (1 << c)))
> >     continue;
> >    err = get_cur_mix_value(cval, c + 1, cnt, &oval);
> >    if (err < 0)
> >     return cval->mixer->ignore_ctl_error ? 0 : err;
> >    val = ucontrol->value.integer.value[cnt];   =========> 
> This line will get default value( 0x57) from mixer.
> 
> So, do you mean that writing the default value (0x57) from 
> the firmware causes the trouble, and it has to be 0?
> 
> 
> >    val = get_abs_value(cval, val);
> >    if (oval != val) {
> >     set_cur_mix_value(cval, c + 1, cnt, val);
> >     changed = 1;
> >    }
> >    cnt++;
> >   }
> >  } else {
> >   /* master channel */
> >   err = get_cur_mix_value(cval, 0, 0, &oval);
> >   if (err < 0)
> >    return cval->mixer->ignore_ctl_error ? 0 : err;
> >   val = ucontrol->value.integer.value[0];
> >   val = get_abs_value(cval, val);
> >   if (val != oval) {
> >    set_cur_mix_value(cval, 0, 0, val);
> >    changed = 1;
> >   }
> >  }
> >  return changed;
> > }
> > 
> > > Judging from your description, the firmware gives the bogus max 
> > > value (white min value = 0) and a volume higher than zero is 
> > > attenuation?
> > 
> > I had not test Max value > 0 and < 0x57.
> > cval->min = 0x0000;  => this is original. I just post it. 
> Remove this line is OK.
> 
> Well, I still don't understand clearly.  What do you mean 
> here as "original"?
> 
> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 
