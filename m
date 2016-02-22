From: Tim Sheridan <tghs@tghs.net>
Subject: Re: Compress offload: DSP buffer timestamp passing
Date: Mon, 22 Feb 2016 16:55:28 +0000
Message-ID: <CAELVyQcb1VYQY6V_t0VE+rPkydXFfnTd1AOUvNaet3qsvs5B5w@mail.gmail.com>
References: <CAELVyQdcVoTV7iGxA=jJGQToobpePB-Fk-scvUbOFBf36X2B+Q@mail.gmail.com>
 <56B37086.30603@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f41.google.com (mail-lf0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AA2B260673
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 17:55:29 +0100 (CET)
Received: by mail-lf0-f41.google.com with SMTP id l143so97932329lfe.2
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 08:55:29 -0800 (PST)
In-Reply-To: <56B37086.30603@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre-Louis,

Thanks for your thoughts. I think that your suggestion for using a
pseudo transport stream is the most appropriate one for timestamping
the buffers of stream.

I've been thinking more about this, and for AXD specifically, we can
do synchronization without the need to pass timestamps for each buffer
in the stream. Instead we can pass a synchronization reference
timestamp (corresponding to the start of the stream) as metadata
(representing the start time of the stream). How appropriate would be
the addition of a DSP private metadata area (accessible over ioctl,
like the generic get/set metadata API)? This would be sufficient to
support AXD's support for scheduled playback. It would also be useful
for supporting other DSP features that aren't currently/too device
specific to be supported in the generic compress offload API.

Patches for this proposal to follow.

Cheers,
Tim

On 4 February 2016 at 15:38, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 2/3/16 5:49 AM, Tim Sheridan wrote:
>>
>> Hi,
>>
>> I've been working on the Imagination Technologies AXD (audio DSP)
>> compress offload driver. One of the features of the DSP is scheduled
>> playback of audio using timestamps (that are obtained by an
>> application from userspace). A current problem with the compress
>> offload API is that there's no "blessed" way to get these timestamps
>> from tinycompress through to our compress offload driver.
>>
>> Currently, I've added a SNDRV_COMPRESS_ENCODER_PTS value to the
>> sndrv_compress_encoder enum, and exposed this with an API in
>> tinycompress, handling this in my driver to pass it to the DSP. Does
>> this sound like a reasonable approach to go about adding compress
>> offload API support for this? Or is there some other part of the ALSA
>> API which would be more appropriate to use instead of this?
>
>
> Not a simple problem I am afraid.
> When we added support for compressed data the focus was really elementary
> streams transferred over DMA - essentially the same model as for PCM which
> doesn't support timestamps either. If you have an application which deals
> with discontinuous buffers associated with timestamps then the model is
> broken.
>
> The only solution I can think of is to create a pseudo transport stream with
> a headset containing the timestamp and the audio data inserted between
> headers. I believe this is what you are suggesting?
>
> Alternatively we could add an API that would match a decoded sample with a
> timestamp but it's not clear how you would synchronize timestamp information
> with the data stream (or rather there could be race conditions leading to
> the timestamps being provided to the hardware too late).
