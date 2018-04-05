From: Flavio Protasio Ribeiro <flaviopr@microsoft.com>
Subject: Re: Conversion to int16_t and resolution loss with
 rate converter plugins
Date: Thu, 5 Apr 2018 21:10:43 +0000
Message-ID: <MWHPR21MB0478AF6C62CC2AEABFF15533D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <MWHPR21MB0478EFE0FDB4BD2A0A7293D0D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
 <b435dc74-b2fb-7e29-6bb5-778b262fb5c8@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0131.outbound.protection.outlook.com [104.47.34.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C01026732A
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 23:10:47 +0200 (CEST)
In-Reply-To: <b435dc74-b2fb-7e29-6bb5-778b262fb5c8@sakamocchi.jp>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thanks for the detailed explanations.

My original proposal was to replace 'convert_s16' with 'convert_s32', while keeping 'convert'. Looking at your previous thread with Pavel on this topic, recognize your policy of not breaking binary compatibility with previous plugins.

So instead I propose adding a 'convert_s32' method (at the end of snd_pcm_rate_ops_t, with appropriate versioning) that gets called by default if the plugin implements it. The simplified code would look like:

(pcm_rate.c)
static void do_convert(const snd_pcm_channel_area_t *dst_areas,
                       snd_pcm_uframes_t dst_offset, unsigned int dst_frames,
                       const snd_pcm_channel_area_t *src_areas,
                       snd_pcm_uframes_t src_offset, unsigned int src_frames,
                       unsigned int channels,
                       snd_pcm_rate_t *rate)
{
        if (rate->ops.convert_s32) {
                convert_to_s32(rate, rate->src_buf, src_areas, src_offset, src_frames, channels);
                rate->ops.convert_s32(rate->obj, dst, dst_frames, src, src_frames);
                convert_from_s32(rate, rate->dst_buf, dst_areas, dst_offset,  dst_frames, channels);
        } else if (rate->ops.convert_s16) {
                convert_to_s16(rate, rate->src_buf, src_areas, src_offset, src_frames, channels);
                rate->ops.convert_s16(rate->obj, dst, dst_frames, src, src_frames);
                convert_from_s16(rate, rate->dst_buf, dst_areas, dst_offset,  dst_frames, channels);
        } else {
                rate->ops.convert(rate->obj, dst_areas, dst_offset, dst_frames,
                                   src_areas, src_offset, src_frames);
        }
}

What do you think? If this looks good to you I can provide a patch.

Thanks,
Flavio

-----Original Message-----
From: Takashi Sakamoto <o-takashi@sakamocchi.jp> 
Sent: Wednesday, April 4, 2018 9:36 PM
To: Flavio Protasio Ribeiro <flaviopr@microsoft.com>; alsa-devel@alsa-project.org
Subject: Re: Conversion to int16_t and resolution loss with rate converter plugins

Hi,

On Apr 5 2018 12:05, Flavio Protasio Ribeiro wrote:
> The libsamplerate and speex rate converter plugins only implement the convert_s16 callback from snd_pcm_rate_ops_t. This has ALSA convert the buffer to int16_t before handing it over to the plugin for resampling. On devices with more than 16 effective bits, this implies words gets truncated and bits are lost.
> 
> Specifically for libsamplerate, the resampling is internally implemented with floats, so truncating to 16 bits does not offer a computational benefit.
> 
> I get why only convert_s16 is implemented for plugins that aren't part of the main alsa-lib package. The more generic convert callback comes with the burden having the plugin support conversion from/to any of the ALSA data types (or alternatively, having the plugin source include plugin_ops.h and its dependencies). So here's what I propose: replace convert_s16 with a convert_s32 callback which uses int32_t instead of int16_t. This would preserve all bits from the device and keep the plugin interface simple. Of course this means plugins have to be updated to use convert_s32 and rebuilt.

Indeed. Current implementation of each of PCM rate plugins have the restriction. All of them get callbacks for buffer with s16 PCM samples.
However, there seems to be a reason for what they're, in my opinion.

At present, we have 'snd_pcm_rate_ops_t' as a SDK interface for alsa-lib PCM rate. Let's see layout of the structure.

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

I understand you suggest to merge these two methods; 'convert' and 'convert_s16'. These two methods were introduced at a commit
33d69ef33be2 ('Create rate converter plugin SDK')[1]. which introduced framework for the SDK.

Here, let me consider about the reason to have added these two methods.
In my opinion, the biggest reason comes from consideration about variety of 'snd_pcm_channel_area_t'. This represents layout of buffer for PCM samples. Let me see the detail.

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

When applications parse data of this structure, they can know layout of the buffer; e.g. 'interleaved', 'non-interleaved' and 'complex'. It means that it's not enough for implementation of pcm rate plugin if developers of rate plugin just consider 'interleaved'. For example, some drivers in kernel land use 'non-interleaved' buffer and expose the area data for 'non-interleaved' PCM buffer. Additionally, old rme-related drivers use unique layout of the buffer and expose the area data for this purpose.

On the other hand, according to code comment, 'convert_s16' method is just for 'interleaved' case, thus plugin developers has enough distance of the complexity. I can imagine this comes from practical convenience.

Overall, your idea might push such complication to developers of rate plugin, while in a practical point it covers most of use cases we have.
However, at least, we should keep that current design has enough care of the above reasons.

[1] https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fgit.alsa-project.org%2F%3Fp%3Dalsa-lib.git%3Ba%3Dcommit%3Bh%3D33d69ef33be2&data=02%7C01%7Cflaviopr%40microsoft.com%7C1134959ba0c04504a86c08d59aaebc33%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636584997637619662&sdata=cJ5P%2FNxyArIG70RT5DuISuaYp53vOIir1cI6snqCNpc%3D&reserved=0


Thanks

Takashi Sakamoto
