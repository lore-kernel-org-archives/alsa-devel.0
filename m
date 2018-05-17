From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Boards: Add CNL RT274 I2S
 machine driver
Date: Thu, 17 May 2018 13:17:48 -0500
Message-ID: <db1cfa70-8123-8eb8-bd70-5f619647d170@linux.intel.com>
References: <20171127124437.8441-1-guneshwor.o.singh@intel.com>
 <5bdd77e1-fb83-0626-c377-a457294ca38d@linux.intel.com>
 <20171128162415.GV3187@localhost>
 <f0425e26-a13d-d0ed-4191-f5973cb14231@linux.intel.com>
 <20180517063725.GM20254@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 87296266DF0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 20:17:51 +0200 (CEST)
In-Reply-To: <20180517063725.GM20254@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ALSA ML <alsa-devel@alsa-project.org>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

On 5/17/18 1:37 AM, Mark Brown wrote:
> On Tue, Nov 28, 2017 at 10:44:50AM -0600, Pierre-Louis Bossart wrote:
>> On 11/28/2017 10:24 AM, Vinod Koul wrote:
> 
>>> Since you are still working on the fixes, I guess this can sneak in before.
>>> The machine drivers are typically low hanging in terms on complexity so we
>>> can merge this first followed by the rework you are doing. I think that part
>>> will still take a bit to stabilize and cleanup.
> 
>> the update goes out this afternoon, working on it, does this patch really
>> need to 'sneak in'?
> 
> This seems to have got buried with all the Kconfig fixes and reworks?  I
> was expecting a resend based on those given this discussion but that
> didn't seem to ever happen.

We have a small set of corrections to enable SOF to use this machine 
driver (mainly to remove hard-coded routes that can be handled by 
topology). The plan as I understand it is to first have Liam provide the 
SOF core, and in a second step provide all the machine driver updates - 
including this one.
