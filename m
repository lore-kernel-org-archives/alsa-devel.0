From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH 04/10] ASoC: Intel: Skylake:
	Disable	SRAM	Retention before D3
Date: Fri, 3 Jun 2016 16:15:42 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60552BDB268@BGSMSX104.gar.corp.intel.com>
References: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
 <1464958783-19344-5-git-send-email-jeeja.kp@intel.com>
 <s5hwpm6o241.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 56F09266D10
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 18:15:48 +0200 (CEST)
In-Reply-To: <s5hwpm6o241.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "Kp, Jeeja" <jeeja.kp@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "R,
 Dharageswari" <dharageswari.r@intel.com>, Patches Audio <patches.audio@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-
>project.org] On Behalf Of Takashi Iwai
>Sent: Friday, June 3, 2016 6:34 PM
>To: Kp, Jeeja <jeeja.kp@intel.com>
>Cc: alsa-devel@alsa-project.org; R, Dharageswari <dharageswari.r@intel.com>;
>Patches Audio <patches.audio@intel.com>; Koul, Vinod
><vinod.koul@intel.com>; broonie@kernel.org; Girdwood, Liam R
><liam.r.girdwood@intel.com>
>Subject: Re: [alsa-devel] [PATCH 04/10] ASoC: Intel: Skylake: Disable SRAM
>Retention before D3
>
>On Fri, 03 Jun 2016 14:59:37 +0200,
>jeeja.kp@intel.com wrote:
>>
>> From: Dharageswari R <dharageswari.r@intel.com>
>>
>> SW needs to set the PGCTL.LSRMD = 1 to disable LPSRAM retention
>> feature,otherwise it may lead to SRAM ECC Errors.
>
>Is this needed only for ASoC driver, or for SKL in general?
>

Only needed for ASoC driver.

Regards,
Rakesh


>thanks,
>
>Takashi
>
>>
>> Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
>> Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
>> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
>> ---
>>  sound/soc/intel/skylake/skl.c | 3 +++
>>  sound/soc/intel/skylake/skl.h | 2 ++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
>> index 06d8c26..5a08826 100644
>> --- a/sound/soc/intel/skylake/skl.c
>> +++ b/sound/soc/intel/skylake/skl.c
>> @@ -184,6 +184,7 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
>>  {
>>  	struct skl *skl = ebus_to_skl(ebus);
>>  	struct hdac_bus *bus = ebus_to_hbus(ebus);
>> +	struct pci_dev *pci = to_pci_dev(bus->dev);
>>  	int ret;
>>
>>  	snd_hdac_ext_bus_link_power_down_all(ebus);
>> @@ -193,6 +194,8 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
>>  		return ret;
>>
>>  	snd_hdac_bus_stop_chip(bus);
>> +	update_pci_dword(pci, AZX_PCIREG_PGCTL,
>> +		AZX_PGCTL_LSRMD_MASK, AZX_PGCTL_LSRMD_MASK);
>>  	skl_enable_miscbdcge(bus->dev, false);
>>  	snd_hdac_bus_enter_link_reset(bus);
>>  	skl_enable_miscbdcge(bus->dev, true);
>> diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
>> index 4b4b387..bd8db1d 100644
>> --- a/sound/soc/intel/skylake/skl.h
>> +++ b/sound/soc/intel/skylake/skl.h
>> @@ -48,6 +48,8 @@
>>  #define AZX_REG_VS_SDXEFIFOS_XBASE	0x1094
>>  #define AZX_REG_VS_SDXEFIFOS_XINTERVAL	0x20
>>
>> +#define AZX_PCIREG_PGCTL		0x44
>> +#define AZX_PGCTL_LSRMD_MASK		(1 << 4)
>>  #define AZX_PCIREG_CGCTL		0x48
>>  #define AZX_CGCTL_MISCBDCGE_MASK	(1 << 6)
>>
>> --
>> 2.5.0
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@alsa-project.org
>http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
