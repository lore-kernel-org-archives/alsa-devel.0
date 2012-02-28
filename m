From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 7/7] ASoC: ep93xx-pcm: Use dmaengine
 PCM	helper functions
Date: Tue, 28 Feb 2012 09:47:50 +0100
Message-ID: <4F4C94B6.4050508@metafoo.de>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>	<1329904151-5927-8-git-send-email-lars@metafoo.de>	<20120227081933.GA3868@mwesterb-mobl.ger.corp.intel.com>	<4F4B442D.2050902@metafoo.de>
	<20120227190159.GC3868@mwesterb-mobl.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-161.synserver.de (smtp-out-182.synserver.de
	[212.40.185.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 133A524554
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 09:46:04 +0100 (CET)
In-Reply-To: <20120227190159.GC3868@mwesterb-mobl.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 02/27/2012 08:01 PM, Mika Westerberg wrote:
> On Mon, Feb 27, 2012 at 09:51:57AM +0100, Lars-Peter Clausen wrote:
>> On 02/27/2012 09:19 AM, Mika Westerberg wrote:
>>> On Wed, Feb 22, 2012 at 10:49:11AM +0100, Lars-Peter Clausen wrote:
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>
>>> For some reason, this doesn't work on my ep93xx based Sim.One board. On
>>> playback with mpg123 when I press stop, it continues to play whatever w=
as on
>>> the ring-buffer forever. Without the patches it works fine.
>>>
>>> I'll try to find some time to debug this further.
>>
>> Hm, that=92s interesting. The original ep93xx pcm driver was almost iden=
tical
>> to what the common helper functions do. The only difference I can spot r=
ight
>> now is, that it doesn't call dma_issue_pending after submitting the
>> descriptor. Could you try to comment out the dma_issue_pending in
>> soc-dmaengine-pcm.c and test whether it makes a difference?
> =

> I did try that but there was no effect, unfortunately.
> =

> However, I noticed that prtd->pos was never set to zero as it was in the
> original ep93xx-pcm driver. With following addition to your patch, playba=
ck
> works fine.
> =


Ah, nice :)

Thanks,
- Lars

> diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
> index 0526cf8..4420b70 100644
> --- a/sound/soc/soc-dmaengine-pcm.c
> +++ b/sound/soc/soc-dmaengine-pcm.c
> @@ -142,6 +142,7 @@ static int dmaengine_pcm_prepare_and_submit(struct sn=
d_pcm_substream *substream)
>  =

>  	direction =3D snd_pcm_substream_to_dma_direction(substream);
>  =

> +	prtd->pos =3D 0;
>  	desc =3D chan->device->device_prep_dma_cyclic(chan,
>  		substream->runtime->dma_addr,
>  		snd_pcm_lib_buffer_bytes(substream),
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
