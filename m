From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: ALSA hw sample rate conversion support
Date: Wed, 30 Mar 2011 21:02:40 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630108516FF552@bgsmsx502.gar.corp.intel.com>
References: <AANLkTikT+O+D1wQCVa0vsOQyMJcEHP9+9JEfCm=q+bho@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id B3D0524499
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 17:33:53 +0200 (CEST)
In-Reply-To: <AANLkTikT+O+D1wQCVa0vsOQyMJcEHP9+9JEfCm=q+bho@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Aisheng Dong <dongas86@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark <broonie@opensource.wolfsonmicro.com>, Liam <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Aisheng Dong wrote:
> Hi ALL,
> 
> Does ALSA core support hw sample rate conversion now?
> Our soc has a HW sample rate converter module inside,
> I wonder if current ALSA core provide interface to support hw sample
> rate conversion?
> 
Assuming the SRC is inside SoC and you are converting sampling rate of stream
and sending at different rate, then I have a patch for you.
Basically the soc side hw_params should call a new API which call
codec_set_params() and sets the matching rate.

Something like this in soc-core

+int snd_soc_codec_set_params(struct snd_soc_codec *codec, unsigned int param)
+{
+       if (codec->driver->set_params)
+               return codec->driver->set_params(codec, param);
+       else
+               return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_codec_set_params);

Mark,
Would you okay with such a patch where DSP is doing some conversion and codec
will get different params from what stream is set up? And we make sure 
conversion is synced

~Vinod
