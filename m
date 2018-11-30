From: Kailang <kailang@realtek.com>
Subject: Re: HDA headset button support
Date: Fri, 30 Nov 2018 06:45:04 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1841FC1F@RTITMBSV02.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A1841FAEF@RTITMBSV02.realtek.com.tw>
 <s5ho9a9uwkr.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A1841FB60@RTITMBSV02.realtek.com.tw>
 <s5hftvk49ag.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A1841FB90@RTITMBSV02.realtek.com.tw>
 <s5hd0qo47ax.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id B5A25267B85
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2018 07:45:14 +0100 (CET)
In-Reply-To: <s5hd0qo47ax.wl-tiwai@suse.de>
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

Hi Takashi,

Intel say .... it was not show headset plug and unplug.
Is that necessary to show headphone and MIC plug and unplug {Event type 5 (EV_SW)}?

Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 114 (KEY_VOLUMEDOWN)
    Event code 115 (KEY_VOLUMEUP)
    Event code 164 (KEY_PLAYPAUSE)
    Event code 582 (?)
  Event type 5 (EV_SW)
    Event code 2 (SW_HEADPHONE_INSERT)
    Event code 4 (SW_MICROPHONE_INSERT)
Properties:
Testing ... (interrupt to exit)
***Following block of events is for one single event: pressing one of the buttons on headset***
Event: time 1543528786.148227, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP), value 1
Event: time 1543528786.148227, -------------- SYN_REPORT ------------
Event: time 1543528786.148249, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP), value 0
Event: time 1543528786.148249, -------------- SYN_REPORT ------------
***No events show on evtest when plug or unplug jack***

BR,
Kailang

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de> 
Sent: Thursday, November 29, 2018 4:28 PM
To: Kailang <kailang@realtek.com>
Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
Subject: Re: HDA headset button support

On Thu, 29 Nov 2018 09:21:51 +0100,
Kailang wrote:
> 
> Hi Takashi,
> 
> It looks no issue now.
> Could I need to generate new patch for you?

You can fold into mine.  I'll need to resubmit to ML in anyway before merging.

> I will send this patch to Intel to do the test.

OK, let me know the results (and preferably tested-by tag or such).


thanks,

Takashi


> 
> BR,
> Kailang
> 
> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Thursday, November 29, 2018 3:45 PM
> To: Kailang <kailang@realtek.com>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: HDA headset button support
> 
> On Thu, 29 Nov 2018 08:22:39 +0100,
> Kailang wrote:
> > 
> > Hi Takashi,
> > 
> > I test the patch.
> > It will go to Max or Min volume when I press HS button up or down.
> > 
> > +			state = jack->button_state;
> > +			if (get_jack_plug_state(jack->pin_sense))
> > +				state |= jack->type;
> > +			snd_jack_report(jack->jack, state);
> > 			If (jack->nid == 0x55)
> > 				snd_jack_report(jack->jack, 0); ==> Add this will solve keep volume up and down.
> > 
> > If the pin sense active, it will update Mic and Headphone state. 
> > (Upper code) But it still had chance to update 0x55 during unplug and plug state.
> > So, Maybe need to clear the Button state. I guess.
> 
> As we don't receive button-release events, it makes sense to send the button clear at each time, yes.
> 
> For the one-shot button event, you can handle like below.
> 
> --- a/sound/pci/hda/hda_jack.c
> +++ b/sound/pci/hda/hda_jack.c
> @@ -343,6 +343,11 @@ void snd_hda_jack_report_sync(struct hda_codec *codec)
>  			if (get_jack_plug_state(jack->pin_sense))
>  				state |= jack->type;
>  			snd_jack_report(jack->jack, state);
> +			if (jack->button_state) {
> +				snd_jack_report(jack->jack,
> +						state & ~jack->button_state);
> +				jack->button_state = 0; /* button released */
> +			}
>  		}
>  }
>  EXPORT_SYMBOL_GPL(snd_hda_jack_report_sync);
> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > BR,
> > Kailang
> > 
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > Sent: Wednesday, November 28, 2018 10:05 PM
> > To: Kailang <kailang@realtek.com>
> > Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> > Subject: Re: HDA headset button support
> > 
> > On Wed, 28 Nov 2018 13:03:58 +0100,
> > Kailang wrote:
> > > 
> > > Hi Takashi,
> > > 
> > > >I'd rather like to extend snd_hda_jack_add_kctl() with the key 
> > > >support (maybe adding a new function).  You can pass there the 
> > > >combination of SND_JACK_BTN_X with KEY_XXX in an array.
> > > 
> > > Do you mean create new function like below?
> > > snd_hda_jack_add_key_kctl()
> > > 
> > > It couldn't use snd_hda_jack_add_kctl() directly.
> > > Because it had report pin state and get type from NID.
> > > 
> > > 	type = get_input_jack_type(codec, nid);
> > >         .....
> > >         .....
> > >  	state = snd_hda_jack_detect(codec, nid);
> > > 	snd_jack_report(jack->jack, state ? jack->type : 0);
> > > 
> > > So, to create a new function in hda_jack.c was better.
> > 
> > Well, this seems more deeper than I thought.
> > 
> > Below is my quick attempt to add the infrastructure.  This adds more flexibility but still easiness for other possible button implementations, hopefully.
> > 
> > Could you check the series below?
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > 
> > ------Please consider the environment before printing this e-mail.
> > 
> 
