From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 01/21] ASoC: SOF: Intel: Add BYT,
 CHT and BSW DSP HW support.
Date: Mon, 17 Dec 2018 13:40:32 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1952795153@SHSMSX103.ccr.corp.intel.com>
References: <1d099b6a-40f5-689f-e2bd-2e5345893310@sakamocchi.jp>
 <b8db627a-bd32-34d7-b45b-aeb2206b2b17@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <b8db627a-bd32-34d7-b45b-aeb2206b2b17@linux.intel.com>
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
To: "o-takashi@sakamocchi.jp" <o-takashi@sakamocchi.jp>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>, "Shevchenko,
 Andriy" <andriy.shevchenko@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "xiuli.pan@linux.intel.com" <xiuli.pan@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "vkoul@kernel.org" <vkoul@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>, "sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Sakamoto,

>
>-------- Forwarded Message --------
>Subject: Re: [alsa-devel] [PATCH 01/21] ASoC: SOF: Intel: Add BYT, CHT and
>BSW DSP HW support.
>Date: Wed, 12 Dec 2018 13:08:48 +0900
>From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
>alsa-devel@alsa-project.org
>CC: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com,
>tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>,
>liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org,
>sound-open-firmware@alsa-project.org, Rander Wang
><rander.wang@linux.intel.com>, Alan Cox <alan@linux.intel.com>
>
>Hi,
>
>I have small nitpicking.
>
>On 2018/12/12 6:30, Pierre-Louis Bossart wrote:
>> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>>
>> Add support for the audio DSP hardware found on Intel Baytrail,
>> Cherrytrail and Braswell based devices.
>>
>> Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
>> Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
>> Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>> Signed-off-by: Pierre-Louis Bossart
>> <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/sof/intel/byt.c  | 805
>+++++++++++++++++++++++++++++++++++++
>>   sound/soc/sof/intel/shim.h | 159 ++++++++
>>   2 files changed, 964 insertions(+)
>>   create mode 100644 sound/soc/sof/intel/byt.c
>>   create mode 100644 sound/soc/sof/intel/shim.h ..
>> diff --git a/sound/soc/sof/intel/shim.h b/sound/soc/sof/intel/shim.h
>> new file mode 100644 index 000000000000..2fdcb2d262f4
>> --- /dev/null
>> +++ b/sound/soc/sof/intel/shim.h
>> @@ -0,0 +1,159 @@
>> ...
>> +extern struct snd_sof_dsp_ops sof_byt_ops; extern struct
>> +snd_sof_dsp_ops sof_cht_ops;
>
>These two symbols are found in this patch.
>
>> +extern struct snd_sof_dsp_ops sof_hsw_ops;
>
>This symbol is added in second patch and this first patch has no reference to it.
>
>> +extern struct snd_sof_dsp_ops sof_bdw_ops;
>
>This symbol is added in third patch and this first patch has no reference to it.
>
>> +
>> +#endif
>
>I think it better to add these extern declarations when adding corresponding
>symbols (Of course no issues as is).
>
>Furthermore, if you have no plan to change contents of these symbols in
>kernel run time, it's better to have 'const' qualifier to locate the symbol to
>readonly section. However, user of these symbols is machine driver and you
>have a plan to implement it later. They can get 'const'
>when you work for arrangement of existent/new codes.
>
>In this meaning, it might be good to add a new member to 'struct
>snd_soc_acpi_mach' for new drivers to refer to the const ops, then 'pdata'
>member is used from the existent drivers.

I made a patch based on your suggestion. Could you please help review
to see if my understanding is right?
https://github.com/thesofproject/linux/pull/457

Regards,
Libin

>
>
>Regards
>
>Takashi Sakamoto
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@alsa-project.org
>http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
