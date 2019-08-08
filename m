From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 0/2] ASoC: Intel: Skylake:
 large_config_get overhaul
Date: Thu, 8 Aug 2019 13:54:02 -0500
Message-ID: <7cc3d923-7429-c21b-690e-ee7ebfcb502f@linux.intel.com>
References: <20190808181549.12521-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37D91F803F3
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 20:54:06 +0200 (CEST)
In-Reply-To: <20190808181549.12521-1-cezary.rojewski@intel.com>
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
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org



On 8/8/19 1:15 PM, Cezary Rojewski wrote:
> LARGE_CONFIG_GET is among the most crucial IPCs. Host is expected to
> send single request first to obtain total payload size from received
> header's data_off_size. From then on, it loops for each frame exceeding
> inbox size until entire payload is read. If entire payload is contained
> within the very first frame, no looping is performed.
> 
> LARGE_CONFIG_GET is a flexible IPC, it not only receives payload but may
> carry one with them to provide list of params DSP module should return
> info for. This behavior is usually reserved for vendors and IPC handler
> should not touch that content. To achieve that, simply pass provided
> payload and bytes to sst_ipc_tx_message_wait as a part of request.
> 
> In current state, LARGE_CONFIG_GET message handler does nothing of that,
> in consequence making it dysfunctional. Overhaul said handler allowing
> rightful king of IPCs to return back on his throne - kingdom he shares
> with his twin brother: LARGE_CONFIG_SET.
> 
> The looping has not been added in this update as payloads of such size
> do not exist in practice. Will need to create custom module specifically
> for that very case and test against it before that feature can be added.

Thanks Cezary.

For the series:

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Changes since v4:
> - Addressed Pierre's review: updated function's declaration and dropped
>    unrelated log changes
> 
> Changes since v3:
> - Split "large_config_get overhaul" patch into two segments as suggested
>    by Pierre: first remove looping, then adjust function's behavior
> 
> Changes since v2:
> - None, just for-next rebase
> 
> Changes since v1:
> - None, just for-next rebase
> 
> Cezary Rojewski (2):
>    ASoC: Intel: Skylake: Limit large_config_get to single frame
>    ASoC: Intel: Skylake: large_config_get overhaul
> 
>   sound/soc/intel/skylake/skl-messages.c |  3 +-
>   sound/soc/intel/skylake/skl-sst-ipc.c  | 54 +++++++++++---------------
>   sound/soc/intel/skylake/skl-sst-ipc.h  |  3 +-
>   3 files changed, 27 insertions(+), 33 deletions(-)
> 
