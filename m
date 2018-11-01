From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: acpi: fix: continue searching when
 machine is ignored
Date: Wed, 31 Oct 2018 21:51:57 -0500
Message-ID: <4392c384-2cab-86d2-0348-4338fda3d981@linux.intel.com>
References: <20181101023641.31435-1-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A75A2677E8
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2018 03:52:00 +0100 (CET)
In-Reply-To: <20181101023641.31435-1-yang.jie@linux.intel.com>
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
To: Keyon Jie <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 10/31/18 9:36 PM, Keyon Jie wrote:
> The machine_quirk may return NULL which means the acpi entries should be
> skipped and search for next matched entry is needed, here add return
> check here and continue for NULL case.

Nice catch, this was missed in the other patchset since the ACPI ID to 
ignore was the last in the table...

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

>
> Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
> ---
>   sound/soc/soc-acpi.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
> index b8e72b52db30..faf8941363e4 100644
> --- a/sound/soc/soc-acpi.c
> +++ b/sound/soc/soc-acpi.c
> @@ -15,7 +15,10 @@ snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>   		if (acpi_dev_present(mach->id, NULL, -1)) {
>   			if (mach->machine_quirk)
>   				mach = mach->machine_quirk(mach);
> -			return mach;
> +
> +			/* return matched machine, continue otherwise */
> +			if (mach)
> +				return mach;
>   		}
>   	}
>   	return NULL;
