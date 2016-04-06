From: Kailang <kailang@realtek.com>
Subject: Re: Dell USB audio driver workaround
Date: Wed, 6 Apr 2016 09:22:43 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A33059@RTITMBSV09.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A32FFC@RTITMBSV09.realtek.com.tw>
 <s5h1t6jxgh5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 8407C26506E
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 11:22:48 +0200 (CEST)
In-Reply-To: <s5h1t6jxgh5.wl-tiwai@suse.de>
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
> Sent: Wednesday, April 06, 2016 4:57 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: Dell USB audio driver workaround
> 
> On Wed, 06 Apr 2016 08:29:12 +0200,
> Kailang wrote:
> > 
> > Hi Takashi,
> > 
> > Dell had USB dock.
> > Maybe firmware issue, the master volume always keep at 0x57.
> > Attach patch will fix it to keep at Max volume.
> > 
> > Could you help us to update it?
> 
> Well, I don't get how this patch works..
> 
> > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c index 
> > 4f85757..84d9a4e 100644
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -846,6 +846,12 @@ static void volume_control_quirks(struct 
> > usb_mixer_elem_info *cval,  {
> >  	struct snd_usb_audio *chip = cval->head.mixer->chip;
> >  	switch (chip->usb_id) {
> > +	case USB_ID(0x0bda, 0x4014): /* Dell workaround */
> > +		if (strstr(kctl->id.name, "Playback Volume") != NULL) {
> > +			cval->min = 0x0000;
> > +			cval->max = 0x0000;
> > +		}
> > +		break;
> 
> So, this means that this value has to be fixed to 0?
> If yes, can't we simply remove this volume instead?

Yes, but it need to set Max volume to 0. This is test on my site.
Because it will rewrite 0x57 value to codec register when driver is loaded.
And keep 0x57 volume value all the time. So, Master volume will lower than windows machine.
This case which driver fail to build the alsa mixer(This is firmware cause it). So, no hardware volume control on this.
If the Max volume value is 0,  system will not set default value 0x57 for first time loading driver.

> 
> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 
