From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Conversion to int16_t and resolution loss with
 rate converter plugins
Date: Mon, 9 Apr 2018 16:32:44 +0900
Message-ID: <1656f543-b23a-ca14-47f8-38e4ea559395@sakamocchi.jp>
References: <MWHPR21MB0478EFE0FDB4BD2A0A7293D0D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
 <b435dc74-b2fb-7e29-6bb5-778b262fb5c8@sakamocchi.jp>
 <MWHPR21MB0478AF6C62CC2AEABFF15533D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 28A80266C1C
 for <alsa-devel@alsa-project.org>; Mon,  9 Apr 2018 09:32:48 +0200 (CEST)
In-Reply-To: <MWHPR21MB0478AF6C62CC2AEABFF15533D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
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

Sorry for delay.

On Apr 6 2018 06:10, Flavio Protasio Ribeiro wrote:
> My original proposal was to replace 'convert_s16' with 'convert_s32', while keeping 'convert'. Looking at your previous thread with Pavel on this topic, recognize your policy of not breaking binary compatibility with previous plugins.
> 
> So instead I propose adding a 'convert_s32' method (at the end of snd_pcm_rate_ops_t, with appropriate versioning) that gets called by default if the plugin implements it. The simplified code would look like:
> 
> (pcm_rate.c)
> static void do_convert(const snd_pcm_channel_area_t *dst_areas,
>                         snd_pcm_uframes_t dst_offset, unsigned int dst_frames,
>                         const snd_pcm_channel_area_t *src_areas,
>                         snd_pcm_uframes_t src_offset, unsigned int src_frames,
>                         unsigned int channels,
>                         snd_pcm_rate_t *rate)
> {
>          if (rate->ops.convert_s32) {
>                  convert_to_s32(rate, rate->src_buf, src_areas, src_offset, src_frames, channels);
>                  rate->ops.convert_s32(rate->obj, dst, dst_frames, src, src_frames);
>                  convert_from_s32(rate, rate->dst_buf, dst_areas, dst_offset,  dst_frames, channels);
>          } else if (rate->ops.convert_s16) {
>                  convert_to_s16(rate, rate->src_buf, src_areas, src_offset, src_frames, channels);
>                  rate->ops.convert_s16(rate->obj, dst, dst_frames, src, src_frames);
>                  convert_from_s16(rate, rate->dst_buf, dst_areas, dst_offset,  dst_frames, channels);
>          } else {
>                  rate->ops.convert(rate->obj, dst_areas, dst_offset, dst_frames,
>                                     src_areas, src_offset, src_frames);
>          }
> }
> 
> What do you think? If this looks good to you I can provide a patch.

Hm. In my opinion, in a point of existent
'struct snd_pcm_rate_ops.convert()', the new
'struct snd_pcm_rate_ops.convert_s32()' is not necessarily required.
Developers can implement conversion with data of any 32 bit physical
width as long as implementing buffer handling according to
'snd_pcm_channel_area_t' in backend of PCM plugin.

On the other hand, I recognize the new
'struct snd_pcm_rate_ops.convert_s32()' might be a fast path for cases 
that sample data is 32 bit physical width and aligned to interleaved
(packed) order. I can assume this can cover most use cases with
'.convert_s16()'.

However, at first place, it's better to utilize existent
'.convert_s32()' because no need to update interface version. When you
face performance issues, then work for the new API. Thus at present,
each plugin needs to parse 'snd_pcm_channel_area_t' and align sample
data according to alignment which used libraries; e.g. libsamplerate
requires.


Pavel's patch (0001-Support-for-float-samples-in-rate-converters.patch)
converts sample data to/from float/integer inner ALSA PCM rate plugin
according to API specification of libsamplerate/libspeex, as he said[1].
However, when considering that libsamplerate/libspeex have conversion
helper APIs or perform conversion internally, it's better to delegate
the task to judge the way to convert float/interger into each
implementation of PCM rate backend. As long as I know, below methods are
available for this purpose on below backends:

libsamplerate:
  * src_short_to_float_array()
  * src_float_to_short_array()
  * src_int_to_float_array()
  * src_float_to_int_array()
libspeex:
  * Below conversion API performs conversion of sample data to float as
    well.
   * speex_resampler_process_int()
   * speex_resampler_process_interleaved_int()
libswresample (obsoletes libavresample):
  * Below conversion API performs conversion of sample data to float as
    well if correctly configured.
   * swr_convert()

However, his patch is a good example for how to parse
'snd_pcm_channel_area_t', in my opinion. But I don't avoid to change the
other parts; e.g. code on pcm rate plugin itself.

On Apr 6 2018 15:32, Pavel Hofman wrote:
 > But the existing rate API will have to be modified since libsoxr
 > behaves  a bit different to speex or libresample - see the library
 > author discussing the issues
 > 
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066764.html

I get 404 from these links. Could I request more detail about a
requirement of modification for libsoxr?

[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-April/134065.html


Regards

Takashi Sakamoto
