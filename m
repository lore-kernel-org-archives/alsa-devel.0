From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/5] ASoC: Intel: IPC framework updates
Date: Mon, 22 Jul 2019 11:02:29 -0500
Message-ID: <58061248-786f-37f6-fc9f-cf18db242a75@linux.intel.com>
References: <20190720194532.23682-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 418E1F800F5
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 18:02:33 +0200 (CEST)
In-Reply-To: <20190720194532.23682-1-cezary.rojewski@intel.com>
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
Cc: broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 7/20/19 2:45 PM, Cezary Rojewski wrote:
> Existing IPC framework omits crucial part of the entire communication:
> reply header. Some IPCs cannot function at all without the access to
> said header. Update the sst-ipc with new sst_ipc_message structure to
> represent both request and reply allowing reply-processing handlers to
> save received responses.

I don't get the idea at all.

the DSP provides rx_data and a size. If there is a header at the start 
of the IPC data in some cases, why can't you cast and extract the header 
when it's needed for your SKL usages? Why does adding a header make the 
IPC work better?

I have the feeling this is blurring layers between receiving data and 
processing it in platform-specific ways, and I am nervous about touching 
Baytrail and Broadwell legacy, which are way past maintenance mode and 
should be deprecated really.

And last this patchset does not apply on top of Mark's tree?

> 
> Despite the range of changes required for model to be updated, no
> functional changes are made for core hanswell, baytrail and skylake
> message handlers. Reply-processing handlers now save received response
> header yet no usage is added by default.
> 
> To allow for future changes, righful kings of IPC kingdom need to be put
> back on the throne. This update addresses one of them: LARGE_CONFIG_GET.
> 
> Cezary Rojewski (5):
>    ASoC: Intel: Update request-reply IPC model
>    ASoC: Intel: Haswell: Align with updated request-reply model
>    ASoC: Intel: Baytrail: Align with updated request-reply model
>    ASoC: Intel: Skylake: Align with updated request-reply model
>    ASoC: Intel: Skylake: large_config_get overhaul
> 
>   sound/soc/intel/baytrail/sst-baytrail-ipc.c |  65 ++++----
>   sound/soc/intel/common/sst-ipc.c            |  68 ++++----
>   sound/soc/intel/common/sst-ipc.h            |  27 ++--
>   sound/soc/intel/haswell/sst-haswell-ipc.c   | 164 +++++++++++---------
>   sound/soc/intel/skylake/cnl-sst.c           |   6 +-
>   sound/soc/intel/skylake/skl-messages.c      |   3 +-
>   sound/soc/intel/skylake/skl-sst-ipc.c       | 152 ++++++++++--------
>   sound/soc/intel/skylake/skl-sst-ipc.h       |   3 +-
>   8 files changed, 259 insertions(+), 229 deletions(-)
> 
