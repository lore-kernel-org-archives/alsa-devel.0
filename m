From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2][RFC] ASoC: soc-core: allow no Platform
 on dai_link
Date: Wed, 30 Jan 2019 20:48:41 -0600
Message-ID: <477d13e1-7dfa-b384-259e-2e0e5b98684a@linux.intel.com>
References: <8736paoqr5.wl-kuninori.morimoto.gx@renesas.com>
 <87zhrinc2y.wl-kuninori.morimoto.gx@renesas.com>
 <e984c300-5732-17ca-212b-3954cbdf3765@linux.intel.com>
 <87o97xlicc.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D53C22673B4
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 03:48:43 +0100 (CET)
In-Reply-To: <87o97xlicc.wl-kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


On 1/30/19 7:46 PM, Kuninori Morimoto wrote:
> Hi Pierre-Louis
>
>>> If sound card dirver is using "modern style", both codec/platform
>>> are using it. So this patch judges it as "modern style" if
>>> there is no settings for
>>> 	codec_name
>>> 	codec_of_node
>>> 	codec_dai_name
>>> 	platform_name
>>> 	platform_of_node
>> Doesn't this prevent a gradual dailink transition where e.g. the
>> platform_name is removed first and then the codec_name/codec_dai_name
>> is removed second?
> I'm thinking transition to modern from legacy for "normal drivers"
> will be like this
>
> 	1) will happen after multi-CPU was supported
> 	2) Transit everything (= CPU/Codec/Platform) by 1 patch for each drivers,
> 	   not gradual transition (= Mark / Lars doesn't like this style).
> 	3) If you need/want to gradual transition (= like simple-card, audio-graph),
> 	   unfortunately, it will be full responsibility for your action.
>
> Yes, it is selfish, but is very difficult to prevent all cases in this case.
> So I think we need to have some rule for transition.
> Or, other idea is that transit all drivers first without this patch,
> and add support "no Platform" 2nd.
> In this case, it will be easier, but will needs many patches.
> I'm not sure which one is best.
>
>> I started doing the transition in steps changing all dailinks with
>> platform and codec/codec_dai names at once is quite invasive and
>> possibly error prone. Specifically for Intel machine drivers, the
>> codec names are heavily tweaked to align with the actual ACPI name,
>> not the hard-coded one, and that should be tested independently if
>> possible. Same for codec_dai_names, they depend on quirks.
> Yeah agree.
> I think transit to modern style on magical (= non hard-coded) platform
> will be trouble...
> I'm thinking that transition patch need to be tested/confirmed
> before removing legacy style for its safety
>
> 	1) transit "hard-coded" platform first, and confirm
> 	   modern style behavior.
> 	2) if no problem happen on 1) step, transit "magical" platform 2nd step.
> 	   will have few/some problem, fixup step-by-step.
>
> These are my opinion, but I want to know your and Mark's idea.
> I can adjust/follow to it.

The problem is that it's not just a renaming, there are multiple cases 
where the codec_name, codec_dai_name fields are explicitly handled. See 
my initial (compile-tested only) changes at [1]

[1] https://github.com/plbossart/sound/commits/fix/codec-legacy-dai
