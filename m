From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hda-intel front headphone (8086:27d8 1043:83bc)
Date: Wed, 6 Jul 2011 12:15:45 +0800
Message-ID: <CAN8ccibefvece13buxhAh0netTzELFNP4HEMeZjx7Z9ND1CBgw@mail.gmail.com>
References: <201107041331.41528.xenogenesi@virgilio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 493991037F3
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 06:15:46 +0200 (CEST)
Received: by fxh2 with SMTP id 2so7205888fxh.9
	for <alsa-devel@alsa-project.org>; Tue, 05 Jul 2011 21:15:46 -0700 (PDT)
In-Reply-To: <201107041331.41528.xenogenesi@virgilio.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/7/4 Alex <xenogenesi@virgilio.it>:
> Hi,
>
> I run a Debian/sid on an Asus P5KPL-SE mainboard, the snd-hda-intel seem to
> work fine, ever if it run with guess method:
>
> Unknown hardware: "HDA-Intel" "Realtek ALC887"
> "HDA:10ec0887,104383bc,00100202" "0x1043" "0x83bc"
> Hardware is initialized using a guess method

This is the message from "alsactl init"

>
> The only annoying thing is about the front headphone, every mixer application
> show the front headphone item but doesn't have adjustable level and I hear
> nothing on headphone.
>
> Any hint?
>
> http://www.alsa-project.org/db/?f=d6bc3005fab4683f2606e48f2bc909258a4ee3e3
>

The codec alc887 in your  Asus P5KPL-SE seem different from

http://www.asus.com/Motherboards/Intel_Socket_775/P5KPL_SE/#specifications

ALC662 High Definition Audio 6 -Channel CODEC
Audio Jack-detect Technology

according to your codec info

it seem that those fix_pin and multi_pin have the same capability to
connect to any DAC


static int alc880_auto_create_extra_out(struct alc_spec *spec, hda_nid_t pin,
					const char *pfx)
{

	} else if (alc880_is_multi_pin(pin)) {
+		nid = alc880_idx_to_dac(alc880_multi_pin_idx(pin));
+		/* specify the DAC as the extra output */
+		if (!spec->multiout.hp_nid)
+			spec->multiout.hp_nid = nid;
+		else
+			spec->multiout.extra_out_nid[0] = nid;
+		/* control HP volume/switch on the output mixer amp */
+		nid = alc880_idx_to_mixer(alc880_multi_pin_idx(pin));
+		err = add_pb_vol_ctrl(spec, ALC_CTL_WIDGET_VOL, pfx,
+				  HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT));
+		if (err < 0)
+			return err;
		/* set manual connection */
		/* we have only a switch on HP-out PIN */
		err = add_pb_sw_ctrl(spec, ALC_CTL_WIDGET_MUTE, pfx,
				  HDA_COMPOSE_AMP_VAL(pin, 3, 0, HDA_OUTPUT));
		if (err < 0)
			return err;
	}
	return 0;
