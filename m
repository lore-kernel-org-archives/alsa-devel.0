From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 5/5] ASoC: The soc card can have auxiliary
 components
Date: Wed, 16 Dec 2015 16:33:32 +0800
Message-ID: <567121DC.5080601@linux.intel.com>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
 <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
 <20151208185817.GX5727@sirena.org.uk> <5667EFCB.3010402@linux.intel.com>
 <20151209203836.GI5727@sirena.org.uk> <56694E6A.4090402@linux.intel.com>
 <20151211202208.GS5727@sirena.org.uk> <566FC9F6.8050107@linux.intel.com>
 <20151215112324.GX5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 8766126517F
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 09:17:11 +0100 (CET)
In-Reply-To: <20151215112324.GX5727@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org



On 12/15/2015 07:23 PM, Mark Brown wrote:
> On Tue, Dec 15, 2015 at 04:06:14PM +0800, Mengdong Lin wrote:
>
>> I still have some basic questions:
>
>> 1. What are the typical usages for aux_dev?
>>     For CODEC<->CODEC link or external headset detection chip?
>
> Neither, it's for analogue devices.

Got it. Thanks!

>
>> 2. Why we need the rtd array 'rtd_aux' for the aux_devs?
>>     If the codec has DAIs and used by a DAI link, the ASoC will create a rtd
>> for the link.
>
> There are (or were at the time) assumptions in drivers that there will
> be a rtd there so it was easier to provide a stub.
>

Can we remove this rtd array if current driver does not need the stub?

For the replacement of aux_dev by aux_component, can we define like below?

struct snd_soc_aux_component {
	const char *comp_name; ... no longer assume they're only codecs
	const char *comp_of_node;

	/* machine specific init */
	int (*init)(struct snd_soc_component *componnent);
};

The ASoC can use the comp_name or comp_of_node to find the components 
and probe them.

Thanks
Mengdong
