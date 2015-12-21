From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 12/19] ASoC: codec: rt5651: add ACPI and OF
 support
Date: Mon, 21 Dec 2015 10:18:42 -0600
Message-ID: <56782662.8050907@linux.intel.com>
References: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1450406156-22246-13-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20151219115047.GI5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 697D4261AAF
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2015 17:18:57 +0100 (CET)
In-Reply-To: <20151219115047.GI5727@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, jack.yu@realtek.com
List-Id: alsa-devel@alsa-project.org

On 12/19/15 5:50 AM, Mark Brown wrote:
> On Thu, Dec 17, 2015 at 08:35:49PM -0600, Pierre-Louis Bossart wrote:
>
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id rt5651_of_match[] = {
>> +	{ .compatible = "realtek,rt5651", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, rt5651_of_match);
>> +#endif
>
> You need a binding document for new DT bindings.

Ah yes.
I added ACPI and OF support through copy-paste and s/rt5640/rt5651/, but 
I can only test ACPI and wouldn't know what bindings are required so 
will remove this OF part in the next batch.
Bard and team if you want to add OF support please go ahead.
