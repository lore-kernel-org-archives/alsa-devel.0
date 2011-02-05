From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: issue with AD1989A HDA codec and alsamixer
Date: Sat, 5 Feb 2011 17:46:51 +0800
Message-ID: <AANLkTinoF-RqGFo7w57E8C+L5=zKH_hQ+0G0defh0WX-@mail.gmail.com>
References: <AANLkTin8tsrNrcoYaPvQz0uO=OtD-tow1Ds0i8WTJyh7@mail.gmail.com>
	<AANLkTinec0di98dMdyNoANXBoLG_uRJ+NghEyboCuMUa@mail.gmail.com>
	<AANLkTim-Vq6bhd=nHOVkToMSuT9R1n3nnQi-J4bzZNc_@mail.gmail.com>
	<AANLkTikRJtbkSewNxEC_SqapNXQookdcHit4cDDix_s7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id C3EF82465A
	for <alsa-devel@alsa-project.org>; Sat,  5 Feb 2011 10:46:54 +0100 (CET)
Received: by ewy19 with SMTP id 19so1556832ewy.38
	for <alsa-devel@alsa-project.org>; Sat, 05 Feb 2011 01:46:53 -0800 (PST)
In-Reply-To: <AANLkTikRJtbkSewNxEC_SqapNXQookdcHit4cDDix_s7@mail.gmail.com>
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

2011/2/3 Vincent Meserette <vmeserette@aldebaran-robotics.com>

> Hi Raymond,
>
> Many thanks for your answer.
>
> Looking the AD1989A datasheet (which can be found here :
> http://www.conexant.com/products/entry.jsp?id=599) the vendor id of the
> codec seems to be 11D4989A
> So, I think the codec taken into account in the "patch_analog.c" file is
> well the AD1989A because I found these lines in the source code :
>
> /*
>  * patch entries
>  */
> static struct hda_codec_preset snd_hda_preset_analog[] = {
>    ...
>     { .id = 0x11d4989a, .name = "AD1989A", .patch = patch_ad1988 },
>    ...
>     {} /* terminator */
> };
>
> Concerning the digital microphone input of the codec, I don't use it. I
> have four electret microphones connected to the B and C ports of the codec
> (one on the PORT-B_L pin, one on the PORT-B_R pin, one on the PORT-C_L pin
> and one on the PORT-C_R pin). I have connected by software configuration the
> port B to the ADC1 and the port C to the ADC0.
> Maybe my problem comes from here, because I don't use the codec in a
> standard configuration ?
> if it is the case, do you know how can i resolve it ?
> Do you also know which registers control the three capture gains of the
> alsamixerl (i thought it was the gains of the ADC0, ADC1 and ADC2 )?
>

can you post the output of alsa-info.sh

Six 192kHz 92dB ADCs
- simultaneous record of up to 3 stereo channels

It does not imply you can record 4 channels with the existing hda driver
which create three subdevices
