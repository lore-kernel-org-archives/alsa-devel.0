From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH v2 12/12] ASoC: SOF: Intel: hda-codec: fix
 memory allocation
Date: Mon, 3 Jun 2019 09:10:11 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D195285B18B@SHSMSX103.ccr.corp.intel.com>
References: <20190522162142.11525-1-pierre-louis.bossart@linux.intel.com>
 <20190522162142.11525-13-pierre-louis.bossart@linux.intel.com>
 <96A12704CE18D347B625EE2D4A099D195284169B@SHSMSX103.ccr.corp.intel.com>
 <s5hr28pfux1.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19528416D3@SHSMSX103.ccr.corp.intel.com>
 <s5ho93tfuea.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB636F896CE
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 11:10:16 +0200 (CEST)
In-Reply-To: <s5ho93tfuea.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Thursday, May 23, 2019 4:27 PM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>; alsa-
>devel@alsa-project.org; broonie@kernel.org
>Subject: Re: [alsa-devel] [PATCH v2 12/12] ASoC: SOF: Intel: hda-codec: fix
>memory allocation
>
>On Thu, 23 May 2019 10:21:20 +0200,
>Yang, Libin wrote:
>>
>> Hi Takashi,
>>
>> >-----Original Message-----
>> >From: Takashi Iwai [mailto:tiwai@suse.de]
>> >Sent: Thursday, May 23, 2019 4:16 PM
>> >To: Yang, Libin <libin.yang@intel.com>
>> >Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>;
>> >alsa- devel@alsa-project.org; broonie@kernel.org
>> >Subject: Re: [alsa-devel] [PATCH v2 12/12] ASoC: SOF: Intel:
>> >hda-codec: fix memory allocation
>> >
>> >On Thu, 23 May 2019 10:03:03 +0200,
>> >Yang, Libin wrote:
>> >>
>> >> Please let me describe the issue here.
>> >>
>> >> The test case is:
>> >> 1) Unload module with script "sudo ./sof_remove.sh" ,
>> >> 2) reload module with script "sudo ./sof_insert.sh"
>> >>
>> >> After several rounds of removing and inserting kernel modules,
>> >> system will complain like below:
>> >> "BUG: unable to handle kernel paging request at 000000292a282031"
>> >
>> >Did you try some kernel debug options?  It might show what went wrong.
>>
>> No, I haven't. I'm not sure which options I can use for this case.
>> Could you please give me some suggestions?
>
>You can enable CONFIG_DEBUG_DEVRES and adjust the devres.log option for
>showing each devres allocation and removal.  And I'd try
>CONFIG_DEBUG_SLAB and CONFIG_DEBUG_KMEMLEAK or whatever
>interesting in CONFIG_DEBUG section, too.

Thanks for your suggestion. After more than 1 week debug, I think maybe 
I have root caused this issue from the devres.log message.

Below is my finding.
1. When initialing the codecs, snd_hdac_ext_bus_device_init() will be called,
and it will set hdev->dev.release = default_release.
However, for analog codec (not hdac_hdmi codec), hdac_hda_codec_probe()
will be called later. And it will call snd_hda_codec_device_new(), which will
reset codec->code.dev.release = snd_hda_codec_dev_release;
This means hdac_hdmi's hdev dev release is default_release() defined in 
hdac_ext_bus.c, and other hda codec's hdev dev release is
snd_hda_codec_dev_release().

Both default_release() and snd_hda_codec_dev_release() will call kfree()
to free the hdac_device (or its container) in the current code.

2. When we run rmmod sof_pci_dev, it will free the sdev. If we use
Struct hdac_device *hdev = devm_kzalloc(sdev->dev...). This means 
hdev will also be freed automatically.

In the removal, snd_hdac_ext_bus_device_remove() will be called
to remove the hdev (in this function it is struct hdac_device *codec.
The name is not aligned in different places). 
However for hdac_hdmi, the hdev->dev is used by other code. 
So calling device.release() (the function default_release()) will
be postponed. After after sdev is freed, the device.release() will
be called. But for devm_xxx, hdev will also be freed when sdev is
freed. This means hdev.dev after sdev is freed is invalid now as
hdev has already freed. It will access invalid memory. This will cause the bug.

So I think we should not use devm_xxx, and let's free the hdev manually.

At the end of this topic, I still found 2 suspicious code in the current code.
1. in sound/soc/intel/skylate/skl.c
it calls hdev = devm_kazlloc() or hda_codec = devm_kzalloc().
As we will call kfree() in the current code, should we replace it with
kzalloc()? Maybe we need cavs drivers owner's help on it.

2. in snd_hdac_ext_bus_device_remove()
It will call snd_hdac_device_unregister() to unregister the hdac_devices
and put_device(&codec->dev) to release the dev.
For analog codec, snd_hdac_device_unregister()  will free the codec->dev's
kobject. And snd_hda_codec_dev_release() will be called to free the 
hdac_device.
So it is invalid to call put_device(&codec->dev). If you print 
refcound_read(&(codec->dev.kobj.kref.refcount)) for analog codec before
put_device(), you will find the refcount has already been 0.

Regards,
Libin 

>
>
>Takashi
