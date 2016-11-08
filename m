From: Sebastien Guiriec <sebastien.guiriec@intel.com>
Subject: Re: [PATCH 2/3] ASoC: Intel: atom: save FW version
Date: Tue, 8 Nov 2016 08:15:06 +0100
Message-ID: <f0900341-cf16-b165-a790-51005bc6c161@intel.com>
References: <20161104080411.12410-1-sebastien.guiriec@intel.com>
 <20161104080411.12410-2-sebastien.guiriec@intel.com>
 <20161107210117.GO3000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 0508A2666FA
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 08:18:44 +0100 (CET)
In-Reply-To: <20161107210117.GO3000@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, viond.koul@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Vinod,


On 07/11/2016 22:01, Vinod Koul wrote:
> On Fri, Nov 04, 2016 at 09:04:10AM +0100, Sebastien Guiriec wrote:
>> After the boot of the SST FW the firmware version is send back
>> to the driver. This patch is saving the FW version inside the
>> driver.
>>
>> Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
>> ---
>>  sound/soc/intel/atom/sst/sst.h     | 1 +
>>  sound/soc/intel/atom/sst/sst_ipc.c | 5 +++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
>> index 3f49386..5c9a51cc 100644
>> --- a/sound/soc/intel/atom/sst/sst.h
>> +++ b/sound/soc/intel/atom/sst/sst.h
>> @@ -436,6 +436,7 @@ struct intel_sst_drv {
>>  	 */
>>  	char firmware_name[FW_NAME_SIZE];
>>
>> +	struct snd_sst_fw_version fw_version;
>
> Can you check if this is initialzed to zero, otherwise we should reset it..
>

Driver is using devm_kzalloc so it is set to 0.

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
