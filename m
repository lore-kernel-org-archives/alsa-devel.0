From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: Protect hw_params
 callback against race
Date: Mon, 12 Aug 2019 14:46:33 +0300
Message-ID: <20154773-1cf8-4e2e-a248-f3dfb29a5024@ti.com>
References: <20190812095304.19030-1-peter.ujfalusi@ti.com>
 <20190812111332.GH4592@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98C3AF8015B
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 13:46:25 +0200 (CEST)
In-Reply-To: <20190812111332.GH4592@sirena.co.uk>
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



On 12/08/2019 14.13, Mark Brown wrote:
> On Mon, Aug 12, 2019 at 12:53:04PM +0300, Peter Ujfalusi wrote:
>> If the playback and capture of the same McASP is connected to different
>> dai link (non duplex PCM links, like with pcm3168a codec) then there is
>> a high probability of race between the two direction leaving McASP in a
>> confused state.
>>
>> Protect the hw_params() with a mutex to make sure that this is not
>> happening.
> =

> This feels like something we might want to consider moving up to the
> core, though not every device is going to need it I guess it should be
> safe to do there.

soc_pcm_hw_params() is already protected by
mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);

which (I think) gives protection for dai_links when they support both
playback and capture.

I faced with the concurrency when interfacing with pcm3168a codec, which
require two dai_links. One for playback and one for capture so they
don't share the same snd_soc_pcm_runtime.

I believe moving the
mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);

to card level could substitute (new mutex on the card for pcm operations
probably) the need to handle this in drivers.

We would need to change soc-core/pcm/compress for this.

- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
