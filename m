From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: PATCH[1/1] Add I2S common driver for Intel MID
	platform
Date: Tue, 19 Oct 2010 17:48:23 -0500
Message-ID: <AANLkTim8uEuSYhHyedLn3gbaPQLvwo7Gu+eo-Vo23KvC@mail.gmail.com>
References: <2A84145621092446B6659B8A0F28E26F46FE77084A@irsmsx501.ger.corp.intel.com>
	<20101019213212.GB29234@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DFB67244AC
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Oct 2010 00:48:24 +0200 (CEST)
Received: by iwn9 with SMTP id 9so3408831iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2010 15:48:23 -0700 (PDT)
In-Reply-To: <20101019213212.GB29234@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Le Gall,
	Louis" <louis.le.gall@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

>> =A0 =A0 =A0 =A0 As this is used to transfer speech frames from/to cellul=
ar modem that have specific timing constraints (and modem also uses the I2S=
 path to send some side-info), the Alsa SoC interface cannot be used.
>
> What makes you say this? =A0You have provided no detail on what problems
> you believe exist and since ASoC is a *very* thin wrapper around the
> core ALSA for DMA stuff it is very surprising that you would see any
> issues here that don't also affect plain ALSA. =A0If there are any issues
> then it would seem better to resolve these within the current framework
> rather than completely discarding the entire existing infrastructure.

Louis meant ALSA rather than ASOC. We use burst transfers to reduce
round-trip delay, the whole notion of periods/period elapsed/ring
buffer doesn't make sense here and there is in-band signalling that
should not be interpreted as samples. If ALSA had a simplified API for
byte streams sent over a serial output, we would have no problems
using it and of course ASOC would be used then.

>> +enum mrst_ssp_mode {
>> + =A0 =A0 =A0 SSP_IN_NORMAL_MODE =3D 0x0,
>> + =A0 =A0 =A0 SSP_IN_NETWORK_MODE
>> +};
>
> A lot of this stuff looks suspicously like the SSP ports in Marvell CPUs
> (which were obviously Intel originally).

If it ain't broke don't fix it. :-)

-Pierre
