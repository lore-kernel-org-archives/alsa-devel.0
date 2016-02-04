From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Compress offload: DSP buffer timestamp passing
Date: Thu, 4 Feb 2016 09:38:46 -0600
Message-ID: <56B37086.30603@linux.intel.com>
References: <CAELVyQdcVoTV7iGxA=jJGQToobpePB-Fk-scvUbOFBf36X2B+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B56012619D0
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 16:38:47 +0100 (CET)
In-Reply-To: <CAELVyQdcVoTV7iGxA=jJGQToobpePB-Fk-scvUbOFBf36X2B+Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Sheridan <tghs@tghs.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2/3/16 5:49 AM, Tim Sheridan wrote:
> Hi,
>
> I've been working on the Imagination Technologies AXD (audio DSP)
> compress offload driver. One of the features of the DSP is scheduled
> playback of audio using timestamps (that are obtained by an
> application from userspace). A current problem with the compress
> offload API is that there's no "blessed" way to get these timestamps
> from tinycompress through to our compress offload driver.
>
> Currently, I've added a SNDRV_COMPRESS_ENCODER_PTS value to the
> sndrv_compress_encoder enum, and exposed this with an API in
> tinycompress, handling this in my driver to pass it to the DSP. Does
> this sound like a reasonable approach to go about adding compress
> offload API support for this? Or is there some other part of the ALSA
> API which would be more appropriate to use instead of this?

Not a simple problem I am afraid.
When we added support for compressed data the focus was really 
elementary streams transferred over DMA - essentially the same model as 
for PCM which doesn't support timestamps either. If you have an 
application which deals with discontinuous buffers associated with 
timestamps then the model is broken.

The only solution I can think of is to create a pseudo transport stream 
with a headset containing the timestamp and the audio data inserted 
between headers. I believe this is what you are suggesting?

Alternatively we could add an API that would match a decoded sample with 
a timestamp but it's not clear how you would synchronize timestamp 
information with the data stream (or rather there could be race 
conditions leading to the timestamps being provided to the hardware too 
late).
