From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: dapm: Add new widget type for
 constructing DAPM graphs on DSPs.
Date: Wed, 7 Jun 2017 16:23:26 -0500
Message-ID: <974a912e-46b9-036c-48bf-39689f7400eb@linux.intel.com>
References: <1496760282-6147-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20170607192304.thekfsvzy7mc7lgl@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id EA52F2671CA
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 23:23:28 +0200 (CEST)
In-Reply-To: <20170607192304.thekfsvzy7mc7lgl@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/7/17 2:23 PM, Mark Brown wrote:
> On Tue, Jun 06, 2017 at 03:44:42PM +0100, Liam Girdwood wrote:
>
>> +	snd_soc_dapm_buffer,		/* DSP/CODEC internal buffer */
>> +	snd_soc_dapm_pipeline,		/* DSP/CODEC internal pipeline */
>> +	snd_soc_dapm_effect,		/* DSP/CODEC effect component */
>
> What's the difference between a buffer and a pipeline, or between a
> pipeline and an effect?  We should have clear documentation, if they're
> different we're probably going to end up using them differently in the
> core at some point and if people use the wrong widget type it might end
> up breaking things.

it would be good to explain how those elements are organized. Usually an 
effect/src/asrc is part of a pipeline, it's almost a subgraph within the 
flat dapm structure

>
>> +	snd_soc_dapm_codec,		/* FW/SW coder/decoder component */
>
> Can we call this a fmt_conv or something?  CODEC is unfortunately a bit
> overloaded.
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
