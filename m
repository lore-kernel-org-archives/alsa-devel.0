From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/5] ASoC: Intel: Add common SST driver
 loader on ACPI systems
Date: Fri, 14 Feb 2014 12:30:05 +0200
Message-ID: <52FDF02D.3080605@linux.intel.com>
References: <1392318930-8771-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392318930-8771-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 09CC52652A6
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 11:30:09 +0100 (CET)
In-Reply-To: <1392318930-8771-2-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Benson Leung <bleung@google.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 02/13/2014 09:15 PM, Liam Girdwood wrote:
> +
> +static struct sst_acpi_desc sst_acpi_haswell_desc = {
> +	.drv_name = "haswell-pcm-audio",
> +	.resindex_lpe_base = 0,
> +	.resindex_pcicfg_base = 1,
> +	.resindex_fw_base = -1,
> +	.irqindex_host_ipc = 0,
> +	.sst_id = SST_DEV_ID_LYNX_POINT,
> +	.fw_filename = "IntcSST1.bin",
>
Commenting myself - we need to move firmware files under intel/

-- 
Jarkko
