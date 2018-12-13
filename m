From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 6/6] ASoC: Intel: Skylake: Add more
 platform granularity
Date: Thu, 13 Dec 2018 11:44:48 -0600
Message-ID: <4d3fb881-596b-8c7c-22bc-d497460064ab@linux.intel.com>
References: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
 <20181207235008.22988-7-pierre-louis.bossart@linux.intel.com>
 <20181213153710.GO10669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 75B4626789E
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 18:44:51 +0100 (CET)
In-Reply-To: <20181213153710.GO10669@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Chris Chiu <chiu@endlessm.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/13/18 9:37 AM, Mark Brown wrote:
> On Fri, Dec 07, 2018 at 05:50:08PM -0600, Pierre-Louis Bossart wrote:
>> The current SKYLAKE kconfig is a all-you-can-eat selection that will
>> support all known plaforms. This is however not necessarily a good
>> thing: most platforms for SKL and KBL don't support the DSP, but a
>> number of CNL/WHL ones do. Selecting this driver in all cases isn't
>> really smart and will require users to muck with blacklists.
> This doesn't apply against current code, please check and resend.

This is odd. I just rebased on your for-next branch (SHA1 below) and see 
no issues? Did you push your latest changes? Or maybe this conflicts 
with Hui Wang's new KBL machine driver stuff?

Thanks!

-Pierre

62d67c75160c92465e56eea01a3e06131d644f3a
