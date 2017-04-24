From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: intel: Fix PM and non-atomic crash
	in bytcr drivers
Date: Mon, 24 Apr 2017 17:18:31 -0500
Message-ID: <673c9970-5e9e-39b8-7b57-451ffb69f523@linux.intel.com>
References: <20170424120955.15519-1-tiwai@suse.de>
 <14ce353a-5dd5-76bc-d98b-d0d3e8b4e757@linux.intel.com>
 <s5hmvb5iinq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id DD76726664F
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 00:18:35 +0200 (CEST)
In-Reply-To: <s5hmvb5iinq.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 4/24/17 4:45 PM, Takashi Iwai wrote:
> On Mon, 24 Apr 2017 23:39:47 +0200,
> Pierre-Louis Bossart wrote:
>>
>>
>>
>> On 04/24/2017 07:09 AM, Takashi Iwai wrote:
>>> The FE setups of Intel SST bytcr_rt5640 and bytcr_rt5651 drivers carry
>>> the ignore_suspend flag, and this prevents the suspend/resume working
>>> properly while the stream is running, since SST core code has the
>>> check of the running streams and returns -EBUSY.  Drop these
>>> superfluous flags for fixing the behavior.
>>>
>>> Also, the bytcr_rt5640 driver lacks of nonatomic flag in some FE
>>> definitions, which leads to the kernel Oops at suspend/resume like:
>> This patch also fixes the known bug that reboot had to be forced on
>> some BYT platforms with a manual restart when the audio driver was
>> enabled.
>> Thanks Takashi!
>
> While we're at it: could you submit the UCM profiles as alsa-lib
> upstream?  At least the ones for the drivers that are in the current
> kernel should be merged.
>
> If there are multiple board-specific UCMs for the same driver, we can
> use now card's longname (generated from DMI string) as the primary
> source, while keeping the $DRIVER/$DRIVER.conf as the fallback.

Well I've lost track of which git repo UCM files should be in, both the 
license and the update rate of alsa-lib are problematic for 
configuration files. We also talked about some include capabilities to 
avoid copy/paste but I can't recall having seen them upstream.
I also haven't had time to test the long name on my devices.
