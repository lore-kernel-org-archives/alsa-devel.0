From: Sebastien Guiriec <sebastien.guiriec@intel.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: atom: Add sysfs entry in
 order to store FW version
Date: Tue, 8 Nov 2016 09:29:15 +0100
Message-ID: <51eb5a2d-94e0-56d8-817f-eedf632935eb@intel.com>
References: <20161104080411.12410-1-sebastien.guiriec@intel.com>
 <20161104080411.12410-3-sebastien.guiriec@intel.com>
 <20161107210241.GP3000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id AE573266ED4
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 09:32:52 +0100 (CET)
In-Reply-To: <20161107210241.GP3000@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi Vinod,

On 07/11/2016 22:02, Vinod Koul wrote:
> On Fri, Nov 04, 2016 at 09:04:11AM +0100, Sebastien Guiriec wrote:
>> This patch is adding a sysfs entry in order to be able to get
>> access to SST FW version.
>>
>> Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
>> ---
>>  sound/soc/intel/atom/sst/sst.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
>> index a4b458e..dabbd06 100644
>> --- a/sound/soc/intel/atom/sst/sst.c
>> +++ b/sound/soc/intel/atom/sst/sst.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/pm_qos.h>
>>  #include <linux/async.h>
>>  #include <linux/acpi.h>
>> +#include <linux/sysfs.h>
>>  #include <sound/core.h>
>>  #include <sound/soc.h>
>>  #include <asm/platform_sst_audio.h>
>> @@ -241,6 +242,28 @@ int sst_alloc_drv_context(struct intel_sst_drv **ctx,
>>  }
>>  EXPORT_SYMBOL_GPL(sst_alloc_drv_context);
>>
>> +static ssize_t firmware_version_show(struct device *dev,
>> +			    struct device_attribute *attr, char *buf)
>>+{
>> +	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
>> +
>> +	return sprintf(buf, "v%02x.%02x.%02x.%02x\n",
>> +			ctx->fw_version.type, ctx->fw_version.major,
>> +			ctx->fw_version.minor, ctx->fw_version.build);
>
> we should do this only after FW load, can you add that bit please. ALso
> check we dont leak kernel memory when this is not set
>

Ok in case of v00.00.00.00 I will return "FW not yet Loaded".
Is it ok for you?

Seb
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
