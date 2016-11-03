From: Sebastien Guiriec <sebastien.guiriec@intel.com>
Subject: Re: [PATCH] ASoC: Intel: atom: Add debug information
 related to FW version
Date: Thu, 3 Nov 2016 14:40:51 +0100
Message-ID: <ec05b744-5f2e-39eb-6749-3392a2862bdf@intel.com>
References: <20161028143250.10711-1-sebastien.guiriec@intel.com>
 <20161028163344.llazgdgico5qu26t@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DCD0A266E0F
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 14:44:30 +0100 (CET)
In-Reply-To: <20161028163344.llazgdgico5qu26t@sirena.org.uk>
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org



On 28/10/2016 18:33, Mark Brown wrote:
> On Fri, Oct 28, 2016 at 04:32:50PM +0200, Sebastien Guiriec wrote:
>
>> +	dev_info(sst_drv_ctx->dev, "FW Version %02x.%02x.%02x.%02x\n",
>> +			init->fw_version.type, init->fw_version.major,
>> +			init->fw_version.minor, init->fw_version.build);
>> +	dev_dbg(sst_drv_ctx->dev, "Build date %s Time %s\n",
>> +			init->build_info.date, init->build_info.time);
>
> Seems like an odd mix of info/dbg but whatever.  I'd also recommend
> adding sysfs or at least debugfs files exposing this information, that
> way you can still get at it even if the kernel log has been filled with
> other things.

Thansk Mark. I will remove the build time and date as the most important 
info is the FW version in order to have traceability of the different 
FW. I will add sysfs entry also.

Sebastien
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
