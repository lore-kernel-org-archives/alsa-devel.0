From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: Protect hw_params
 callback against race
Date: Mon, 12 Aug 2019 15:56:11 +0300
Message-ID: <4055fa34-c6b8-5b47-c728-54e65ef0f16c@ti.com>
References: <20190812095304.19030-1-peter.ujfalusi@ti.com>
 <20190812111332.GH4592@sirena.co.uk>
 <20154773-1cf8-4e2e-a248-f3dfb29a5024@ti.com>
 <20190812115751.GI4592@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B36DF8015A
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 14:56:02 +0200 (CEST)
In-Reply-To: <20190812115751.GI4592@sirena.co.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, jsarha@ti.com, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org



On 12/08/2019 14.57, Mark Brown wrote:
> On Mon, Aug 12, 2019 at 02:46:33PM +0300, Peter Ujfalusi wrote:
> =

>> to card level could substitute (new mutex on the card for pcm operations
>> probably) the need to handle this in drivers.
> =

>> We would need to change soc-core/pcm/compress for this.
> =

> Yeah, it'd be a reasonably substantial change.

OK, works fine on several boards, I'll send a patch tomorrow after a bit
more testing.

- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
