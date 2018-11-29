From: Kailang <kailang@realtek.com>
Subject: Re: HDA headset button support
Date: Thu, 29 Nov 2018 07:22:39 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1841FB60@RTITMBSV02.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A1841FAEF@RTITMBSV02.realtek.com.tw>
 <s5ho9a9uwkr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id D50B4267B21
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2018 08:22:46 +0100 (CET)
In-Reply-To: <s5ho9a9uwkr.wl-tiwai@suse.de>
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

I test the patch.
It will go to Max or Min volume when I press HS button up or down.

+			state = jack->button_state;
+			if (get_jack_plug_state(jack->pin_sense))
+				state |= jack->type;
+			snd_jack_report(jack->jack, state);
			If (jack->nid == 0x55)
				snd_jack_report(jack->jack, 0); ==> Add this will solve keep volume up and down.

If the pin sense active, it will update Mic and Headphone state. (Upper code)
But it still had chance to update 0x55 during unplug and plug state.
So, Maybe need to clear the Button state. I guess.

BR,
Kailang

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de> 
Sent: Wednesday, November 28, 2018 10:05 PM
To: Kailang <kailang@realtek.com>
Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
Subject: Re: HDA headset button support

On Wed, 28 Nov 2018 13:03:58 +0100,
Kailang wrote:
> 
> Hi Takashi,
> 
> >I'd rather like to extend snd_hda_jack_add_kctl() with the key 
> >support (maybe adding a new function).  You can pass there the 
> >combination of SND_JACK_BTN_X with KEY_XXX in an array.
> 
> Do you mean create new function like below?
> snd_hda_jack_add_key_kctl()
> 
> It couldn't use snd_hda_jack_add_kctl() directly.
> Because it had report pin state and get type from NID.
> 
> 	type = get_input_jack_type(codec, nid);
>         .....
>         .....
>  	state = snd_hda_jack_detect(codec, nid);
> 	snd_jack_report(jack->jack, state ? jack->type : 0);
> 
> So, to create a new function in hda_jack.c was better.

Well, this seems more deeper than I thought.

Below is my quick attempt to add the infrastructure.  This adds more flexibility but still easiness for other possible button implementations, hopefully.

Could you check the series below?


thanks,

Takashi


------Please consider the environment before printing this e-mail.
