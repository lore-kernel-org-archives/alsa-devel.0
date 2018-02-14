From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4] ASoC: tlv320aic31xx: Fix master mode
 clock I2S bus clocks
Date: Wed, 14 Feb 2018 14:31:39 +0200
Message-ID: <944b202f-06fc-90f5-f8dd-50dc227a06ef@ti.com>
References: <20180214081348.4322-1-peter.ujfalusi@ti.com>
 <20180214115703.GB12658@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 55469267A72
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 13:31:08 +0100 (CET)
In-Reply-To: <20180214115703.GB12658@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, afd@ti.com
List-Id: alsa-devel@alsa-project.org



On 2018-02-14 13:57, Mark Brown wrote:
> On Wed, Feb 14, 2018 at 10:13:48AM +0200, Peter Ujfalusi wrote:
>> In the reset state of the codec we do not have complete playback or capt=
ure
>> routes.
> =

> Unfortuanetly this conflicts with the CODEC to component transition
> patches that went in just after the merge window - could you rebase on
> my current tree please?

Sure, sent v5 and at the same time tested the CODEC to component
conversion ;)

- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
