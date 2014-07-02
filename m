From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/4] ALSA: pcm_dmaengine: Correct support
 for 3 physical bytes samples
Date: Wed, 2 Jul 2014 15:56:15 +0300
Message-ID: <53B4016F.9060005@ti.com>
References: <1404300570-14082-1-git-send-email-peter.ujfalusi@ti.com>
 <1404300570-14082-5-git-send-email-peter.ujfalusi@ti.com>
 <53B3FEB5.1040508@ti.com> <53B3FF9C.6060102@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id C45462650CA
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 14:56:20 +0200 (CEST)
In-Reply-To: <53B3FF9C.6060102@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, vinod.koul@intel.com, dan.j.williams@intel.com, tiwai@suse.de, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, joelf@ti.com, nsekhar@ti.com
Cc: dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/02/2014 03:48 PM, Lars-Peter Clausen wrote:
>> per discussion over the irc with Lars we could extend the masking to oth=
er
>> widths as well, which would look something like this:
>> u32 addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>>           BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>>           BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>> ...
>> /*
>>   * Prepare formats mask for valid/allowed sample types. If the dma does
>>   * not have support for the given physical word size, it needs to be
>>   * masked out so user space can not use the format which produces
>>   * corrupted audio.
>>   * In case the dma driver does not implement the slave_caps the default
>>   * assumption is that it supports 1, 2 and 4 bytes widths.
>>   */
>> if (!dma_get_slave_caps(prtd->dma_chan, &dma_caps)) {
>>     if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
>>         addr_widths =3D dma_caps.dstn_addr_widths;
>>     else
>>         addr_widths =3D dma_caps.src_addr_widths;
>> }
>>
>> for (i =3D 0; i <=3D SNDRV_PCM_FORMAT_LAST; i++) {
>>     int bits =3D snd_pcm_format_physical_width(i);
>>
>>     switch (bits) {
>>     case 8:
>>         if (!(addr_widths & BIT(DMA_SLAVE_BUSWIDTH_1_BYTE)))
>>             fmt_mask |=3D (1LL << i);
>>         break;
>>     case 16:
>>         if (!(addr_widths & BIT(DMA_SLAVE_BUSWIDTH_2_BYTES)))
>>             fmt_mask |=3D (1LL << i);
>>         break;
>>     case 24:
>>         if (!(addr_widths & BIT(DMA_SLAVE_BUSWIDTH_3_BYTES)))
>>             fmt_mask |=3D (1LL << i);
>>         break;
>>     case 32:
>>         if (!(addr_widths & BIT(DMA_SLAVE_BUSWIDTH_4_BYTES)))
>>             fmt_mask |=3D (1LL << i);
>>         break;
>>     case 64:
>>         if (!(addr_widths & BIT(DMA_SLAVE_BUSWIDTH_8_BYTES)))
>>             fmt_mask |=3D (1LL << i);
>>         break;
>>     default:
>>         fmt_mask |=3D (1LL << i);
>>         break;
>>     }
>> }
>>
>> Is this sounds better?
> =

> Sounds good. I think we can assume that DMA_SLAVE_BUSWIDTH_1_BYTE =3D 1, =
...
> So (addr_width & BIT(bits / 8)) should work fine and we do not need to
> duplicate the case branches.
> =

> The other thing is this should go into dmaengine_pcm_set_runtime_hwparams=
()
> where we also restrict the other hardware parameters based on the dmaengi=
ne
> capabilities.

true

-- =

P=E9ter
