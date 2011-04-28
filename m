From: Mike Williamson <michael.williamson@criticallink.com>
Subject: Re: [PATCH] audio: tlv320aic26: fix PLL register configuration
Date: Thu, 28 Apr 2011 18:17:45 -0400
Message-ID: <BANLkTikdKHi1Zr8Ae7ko7hkazR5yhHznTQ@mail.gmail.com>
References: <1304026377-21829-1-git-send-email-michael.williamson@criticallink.com>
 <20110428215639.GB19535@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110428215639.GB19535@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lrg@slimlogic.co.uk, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2011 at 5:56 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Apr 28, 2011 at 05:32:57PM -0400, Michael Williamson wrote:
>
>> - =C2=A0 =C2=A0 jval =3D (fsref =3D=3D 44100) ? 7 : 8;
>> - =C2=A0 =C2=A0 dval =3D (fsref =3D=3D 44100) ? 5264 : 1920;
>> + =C2=A0 =C2=A0 jval =3D fsref / (aic26->mclk / 2048);
>> + =C2=A0 =C2=A0 dval =3D fsref - jval * (aic26->mclk / 2048);
>
> I'd like some more brackets on this line, especially given the
> similarity with the previous line. =C2=A0Otherwise this looks fine if=
 a bit
> magic:

I will add some parens (and comment the magic?) and resubmit with your =
ack.

Thanks.

>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
