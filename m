From: Sean Cross <xobs@kosagi.com>
Subject: Re: [PATCH v2 2/3] ASoC: add es8328 codec driver
Date: Tue, 17 Jun 2014 15:10:54 +0800
Message-ID: <539FE9FE.1090807@kosagi.com>
References: <1402982189-28598-1-git-send-email-xobs@kosagi.com>
 <1402982189-28598-3-git-send-email-xobs@kosagi.com>
 <539FDF2C.10606@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.g1.pair.com (mail1.g1.pair.com [66.39.3.162])
 by alsa0.perex.cz (Postfix) with ESMTP id 8783B2654EC
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 09:11:02 +0200 (CEST)
In-Reply-To: <539FDF2C.10606@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 06/17/14 14:24, Lars-Peter Clausen wrote:
> On 06/17/2014 07:16 AM, Sean Cross wrote:
>
> A couple of small bits inline.
[...]
> [...]
>> +
>> +/*
>> + * ES8328 Controls
>> + */
>> +
>> +static const char * const deemph_txt[] = {"None", "32Khz",
>> "44.1Khz", "48Khz"};
>> +static SOC_ENUM_SINGLE_DECL(deemph,
>> +                ES8328_DACCONTROL6, 6, deemph_txt);
>
> deemph should just be a single boolean switch (On or Off) and
> automatically select the correct setting based on the configured
> sample rate.
Seems like a lot of work.  Is there an example of how this should be
written?  What should the behavior be when deemph is enabled, and output
is, say, 22.050 kHz (which doesn't have a deemph supported in
hardware)?  Should selection of the deemph register be performed inside
hw_params()?

I'll incorporate the other fixes for v3.


Sean
