From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH] hda: Added new IDT codec family
Date: Mon, 5 Nov 2007 17:54:29 +0200
Message-ID: <200711051754.29969.maximlevitsky@gmail.com>
References: <472F3191.2040004@embeddedalley.com> <s5h3avknacw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by alsa0.perex.cz (Postfix) with ESMTP id E76F924386
	for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2007 16:55:36 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id h2so990797ugf
	for <alsa-devel@alsa-project.org>; Mon, 05 Nov 2007 07:55:36 -0800 (PST)
In-Reply-To: <s5h3avknacw.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

On Monday 05 November 2007 14:30:07 Takashi Iwai wrote:
> At Mon, 05 Nov 2007 10:06:57 -0500,
> Matthew Ranostay wrote:
> > =

> > diff -r 3e1a17f8baca pci/hda/hda_codec.h
> > --- a/pci/hda/hda_codec.h	Wed Oct 31 17:36:20 2007 +0100
> > +++ b/pci/hda/hda_codec.h	Sat Nov 03 22:55:14 2007 -0500
> > @@ -92,6 +92,8 @@ enum {
> >   */
> >  #define AC_VERB_SET_STREAM_FORMAT		0x200
> >  #define AC_VERB_SET_AMP_GAIN_MUTE		0x300
> > +#define AC_VERB_SET_RIGHT_AMP_IN_MUTE	0x350
> > +#define AC_VERB_SET_LEFT_AMP_IN_MUTE	0x360
> =

> Usually we pass the values for left or right bits in the parameter
> value (AC_AMP_SET_LEFT and AC_AMP_SET_RIGHT) instead of the verb
> value.  So, no need to redefine them.
> =

> >  #define AC_VERB_SET_PROC_COEF			0x400
Any chance to see data-sheets of newer IDT chips?
There seems to be nothing on the web.
Are they available to general public?

For example STAC9872 has very limited support due to no datasheets.
 =

>+static struct snd_kcontrol_new stac92hd71bxx_mixer[] =3D {
>+=A0=A0=A0=A0=A0=A0=A0STAC_DIGITAL_INPUT_SOURCE(1),
>+=A0=A0=A0=A0=A0=A0=A0STAC_INPUT_SOURCE(2),
>+=A0=A0=A0=A0=A0=A0=A0STAC_VOLKNOB(0x28),
>+
>+=A0=A0=A0=A0=A0=A0=A0/* hardware gain controls */
>+=A0=A0=A0=A0=A0=A0=A0HDA_CODEC_VOLUME("Digital Mic 1 Volume", 0x18, 0, HD=
A_OUTPUT),
>+=A0=A0=A0=A0=A0=A0=A0HDA_CODEC_VOLUME("Digital Mic 2 Volume", 0x19, 0, HD=
A_OUTPUT),
>+=A0=A0=A0=A0=A0=A0=A0
>+=A0=A0=A0=A0=A0=A0=A0HDA_CODEC_VOLUME("Capture Volume", 0x1c, 0, HDA_OUTP=
UT),
>+=A0=A0=A0=A0=A0=A0=A0HDA_CODEC_MUTE("Capture Switch", 0x1c, 0, HDA_OUTPUT=
),
>+=A0=A0=A0=A0=A0=A0=A0HDA_CODEC_VOLUME("Capture Mux Volume", 0x1a, 0, HDA_=
OUTPUT),
>=A0=A0=A0=A0=A0=A0=A0=A0{ } /* end */

The chip has two ADCs, but why just one "Capture Volume" ?
No analog loopback?

Best regards,
	Maxim Levitsky
