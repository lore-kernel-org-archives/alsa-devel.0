From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 2/13] Intel SST driver
Date: Tue, 7 Jul 2009 11:30:00 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC21F2@bgsmsx501.gar.corp.intel.com>
References: <1246604493-12833-1-git-send-email-vinod.koul@intel.com>
	<s5hk52q2g5k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F17C24698
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 08:01:24 +0200 (CEST)
In-Reply-To: <s5hk52q2g5k.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>(snip)
>> +#ifndef CONFIG_SST_IPC_NOT_INCLUDED
>> +#include <asm/ipc_defs.h>
>> +#endif
>
>What is this file?
This file has the function definitions to communicate to the sound card. The sound card is a part of PMIC chip. The sound card registers are not accessible by CPU directly. There is a platform driver that enables to communicate to the sound card. Audio driver uses this header file of that diver to communicate to the sound card. This is one of the dependant drivers for audio driver. This is being submitted upstream by Intel as well.

>> +struct intel_sst_drv *sst_ops;
>
>I'm afraid it's a bit too generic name.
INTEL_SST (Intel Smart Sound Technology) is the marketing name for the audio stack. Is sst_ops looking like a generic name or intel_sst_drv a generic name? Any alternative name you could suggest would help.

>
>> +	if (retval != 0)
>> +		sst_err("scu ipc write1 failed %d", retval);
>> +	/*Reset the Audio subsystem*/
>> +	retval = sst_scu_ipc_write(0xff11d118, 0x7ffffcff);
>> +	if (retval != 0)
>> +		sst_err("scu ipc write2 failed %d", retval);
>> +	/*Bring it out of Audio subsystem reset*/
>> +	retval = sst_scu_ipc_write(0xff11d118, 0x7fffffff);
>> +	if (retval != 0)
>> +		sst_err("scu ipc write3 failed %d", retval);
>> +	/*Enable fabric clock at 50MHz*/
>> +	retval = sst_scu_ipc_write(0xff11d83c, 0x80008301);
>> +	if (retval != 0)
>> +		sst_err("scu ipc write4 failed %d", retval);
>> +	/*Write to the Shim register for ratio 1:1*/
>> +	retval = sst_scu_ipc_write(0xffae8000, 0x382);
>> +	if (retval != 0)
>> +		sst_err("scu ipc write5 failed %d", retval);
>> +	/*Enable the core clock at 1:2*/
>> +	retval = sst_scu_ipc_write(0xff11d83c, 0x80000301);
>> +	if (retval != 0)
>> +		sst_err("scu ipc write6 failed %d", retval);
>> +	return;
>
>So... no these errors are no critical errors?
These are critical errors. The recovery mechanism is not in place yet. I should have marked it as TBD. We will resubmit with the recovery mechanism next time.

>
>> +int sst_parse_module(struct fw_module_header *module)
>
>Hmm... are all these global?
No, it's local. I'll make it static.

>
>> +/*fops Routines*/
>> +const struct file_operations intel_sst_fops = {
>
>Shouldn't be statc?
Yes. Will change it.

>
>> +#ifdef CONFIG_SST_OSPM_SUPPORT
>
>Can't be simple CONFIG_PM?
No. OSPM is new power management module being developed for the platform. The code defined under this #def is to provide support from audio stack to this new power management module. This is also being up streamed by Intel.

-Harsha
