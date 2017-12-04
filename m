From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC 04/10] ASoC: Intel: Skylake: use hda_bus
 instead of hdac_bus
Date: Mon, 4 Dec 2017 16:09:27 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579AC6003@BGSMSX104.gar.corp.intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1512119648-2700-5-git-send-email-rakesh.a.ughreja@intel.com>
 <86f8f2f1-fd6f-0fe9-0400-8264062eeb52@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A60E6266BBC
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 17:09:36 +0100 (CET)
In-Reply-To: <86f8f2f1-fd6f-0fe9-0400-8264062eeb52@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>Sent: Friday, December 1, 2017 11:57 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; alsa-devel@alsa-
>project.org; broonie@kernel.org; tiwai@suse.de; liam.r.girdwood@linux.intel.com
>Cc: Koul, Vinod <vinod.koul@intel.com>; Patches Audio
><patches.audio@intel.com>
>Subject: Re: [alsa-devel] [RFC 04/10] ASoC: Intel: Skylake: use hda_bus instead of
>hdac_bus
>
>On 12/1/17 3:14 AM, Rakesh Ughreja wrote:
>> This patch prepares SKL platform driver to make reuse of legacy HDA
>> codec drivers. It does following things.
>>
>> use hda_bus instead of hdac_bus in the SKL platform driver to align
>> with the legacy controller driver.
>>
>> modify snd_hdac_ext_bus_device_init definition to align with
>> snd_hdac_bus_device_init, used by legacy drivers.
>> Memory for hdac_device is allocated by the caller.
>>
>> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
>> ---
>>   include/sound/hdaudio_ext.h   |  3 ++-
>>   sound/hda/ext/hdac_ext_bus.c  |  9 ++-------
>>   sound/soc/intel/skylake/skl.c | 19 ++++++++++++++++++-
>>   sound/soc/intel/skylake/skl.h | 10 +++++++---
>>   4 files changed, 29 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
>> index 3c30247..c188b80 100644
>> --- a/include/sound/hdaudio_ext.h
>> +++ b/include/sound/hdaudio_ext.h
>> @@ -9,7 +9,8 @@ int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device
>*dev,
>>   		      const struct hdac_io_ops *io_ops);
>>
>>   void snd_hdac_ext_bus_exit(struct hdac_bus *bus);
>> -int snd_hdac_ext_bus_device_init(struct hdac_bus *bus, int addr);
>> +int snd_hdac_ext_bus_device_init(struct hdac_bus *bus, int addr,
>> +						struct hdac_device *hdev);
>>   void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev);
>>   void snd_hdac_ext_bus_device_remove(struct hdac_bus *bus);
>>
>> diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
>> index 52f0776..e4bcb76 100644
>> --- a/sound/hda/ext/hdac_ext_bus.c
>> +++ b/sound/hda/ext/hdac_ext_bus.c
>> @@ -135,16 +135,12 @@ static void default_release(struct device *dev)
>>    *
>>    * Returns zero for success or a negative error code.
>>    */
>> -int snd_hdac_ext_bus_device_init(struct hdac_bus *bus, int addr)
>> +int snd_hdac_ext_bus_device_init(struct hdac_bus *bus, int addr,
>> +					struct hdac_device *hdev)
>>   {
>> -	struct hdac_device *hdev = NULL;
>>   	char name[15];
>>   	int ret;
>>
>> -	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
>> -	if (!hdev)
>> -		return -ENOMEM;
>> -
>>   	hdev->bus = bus;
>>
>>   	snprintf(name, sizeof(name), "ehdaudio%dD%d", bus->idx, addr);
>> @@ -175,7 +171,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_init);
>>   void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev)
>>   {
>>   	snd_hdac_device_exit(hdev);
>> -	kfree(hdev);
>>   }
>>   EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_exit);
>>
>> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
>> index 568a285..72a788a 100644
>> --- a/sound/soc/intel/skylake/skl.c
>> +++ b/sound/soc/intel/skylake/skl.c
>> @@ -35,6 +35,7 @@
>>   #include "skl.h"
>>   #include "skl-sst-dsp.h"
>>   #include "skl-sst-ipc.h"
>> +#include "../../../pci/hda/hda_codec.h"
>>
>>   static struct skl_machine_pdata skl_dmic_data;
>>
>> @@ -531,6 +532,8 @@ static int probe_codec(struct hdac_bus *bus, int addr)
>>   	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
>>   		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
>>   	unsigned int res = -1;
>> +	struct skl *skl = bus_to_skl(bus);
>> +	struct hdac_device *hdev;
>>
>>   	mutex_lock(&bus->cmd_mutex);
>>   	snd_hdac_bus_send_cmd(bus, cmd);
>> @@ -540,7 +543,11 @@ static int probe_codec(struct hdac_bus *bus, int addr)
>>   		return -EIO;
>>   	dev_dbg(bus->dev, "codec #%d probed OK\n", addr);
>>
>> -	return snd_hdac_ext_bus_device_init(bus, addr);
>> +	hdev = devm_kzalloc(&skl->pci->dev, sizeof(*hdev), GFP_KERNEL);
>> +	if (!hdev)
>> +		return -ENOMEM;
>> +
>> +	return snd_hdac_ext_bus_device_init(bus, addr, hdev);
>>   }
>>
>>   /* Codec initialization */
>> @@ -665,6 +672,7 @@ static int skl_create(struct pci_dev *pci,
>>   {
>>   	struct skl *skl;
>>   	struct hdac_bus *bus;
>> +	struct hda_bus *hbus;
>>
>>   	int err;
>>
>> @@ -680,6 +688,7 @@ static int skl_create(struct pci_dev *pci,
>>   		return -ENOMEM;
>>   	}
>>
>> +	hbus = skl_to_hbus(skl);
>>   	bus = skl_to_bus(skl);
>>   	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops);
>>   	bus->use_posbuf = 1;
>> @@ -687,6 +696,14 @@ static int skl_create(struct pci_dev *pci,
>>   	INIT_WORK(&skl->probe_work, skl_probe_work);
>>   	bus->bdl_pos_adj = 0;
>>
>> +	/*
>> +	 * TODO: other parameters can be taken the way it is taken by
>> +	 * legacy HDA driver
>
>what parameters where you referring to? kernel module?

In the following code, I have not initialized all the fields of hbus.
So in this TODO, I wanted to remind myself that all the parameters
of hbus needs to be initialized as required by legacy codec driver.

>
>> +	 */
>> +	mutex_init(&hbus->prepare_mutex);
>> +	hbus->pci = pci;
>> +	hbus->mixer_assigned = -1;
>> +
