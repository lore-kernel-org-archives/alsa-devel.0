From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: dapm: fix out-of-bounds accesses
 to DAPM lookup tables
Date: Mon, 4 Feb 2019 10:20:10 -0600
Message-ID: <9b852c6a-4fef-3b97-6bea-7a81500ed14e@linux.intel.com>
References: <20190204135914.7413-1-pierre-louis.bossart@linux.intel.com>
 <s5hr2cnppnj.wl-tiwai@suse.de>
 <a199f5cb-7e56-db27-37bc-78e3e7e5daee@linux.intel.com>
 <20190204161140.GG23441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 56C1926746F
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 17:20:14 +0100 (CET)
In-Reply-To: <20190204161140.GG23441@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


On 2/4/19 10:11 AM, Mark Brown wrote:
> On Mon, Feb 04, 2019 at 09:08:41AM -0600, Pierre-Louis Bossart wrote:
>
>> Yes I thought about this but didn't know why the array was declared with an
>> implicit length.
> It's been that way since the first commit (which predates me) so I don't
> think it was a super thought through decision.
>
>> Unfortunately the zero is a legit value today, so we'd have to move all
>> existing values by one. Not sure if it's worth it.
> It's not hard.

It's not hard indeed, I am just not hot on changing the values at the 
same time as adding new definitions. I managed to screw-up the mic 
values the first time, this would make the changes hard to check.

Maybe do this in a second patch, along with the array size checks?

>
>> Maybe an alternate way to fix this is to define snd_soc_dapm_max and check
>> if the ARRAY_SIZE of dapm_up_seq and dapm_down_seq match. That would trap
>> any changes in the enum that isn't reflected in the _seq look-up tables.
> We could do that and another thing together for maximum robustness!
