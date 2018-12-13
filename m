From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 6/6] ASoC: Intel: Skylake: Add more
 platform granularity
Date: Thu, 13 Dec 2018 13:04:44 -0600
Message-ID: <e2fd5411-5c24-2bb2-ba36-a420dc241b3d@linux.intel.com>
References: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
 <20181207235008.22988-7-pierre-louis.bossart@linux.intel.com>
 <20181213153710.GO10669@sirena.org.uk>
 <4d3fb881-596b-8c7c-22bc-d497460064ab@linux.intel.com>
 <20181213175444.GW10669@sirena.org.uk>
 <46ed95dd-9408-43e0-8849-92acedfa7c24@linux.intel.com>
 <20181213182148.GY10669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7184926789E
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 20:04:47 +0100 (CET)
In-Reply-To: <20181213182148.GY10669@sirena.org.uk>
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


On 12/13/18 12:21 PM, Mark Brown wrote:
> On Thu, Dec 13, 2018 at 12:02:58PM -0600, Pierre-Louis Bossart wrote:
>
>>>> This is odd. I just rebased on your for-next branch (SHA1 below) and see no
>>>> issues? Did you push your latest changes? Or maybe this conflicts with Hui
>>>> Wang's new KBL machine driver stuff?
>>> I'm guessing it's the latter.
>> ok, i'll wait a bit then for the remotes to be updated, I don't see it yet.
> I did a push a few minutes ago, there's no unpushed changes here - let
> me know if I missed something here.

The conflict was indeed with Hui's patch, no big deal. i just re-sent a 
v2 for this patch.

Thanks!

-Pierre
