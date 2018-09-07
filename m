From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH] ASoC: cs4265: Add a MIC pre. switch
Date: Fri, 7 Sep 2018 21:06:00 +1000
Message-ID: <bcf46b57-ac22-e3b4-8a97-ab18fc2232f0@flatmax.org>
References: <20180907032729.26532-1-flatmax@flatmax.org>
 <20180907082626.GF1653@imbe.wolfsonmicro.main>
 <dc95df9e-e256-863a-3e53-ba18a2366143@flatmax.org>
 <20180907105512.GH1653@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 by alsa0.perex.cz (Postfix) with ESMTP id 301E4267819
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2018 13:06:07 +0200 (CEST)
In-Reply-To: <20180907105512.GH1653@imbe.wolfsonmicro.main>
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
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, brian.austin@cirrus.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


On 07/09/18 20:55, Charles Keepax wrote:
> On Fri, Sep 07, 2018 at 08:18:05PM +1000, Matt Flax wrote:
>> On 07/09/18 18:26, Charles Keepax wrote:
>>> On Fri, Sep 07, 2018 at 01:27:29PM +1000, Matt Flax wrote:
>>> Which would really make DAPM a better fit, unless there are valid
>>> use-cases for using the mic with the preamp powered down?
>> Agreed, when you switch to the MIC rather then LINEIN it should be
>> turned on.
>>
>> This is the DAPM_MUX :
>> https://github.com/torvalds/linux/blob/master/sound/soc/codecs/cs4265.c#L178
>> This is the ENUM_SINGLE :
>> https://github.com/torvalds/linux/blob/master/sound/soc/codecs/cs4265.c#L98
>>
>> What is the best way to do this ?
> Apologies not sure I entirely follow, don't you just want to
> update the routes such that the existing "Pre-amp MIC" widget
> is between the MICL,R and the ADC Mux. Something like:
>
> { "Pre-amp MIC", NULL, "MICL" },
> { "Pre-amp MIC", NULL, "MICR" },
> { "ADC Mux", "MIC", "Pre-amp MIC" },
>
>

ok - will do.

Matt
