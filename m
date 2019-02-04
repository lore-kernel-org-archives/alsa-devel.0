From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: dapm: fix out-of-bounds accesses
 to DAPM lookup tables
Date: Mon, 4 Feb 2019 09:08:41 -0600
Message-ID: <a199f5cb-7e56-db27-37bc-78e3e7e5daee@linux.intel.com>
References: <20190204135914.7413-1-pierre-louis.bossart@linux.intel.com>
 <s5hr2cnppnj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6451B2674C0
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:08:43 +0100 (CET)
In-Reply-To: <s5hr2cnppnj.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


> This patch itself looks fine, but maybe a safer implementation would
> be to define snd_soc_dapm_max, and define dapm_up_seq[] as
> dapm_up_seq[snd_soc_dapm_max].

Yes I thought about this but didn't know why the array was declared with 
an implicit length.

> Also, another worthy change would be to set the priority non-zero, and
> trigger WARN_ON() if it hits a zero, i.e. undefined entry.

Unfortunately the zero is a legit value today, so we'd have to move all 
existing values by one. Not sure if it's worth it.

Maybe an alternate way to fix this is to define snd_soc_dapm_max and 
check if the ARRAY_SIZE of dapm_up_seq and dapm_down_seq match. That 
would trap any changes in the enum that isn't reflected in the _seq 
look-up tables.
