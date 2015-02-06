From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v3] ASoC: rt286: add jack detection
 enable/disable APIs and export
Date: Fri, 6 Feb 2015 11:21:18 +0100
Message-ID: <CAHXqBFJWaMc5742_=e5QXAmJWsaZDrG0tJMrhED1rN-QK3y3UA@mail.gmail.com>
References: <1423204800-6448-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D8B7260530
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 11:21:39 +0100 (CET)
Received: by mail-ob0-f176.google.com with SMTP id wo20so12394383obc.7
 for <alsa-devel@alsa-project.org>; Fri, 06 Feb 2015 02:21:38 -0800 (PST)
In-Reply-To: <1423204800-6448-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

2015-02-06 7:40 GMT+01:00 Jie Yang <yang.jie@intel.com>:
[...]
> @@ -1012,6 +1039,8 @@ static irqreturn_t rt286_irq(int irq, void *data)
>         bool mic =3D false;
>         int status =3D 0;
>
> +       if (!rt286->jack)
> +               return IRQ_HANDLED;
>         rt286_jack_detect(rt286, &hp, &mic);
>
>         /* Clear IRQ */

This seems wrong. Are you sure you want to return IRQ_HANDLED when you
did nothing to handle the interrupt?

Best Regards,
Micha=B3 Miros=B3aw
