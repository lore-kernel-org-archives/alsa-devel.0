From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 2/5] ASoC: Move standard kcontrol
 helpers to the component level
Date: Sat, 10 May 2014 09:11:04 +0200
Message-ID: <536DD108.2090607@metafoo.de>
References: <1398165797-22997-1-git-send-email-lars@metafoo.de>
 <1398165797-22997-3-git-send-email-lars@metafoo.de>
 <20140509150034.GH2870@dragon> <536CF16F.8010807@metafoo.de>
 <CAOMZO5Cb4Q80ux1R9EOcsaCPFsmxz3K5Obt02or=s0RitmPMKw@mail.gmail.com>
 <536CFBE7.3070805@metafoo.de> <20140510050747.GI2870@dragon>
 <536DCF6F.9020507@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-069.synserver.de
 [212.40.185.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 410FE261AD0
 for <alsa-devel@alsa-project.org>; Sat, 10 May 2014 09:11:05 +0200 (CEST)
In-Reply-To: <536DCF6F.9020507@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/10/2014 09:04 AM, Lars-Peter Clausen wrote:
[..]
>> The error message only shows up with Debian wheezy and does not with
>> yocto rootfs.  And even when the error message shows, the audio still
>> functions well on Debian wheezy.  So it's just a noisy error message
>> for me which is only seen after your kernel patch.
>
> The keyword here is "seen". The error quite likely predated the commit, but
> it was silently discarded.
>
> regmap_read() returns -EBUSY when there is no cached register value and
> cache_only is set to true. But I'm not sure why that would happen, try to
> add some printks to _regmap_read() to see if this is the source and if it is
> why it is.

Both SGTL5000_CHIP_ANA_ADC_CTRL and SGTL5000_CHIP_MIC_CTRL don't have an 
entry in sgtl5000_reg_defaults. So if cache_only is true, controls which use 
these registers will return -EBUSY when you try to read or write them.
