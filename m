From: Vincent Meserette <vmeserette@aldebaran-robotics.com>
Subject: Re: issue with AD1989A HDA codec and alsamixer
Date: Wed, 2 Feb 2011 20:22:43 +0100
Message-ID: <AANLkTikRJtbkSewNxEC_SqapNXQookdcHit4cDDix_s7@mail.gmail.com>
References: <AANLkTin8tsrNrcoYaPvQz0uO=OtD-tow1Ds0i8WTJyh7@mail.gmail.com>
	<AANLkTinec0di98dMdyNoANXBoLG_uRJ+NghEyboCuMUa@mail.gmail.com>
	<AANLkTim-Vq6bhd=nHOVkToMSuT9R1n3nnQi-J4bzZNc_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 90B1C24790
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 20:22:44 +0100 (CET)
Received: by eyg24 with SMTP id 24so270612eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Feb 2011 11:22:44 -0800 (PST)
In-Reply-To: <AANLkTim-Vq6bhd=nHOVkToMSuT9R1n3nnQi-J4bzZNc_@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

Many thanks for your answer.

Looking the AD1989A datasheet (which can be found here :
http://www.conexant.com/products/entry.jsp?id=599) the vendor id of the
codec seems to be 11D4989A
So, I think the codec taken into account in the "patch_analog.c" file is
well the AD1989A because I found these lines in the source code :

/*
 * patch entries
 */
static struct hda_codec_preset snd_hda_preset_analog[] = {
   ...
    { .id = 0x11d4989a, .name = "AD1989A", .patch = patch_ad1988 },
   ...
    {} /* terminator */
};

Concerning the digital microphone input of the codec, I don't use it. I have
four electret microphones connected to the B and C ports of the codec (one
on the PORT-B_L pin, one on the PORT-B_R pin, one on the PORT-C_L pin and
one on the PORT-C_R pin). I have connected by software configuration the
port B to the ADC1 and the port C to the ADC0.
Maybe my problem comes from here, because I don't use the codec in a
standard configuration ?
if it is the case, do you know how can i resolve it ?
Do you also know which registers control the three capture gains of the
alsamixerl (i thought it was the gains of the ADC0, ADC1 and ADC2 )?

Many thanks

Kind regards

Vincent




2011/2/2 Raymond Yau <superquad.vortex2@gmail.com>

> 2011/2/2 Raymond Yau <superquad.vortex2@gmail.com>
>
> >
> >
> > 2011/2/1 Vincent Meserette <vmeserette@aldebaran-robotics.com>
> >
> > Hi all,
> >>
> >> I am working on a system which includes a connexant AD1989A HDA codec
> >> connected to a ATOM processor.
> >> I have four microphones connected to the B and C ports of this codec.
> >> If I change one of the 3 capture gains present in the alsamixer
> >> (Capture, Capture 1 or Capture 3), I can't have any more signal on the
> >> B and C ports
> >> It seems to be due to the fact that ALSA breaks (for example for the
> >> Capture gain) the link between the ADC selector 0 and ADC_0 widgets of
> >> the codec, what can be easily seen with codecgraph.
> >>
> >> Have you ever had this kind of problem?
> >> Do you know how can I resolve it ?
> >>
> >> Many thanks for your asnwers and best regards
> >>
> >> Vincent
> >>
> >
> > What is the Vendor Id of conexant AD1989A ?
> >
> > are your codec are using patch_analog.c according to vendor id of the
> codec
> > ?
> >
> > Looking at the datasheet of ad1988a , ad1988b and ad1989b at analog
> device
> > web site and ad1989a conexant web site
> >
> > The digital microphone of conexant ad1989a only connect to adc0 in the
> > functional block diagram
> >
> >
> If the number of input sources of adc0 of ad1989a is more than those of
> adc1
> and adc2
>
> This may mean that you will need to implement a specific
> ad1989a_capture_mixer[] for ad1989a instead of using ad1988_capture_mixer
> and
>
> may need to implement ad1989a_pcm_analog_alt_capture  for adc1 and adc2
> similar to alc880_pcm_analog_alt_capture
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
--------------------------------------------------------
-------- acoustic / audio engineer ---------
-----------  Aldebaran Robotics -------------
168 bis / 170, rue Raymond Losserand
---------------- 75014 PARIS-------------------
----- Phone : +33(0)1.77.37.17.66 -------
----- Mobile : +33(0)6.89.35.71.85 -------
--------------------------------------------------------
