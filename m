From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v5 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU
 DAI and platform drivers
Date: Fri, 25 Jul 2014 17:35:25 +0530
Message-ID: <53D24805.9040104@gmail.com>
References: <cover.1406276436.git.nicoleotsuka@gmail.com>
 <2288e61e600e28448905e32dd4f74a954110248f.1406276436.git.nicoleotsuka@gmail.com>
 <53D240B3.8060203@gmail.com> <20140725112807.GA29852@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E9C22610CE
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 14:06:57 +0200 (CEST)
Received: by mail-pa0-f46.google.com with SMTP id lj1so6003481pab.33
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 05:06:56 -0700 (PDT)
In-Reply-To: <20140725112807.GA29852@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de, linux-kernel@vger.kernel.org, rdunlap@infradead.org, b02247@freescale.com, lgirdwood@gmail.com, robh+dt@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org, galak@codeaurora.org, grant.likely@linaro.org, tklauser@distanz.ch, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 07/25/2014 04:58 PM, Nicolin Chen wrote:
> Hi Varka,
>
> On Fri, Jul 25, 2014 at 05:04:11PM +0530, Varka Bhadram wrote:
>> On 07/25/2014 02:16 PM, Nicolin Chen wrote:
>>> The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a
>>> signal associated with an input clock into a signal associated with a different
>>> output clock. The driver currently works as a Front End of DPCM with other Back
>>> Ends DAI links such as ESAI<->CS42888 and SSI<->WM8962 and SAI. It converts the
>>> original sample rate to a common rate supported by Back Ends for playback while
>>> converts the common rate of Back Ends to a desired rate for capture. It has 3
>>> pairs to support three different substreams within totally 10 channels.
>>>
>>> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
>>> ---
>>>   .../devicetree/bindings/sound/fsl,asrc.txt         |  60 ++
>>>   sound/soc/fsl/Kconfig                              |   9 +
>>>   sound/soc/fsl/Makefile                             |   2 +
>>>   sound/soc/fsl/fsl_asrc.c                           | 992 +++++++++++++++++++++
>>>   sound/soc/fsl/fsl_asrc.h                           | 461 ++++++++++
>>>   sound/soc/fsl/fsl_asrc_dma.c                       | 386 ++++++++
>>>   6 files changed, 1910 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
>>>   create mode 100644 sound/soc/fsl/fsl_asrc.c
>>>   create mode 100644 sound/soc/fsl/fsl_asrc.h
>>>   create mode 100644 sound/soc/fsl/fsl_asrc_dma.c
>>>
>>>
>> check patch warnings on this patch...
> [...]
>
> ./scripts/checkpatch.pl --max-line-length=128 0002-ASoC-fsl_a....patch
> total: 0 errors, 0 warnings, 1928 lines checked
>
> 0002-ASoC....patch has no obvious style problems and is ready for submission
>
> [...]
>
> I think there's no need to be so strict by wrapping all lines inside
> 80 characters, especially for those that will be less readable if being
> wrapped and for those in header file.
>
>
Ohhh .. If this is the case, patch addressed all of comments... Thanks..

/Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>/

-- 
Regards,
Varka Bhadram.
