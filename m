From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v3] ASoC: rt286: add jack detection
 enable/disable APIs and export
Date: Fri, 6 Feb 2015 10:34:49 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BB4C66@SHSMSX101.ccr.corp.intel.com>
References: <1423204800-6448-1-git-send-email-yang.jie@intel.com>
 <CAHXqBFJWaMc5742_=e5QXAmJWsaZDrG0tJMrhED1rN-QK3y3UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id F2A56260530
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 11:35:15 +0100 (CET)
In-Reply-To: <CAHXqBFJWaMc5742_=e5QXAmJWsaZDrG0tJMrhED1rN-QK3y3UA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "mirqus@gmail.com" <mirqus@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Micha=B3 Miros=B3aw [mailto:mirqus@gmail.com]
> Sent: Friday, February 06, 2015 6:21 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [alsa-devel] [PATCH v3] ASoC: rt286: add jack detection
> enable/disable APIs and export
> =

> 2015-02-06 7:40 GMT+01:00 Jie Yang <yang.jie@intel.com>:
> [...]
> > @@ -1012,6 +1039,8 @@ static irqreturn_t rt286_irq(int irq, void *data)
> >         bool mic =3D false;
> >         int status =3D 0;
> >
> > +       if (!rt286->jack)
> > +               return IRQ_HANDLED;
> >         rt286_jack_detect(rt286, &hp, &mic);
> >
> >         /* Clear IRQ */
> =

> This seems wrong. Are you sure you want to return IRQ_HANDLED when you
> did nothing to handle the interrupt?
[Keyon] thanks, yes, I also noticed this. The interrupt will keep coming en=
dlessly with returning IRQ_HANDLED here. :(
> =

> Best Regards,
> Micha=B3 Miros=B3aw
