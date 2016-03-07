From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/6] ASoC: Intel: allow for DW_DMAC_CORE as
	module
Date: Mon, 7 Mar 2016 11:49:29 -0600
Message-ID: <56DDBF29.2010809@linux.intel.com>
References: <1457062599-10032-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1457062599-10032-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20160305040303.GY18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3101726145A
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 18:50:01 +0100 (CET)
In-Reply-To: <20160305040303.GY18327@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 3/4/16 10:03 PM, Mark Brown wrote:
> On Thu, Mar 03, 2016 at 09:36:33PM -0600, Pierre-Louis Bossart wrote:
>
>> -	depends on DW_DMAC_CORE=y && (SND_SST_IPC_ACPI = n)
>> +	depends on (DW_DMAC_CORE != n) && (SND_SST_IPC_ACPI = n)
>
> What is the expected difference between a dependency on DW_DMAC_CORE and
> one on DW_DMAC_CORE != n?

No functional difference, it's more to make the menuconfig options more 
obvious.
Without this patch, menuconfig will not show the legacy byt-max98090 and 
byt-rt5640 options if the DW_DMAC_CORE is built as a module.
While we want to encourage folks to use the newer DPCM drivers, we also 
want to leave these options accessible.
