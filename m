From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] cs4236: detect cs4236+ chip in one pass
Date: Sun, 1 Nov 2009 14:42:56 +0100
Message-ID: <20091101144256.d827d9e4.krzysztof.h1@poczta.fm>
References: <20091101124738.0eb33f92.krzysztof.h1@poczta.fm>
	<20091101114737.GJ22046@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 2F64924356
	for <alsa-devel@alsa-project.org>; Sun,  1 Nov 2009 14:24:25 +0100 (CET)
In-Reply-To: <20091101114737.GJ22046@sci.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, wim@djo.tudelft.nl, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 1 Nov 2009 13:47:37 +0200
Ville Syrj=E4l=E4 <syrjala@sci.fi> wrote:

> On Sun, Nov 01, 2009 at 12:47:38PM +0100, Krzysztof Helt wrote:
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > =


> > +		if (cport < 0x100 || cport =3D=3D SNDRV_AUTO_PORT) {
> > +			snd_printk(KERN_ERR "please, specify control port "
> > +				   "for CS4236+ chips\n");
> =

> Missing a call to snd_device_free() here.
> =

> > +			return -ENODEV;
> > +		}
> =


Right. I'll prepare next patch.

Regards,
Krzysztof

---------------------------------------------------------------------------=
---
Strrraszny konkurs z Scooby-Doo!
Wez udzial >> http://link.interia.pl/f2412
