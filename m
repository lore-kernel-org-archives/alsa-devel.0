From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/5] ASoC: SOF: suspend/resume debug tools
Date: Mon, 3 Jun 2019 10:45:52 -0500
Message-ID: <436681ea-6ffb-93f5-9bae-1f01d98e072f@linux.intel.com>
References: <20190524192309.6359-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFB74F80774
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 17:45:56 +0200 (CEST)
In-Reply-To: <20190524192309.6359-1-pierre-louis.bossart@linux.intel.com>
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
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org



On 5/24/19 2:23 PM, Pierre-Louis Bossart wrote:
> No new functionality per se, just utilities for developers. The vast
> majority of current integration issues are related to HDAudio + trace
> support combined with runtime suspend/resume.
> 
> Add a couple of changes to make it easier for developers to see the
> firmware logs across suspend/resume transitions, disable the trace
> and/or disable runtime_pm to help narrow down the problems.
> 
> Kai Vehmanen (2):
>    ASoC: SOF: trace: remove code duplication in sof_wait_trace_avail()
>    ASoC: SOF: force end-of-file for debugfs trace at suspend

Hi Mark, you applied the first two patches in this series but the last 3 
patches were left out. Were they missed somehow or is there any objection?

> Pierre-Louis Bossart (3):
>    ASoC: SOF: trace: move to opt-in with Kconfig and module parameter
>    ASoC: SOF: acpi: add module param to disable pm_runtime
>    ASoC: SOF: pci: add module param to disable pm_runtime
> 
>   sound/soc/sof/Kconfig        |  8 +++++
>   sound/soc/sof/core.c         | 26 ++++++++++----
>   sound/soc/sof/sof-acpi-dev.c | 12 ++++++-
>   sound/soc/sof/sof-pci-dev.c  | 12 ++++++-
>   sound/soc/sof/sof-priv.h     |  3 ++
>   sound/soc/sof/trace.c        | 67 ++++++++++++++++++++++++++++++------
>   6 files changed, 110 insertions(+), 18 deletions(-)
> 
> 
> base-commit: 188d45fe779eeb8e3521b59fcb12cc48a6f2c203
> 
