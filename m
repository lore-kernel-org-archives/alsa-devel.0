From: noman pouigt <variksla@gmail.com>
Subject: Re: compress: adding support for hardware dependent
	params
Date: Mon, 3 Feb 2014 01:01:18 -0800
Message-ID: <CAES_P+_Wztn3udEbc5vcUgAmFKuNLXh6MwHpcOSzLkah0c0Oxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f52.google.com (mail-oa0-f52.google.com
 [209.85.219.52])
 by alsa0.perex.cz (Postfix) with ESMTP id BB4802602AD
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 10:01:19 +0100 (CET)
Received: by mail-oa0-f52.google.com with SMTP id i4so7892186oah.11
 for <alsa-devel@alsa-project.org>; Mon, 03 Feb 2014 01:01:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, bgoswami@codeaurora.org
Cc: vinod.koul@linux.intel.com, plai@codeaurora.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

>  We have a requirement, where we need to set a number of hardware specific
> parameters for compressed offload use-cases, before starting a stream. As
> these parameters need to be set once for the entire session, we would
> like to explore the best way to set these additional parameters somewhere
> before calling trigger() function.
>  Below are few of the proposed solutions that we could think of at this
> point for getting this done-
As you have not mentioned what kind of metadata you are talking about
I am assuming if your meta data can fit in below structure then we already
have a code in upstream which takes care of your need.

140 struct snd_compr_metadata {
141          __u32 key;
142          __u32 value[8];
143 };

Structure snd_compr_ops has set_metadata and get_metadata callbacks
which you can use for your need.

 88  * struct snd_compr_ops: compressed path DSP operations
 89  * @open: Open the compressed stream
 90  * This callback is mandatory and shall keep dsp ready to receive the stream
 91  * parameter
 92  * @free: Close the compressed stream, mandatory
 93  * @set_params: Sets the compressed stream parameters, mandatory
 94  * This can be called in during stream creation only to set codec params
 95  * and the stream properties
 96  * @get_params: retrieve the codec parameters, mandatory
 97  * @trigger: Trigger operations like start, pause, resume, drain, stop.
 98  * This callback is mandatory
 99  * @pointer: Retrieve current h/w pointer information. Mandatory
100  * @copy: Copy the compressed data to/from userspace, Optional
101  * Can't be implemented if DSP supports mmap
102  * @mmap: DSP mmap method to mmap DSP memory
103  * @ack: Ack for DSP when data is written to audio buffer, Optional
104  * Not valid if copy is implemented
105  * @get_caps: Retrieve DSP capabilities, mandatory
106  * @get_codec_caps: Retrieve capabilities for a specific codec, mandatory
107  */

It would be nice if someone can send a patch here to describe set and
get_metadata callbacks in compress_driver.h

>
>
> 1. Adding new IOCTL call: Add a new ioctl control in compress-offload.c
> file to handle hardware specific parameters setting. This new ioctl
> control will call into soc-compress.c and eventually call into platform
> driver ioctl to set those hardware specific parameters. In this case, we
> will add a new structure, let's say "snd_compr_hw_ctrl_params", with the
> same fields as "snd_compr_metadata" struct.
>
>
> 2. Adding a function hw_dependant_hw_params(), which will be called after
> hw_params() and before prepare() function. The new function will
> eventually call into the platform driver to get the hardware specific
> parameters set. Once implemented, this would look something like-
>   hw_params();
>   hw_dependant_hw_params();
>   prepare();
>
>
> 3. Add a function "hw_dependant_hw_params()", as _part_ of the hw_params()
> function. This new function will be called after the (existing) generic
> parameters are set. So once implemented, the proposed function calls would
> look like-
>   hw_params() {
>         generic_hw_params();
>         hw_dependant_hw_params();
>   }
>   prepare();
>
>
> We would like to get feedback on these proposed solutions and get a
> discussion going to see how best these requirements can be fitted in the
> current Compressed ALSA framework (for mainlining).
Can you explain your meta data?

Be the change you want to see in the world:Gandhi
