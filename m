From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: hdmi-codec: modifying params in hw_params()
	callback
Date: Thu, 28 Feb 2019 14:39:18 +0100
Message-ID: <e62d7c7c-ac3e-8a9c-b3fe-2a2790c5a22d@ladisch.de>
References: <20190228121516.swd3vweisgcxlvld@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2DD99F896BB
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 14:39:19 +0100 (CET)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 8977855839B1
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 14:39:18 +0100 (CET)
In-Reply-To: <20190228121516.swd3vweisgcxlvld@shell.armlinux.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Russell King - ARM Linux admin wrote:
> While looking at hdmi-codec issues, I spotted this code:
>
> static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
>                                 struct snd_pcm_hw_params *params,
>                                 struct snd_soc_dai *dai)
> {
> ...
>         if (params_width(params) > 24)
>                 params->msbits = 24;
>
> [...]
> What's more is that the msbits is a parameter that is refined with
> userspace, so surely the above should be a declared constraint?

Yes, there should be a call to "snd_pcm_hw_constraint_msbits"
somewhere.

> So, all in all, it seems that the above code limiting msbits is
> redundant - nothing will read this modified value.  Can we kill it?

Yes.


Regards,
Clemens
