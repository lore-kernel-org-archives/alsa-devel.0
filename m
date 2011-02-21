From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALC270 alsa
Date: Mon, 21 Feb 2011 22:23:43 +0800
Message-ID: <AANLkTimNSeZ9UNXoH1u7yxJrx-RBdLoX70H2bse1WN95@mail.gmail.com>
References: <AANLkTi=05dgWiiOHoS9HMr=R6GGEn3b1mWy6rkEHM35+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f178.google.com (mail-ey0-f178.google.com
	[209.85.215.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 593D21037E3
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 15:23:46 +0100 (CET)
Received: by eya25 with SMTP id 25so989944eya.9
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 06:23:44 -0800 (PST)
In-Reply-To: <AANLkTi=05dgWiiOHoS9HMr=R6GGEn3b1mWy6rkEHM35+@mail.gmail.com>
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

2011/2/21 Commander <commander.alchemy@gmail.com>

> Hi
>
> Need help with my laptop to get any sound from it.
> Alsa script =
> http://www.alsa-project.org/db/?f=2ce0f50d2d7973d17c8cbdf4ee95f2860365c005
>
> Tried various things however nothing seems to work.
>
> speaker-test -c 2 does not output any sound.
>
> Best Regards
> Artur
>

it seem that your HP G62 is similar to ALC269VB_AMIC

static void alc269vb_laptop_amic_setup(struct hda_codec *codec)
{
	struct alc_spec *spec = codec->spec;
	spec->autocfg.hp_pins[0] = 0x21;
	spec->autocfg.speaker_pins[0] = 0x14;
	spec->ext_mic.pin = 0x18;
	spec->ext_mic.mux_idx = 0;
	spec->int_mic.pin = 0x19;
	spec->int_mic.mux_idx = 1;
	spec->auto_mic = 1;
}

you may need to add a model to use ALC269VB_AMIC

static const char * const alc269_models[ALC269_MODEL_LAST] = {
	[ALC269_BASIC]			= "basic",
	[ALC269_QUANTA_FL1]		= "quanta",
	[ALC269_AMIC]			= "laptop-amic",
	[ALC269_DMIC]			= "laptop-dmic",
+	[ALC269VB_AMIC]			= "hp-g62",
	[ALC269_FUJITSU]		= "fujitsu",
	[ALC269_LIFEBOOK]		= "lifebook",
	[ALC269_AUTO]			= "auto",
};
