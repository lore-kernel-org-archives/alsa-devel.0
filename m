From: "Viliam Kubis" <viliam.kubis@gmail.com>
Subject: Re: Smart 5.1 function not working on VIA VT1708S with
 *three* jacks on mainboard
Date: Mon, 12 Jul 2010 12:58:54 +0200
Message-ID: <op.vfp8sffky9cctd@localhost>
References: <op.ve4vig0ny9cctd@localhost> <op.vff0au0jy9cctd@localhost>
	<4C35713E.1090709@ladisch.de> <op.vfi2hgary9cctd@localhost>
	<op.vfko2mysy9cctd@localhost> <4C3ABCF7.3050108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id C369E243BA
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jul 2010 12:58:57 +0200 (CEST)
Received: by bwz4 with SMTP id 4so2363410bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2010 03:58:57 -0700 (PDT)
In-Reply-To: <4C3ABCF7.3050108@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Oh my god!! It actually works!!! :) At first speaker-test was not working,  
but with

[kbs1@localhost a]$ speaker-test -c4 -twav -Dsurround40 <--------- THIS

speaker-test 1.0.23

Playback device is surround40
Stream parameters are 48000Hz, S16_LE, 4 channels
WAV file(s)
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 32 to 8192
Period size range from 16 to 4096
Using max buffer size 8192
Periods = 4
was set period_size = 2048
was set buffer_size = 8192
  0 - Front Left
  1 - Front Right
  3 - Rear Right <-------------- THIS PLAYS
  2 - Rear Left <-------------- AND THIS PLAYS!!
Time per period = 5.718945
  0 - Front Left
^C
[kbs1@localhost a]$

Finally! My audio experience is now at a whole new level. Thank you very  
much, I will post this patch to alsa-bugtracker and close the bug, I was  
starting to think that this is a kernel problem, but now it just works  
GREAT.

Maybe you can add this patch to official alsa-driver version on next  
release.

Have a nice day!
Best Regards
Viliam Kubis

On Mon, 12 Jul 2010 08:57:59 +0200, Clemens Ladisch <clemens@ladisch.de>  
wrote:

> Viliam Kubis wrote:
>> I have tried the patch ..., but the surround does not work.
>
> Okay, next try:
>
> --- a/sound/pci/hda/patch_via.c
> +++ b/sound/pci/hda/patch_via.c
> @@ -552,24 +552,30 @@ static void via_auto_init_hp_out(struct
>  	}
>  }
> +static int is_smart51_pins(struct via_spec *spec, hda_nid_t pin);
> +
>  static void via_auto_init_analog_input(struct hda_codec *codec)
>  {
>  	struct via_spec *spec = codec->spec;
> +	unsigned int ctl;
>  	int i;
> 	for (i = 0; i < AUTO_PIN_LAST; i++) {
>  		hda_nid_t nid = spec->autocfg.input_pins[i];
> +		if (!nid)
> +			continue;
> +		if (spec->smart51_enabled && is_smart51_pins(spec, nid))
> +			ctl = PIN_OUT;
> +		else if (i <= AUTO_PIN_FRONT_MIC)
> +			ctl = PIN_VREF50;
> +		else
> +			ctl = PIN_IN;
>  		snd_hda_codec_write(codec, nid, 0,
> -				    AC_VERB_SET_PIN_WIDGET_CONTROL,
> -				    (i <= AUTO_PIN_FRONT_MIC ?
> -				     PIN_VREF50 : PIN_IN));
> -
> +				    AC_VERB_SET_PIN_WIDGET_CONTROL, ctl);
>  	}
>  }
> -static int is_smart51_pins(struct via_spec *spec, hda_nid_t pin);
> -
>  static void set_pin_power_state(struct hda_codec *codec, hda_nid_t nid,
>  				unsigned int *affected_parm)
>  {
> @@ -658,6 +664,8 @@ static void set_jack_power_state(struct
>  		/* PW0 (19h), SW1 (18h), AOW1 (11h) */
>  		parm = AC_PWRST_D3;
>  		set_pin_power_state(codec, 0x19, &parm);
> +		if (spec->smart51_enabled)
> +			parm = AC_PWRST_D0;
>  		snd_hda_codec_write(codec, 0x18, 0, AC_VERB_SET_POWER_STATE,
>  				    parm);
>  		snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_POWER_STATE,
> @@ -667,6 +675,8 @@ static void set_jack_power_state(struct
>  		if (is_8ch) {
>  			parm = AC_PWRST_D3;
>  			set_pin_power_state(codec, 0x22, &parm);
> +			if (spec->smart51_enabled)
> +				parm = AC_PWRST_D0;
>  			snd_hda_codec_write(codec, 0x26, 0,
>  					    AC_VERB_SET_POWER_STATE, parm);
>  			snd_hda_codec_write(codec, 0x24, 0,
> @@ -3915,6 +3925,13 @@ static int vt1708S_auto_fill_dac_nids(st
>  		}
>  	}
> +	/* for Smart 5.1, line/mic inputs double as output pins */
> +	if (cfg->line_outs == 1) {
> +		spec->multiout.num_dacs = 3;
> +		spec->multiout.dac_nids[AUTO_SEQ_SURROUND] = 0x11;
> +		spec->multiout.dac_nids[AUTO_SEQ_CENLFE] = 0x24;
> +	}
> +
>  	return 0;
>  }
> @@ -3932,7 +3949,8 @@ static int vt1708S_auto_create_multi_out
>  	for (i = 0; i <= AUTO_SEQ_SIDE; i++) {
>  		nid = cfg->line_out_pins[i];
> -		if (!nid)
> +		/* for Smart 5.1, there are always at least six channels */
> +		if (!nid && i > AUTO_SEQ_CENLFE)
>  			continue;
> 		nid_vol = nid_vols[i];


-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
