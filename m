From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 4/6] ASoC: SOF: Intel: byt: Refactor fw
 ready / mem windows creation
Date: Wed, 7 Aug 2019 21:07:16 +0200
Message-ID: <ac41ec50-6484-cce1-2e41-c42e6bb541ef@intel.com>
References: <20190807150203.26359-1-pierre-louis.bossart@linux.intel.com>
 <20190807150203.26359-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5766AF800E4
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 21:07:23 +0200 (CEST)
In-Reply-To: <20190807150203.26359-5-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On 2019-08-07 17:02, Pierre-Louis Bossart wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>

> So we are basically moving code from intel/byt.c to loader.c keeping
> in mind that mbox_offset is a per platform constant so we need to
> use newly introduced snd_sof_dsp_get_mailbox_offset /
> snd_sof_dsp_get_window_offset in order to get the correct
> mbox offset / window offset value.

You've already explained your goal. These details are unnecessary.

> 
> Also, bar is a per platform constant so we use snd_sof_dsp_get_bar_index
> instead of the hardcoded BYT_DSP_BAR.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   sound/soc/sof/intel/byt.c | 164 +++++--------------------------------
>   sound/soc/sof/loader.c    | 168 ++++++++++++++++++++++++++++++++++++++
>   sound/soc/sof/sof-priv.h  |   2 +
>   3 files changed, 189 insertions(+), 145 deletions(-)

Hmm, even the commit message mentions two steps, not one. Splitting this 
commit into two - introduction of new generic functions and byt 
alignment towards the newly added approach - seems reasonable. Bdw & hda 
followups already make good examples.

Czarek
