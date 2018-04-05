From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Conversion to int16_t and resolution loss with
 rate converter plugins
Date: Thu, 5 Apr 2018 13:35:59 +0900
Message-ID: <b435dc74-b2fb-7e29-6bb5-778b262fb5c8@sakamocchi.jp>
References: <MWHPR21MB0478EFE0FDB4BD2A0A7293D0D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id DAC3D2673D3
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 06:36:02 +0200 (CEST)
In-Reply-To: <MWHPR21MB0478EFE0FDB4BD2A0A7293D0D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
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
To: Flavio Protasio Ribeiro <flaviopr@microsoft.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 5 2018 12:05, Flavio Protasio Ribeiro wrote:
> The libsamplerate and speex rate converter plugins only implement the convert_s16 callback from snd_pcm_rate_ops_t. This has ALSA convert the buffer to int16_t before handing it over to the plugin for resampling. On devices with more than 16 effective bits, this implies words gets truncated and bits are lost.
> 
> Specifically for libsamplerate, the resampling is internally implemented with floats, so truncating to 16 bits does not offer a computational benefit.
> 
> I get why only convert_s16 is implemented for plugins that aren't part of the main alsa-lib package. The more generic convert callback comes with the burden having the plugin support conversion from/to any of the ALSA data types (or alternatively, having the plugin source include plugin_ops.h and its dependencies). So here's what I propose: replace convert_s16 with a convert_s32 callback which uses int32_t instead of int16_t. This would preserve all bits from the device and keep the plugin interface simple. Of course this means plugins have to be updated to use convert_s32 and rebuilt.

Indeed. Current implementation of each of PCM rate plugins have the
restriction. All of them get callbacks for buffer with s16 PCM samples.
However, there seems to be a reason for what they're, in my opinion.

At present, we have 'snd_pcm_rate_ops_t' as a SDK interface for alsa-lib
PCM rate. Let's see layout of the structure.

(include/pcm_rate.h)
  58 /** Callback table of rate-converter */
  59 typedef struct snd_pcm_rate_ops {
  ...
  80     /**
  81      * convert the data
  82      */
  83     void (*convert)(void *obj,
  84             const snd_pcm_channel_area_t *dst_areas,
  85             snd_pcm_uframes_t dst_offset, unsigned int dst_frames,
  86             const snd_pcm_channel_area_t *src_areas,
  87             snd_pcm_uframes_t src_offset, unsigned int src_frames);
  88     /**
  89      * convert an s16 interleaved-data array; exclusive with convert
  90      */
  91     void (*convert_s16)(void *obj, int16_t *dst, unsigned int 
dst_frames,
  92             const int16_t *src, unsigned int src_frames);
...
117 } snd_pcm_rate_ops_t;

I understand you suggest to merge these two methods; 'convert' and
'convert_s16'. These two methods were introduced at a commit
33d69ef33be2 ('Create rate converter plugin SDK')[1]. which introduced 
framework for the SDK.

Here, let me consider about the reason to have added these two methods.
In my opinion, the biggest reason comes from consideration about variety
of 'snd_pcm_channel_area_t'. This represents layout of buffer for PCM
samples. Let me see the detail.

(include/pcm.h)
467 /** PCM area specification */
468 typedef struct _snd_pcm_channel_area {
469     /** base address of channel samples */
470     void *addr;
471     /** offset to first sample in bits */
472     unsigned int first;
473     /** samples distance in bits */
474     unsigned int step;
475 } snd_pcm_channel_area_t;

When applications parse data of this structure, they can know layout of
the buffer; e.g. 'interleaved', 'non-interleaved' and 'complex'. It
means that it's not enough for implementation of pcm rate plugin if
developers of rate plugin just consider 'interleaved'. For example, some
drivers in kernel land use 'non-interleaved' buffer and expose the area
data for 'non-interleaved' PCM buffer. Additionally, old rme-related
drivers use unique layout of the buffer and expose the area data for
this purpose.

On the other hand, according to code comment, 'convert_s16' method is
just for 'interleaved' case, thus plugin developers has enough distance
of the complexity. I can imagine this comes from practical convenience.

Overall, your idea might push such complication to developers of rate
plugin, while in a practical point it covers most of use cases we have.
However, at least, we should keep that current design has enough care of
the above reasons.

[1] http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=33d69ef33be2


Thanks

Takashi Sakamoto
