From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 01/21] ASoC: SOF: Intel: Add BYT,
 CHT and BSW DSP HW support.
Date: Wed, 12 Dec 2018 08:45:58 -0600
Message-ID: <9dd7358b-45e9-2d66-09b5-1ce17aa592eb@linux.intel.com>
References: <20181211213029.28801-1-pierre-louis.bossart@linux.intel.com>
 <20181211213029.28801-2-pierre-louis.bossart@linux.intel.com>
 <1d099b6a-40f5-689f-e2bd-2e5345893310@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1d099b6a-40f5-689f-e2bd-2e5345893310@sakamocchi.jp>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review.

>> +++ b/sound/soc/sof/intel/shim.h
>> @@ -0,0 +1,159 @@
>> ...
>> +extern struct snd_sof_dsp_ops sof_byt_ops;
>> +extern struct snd_sof_dsp_ops sof_cht_ops;
>
> These two symbols are found in this patch.
>
>> +extern struct snd_sof_dsp_ops sof_hsw_ops;
>
> This symbol is added in second patch and this first patch has
> no reference to it.
>
>> +extern struct snd_sof_dsp_ops sof_bdw_ops;
>
> This symbol is added in third patch and this first patch has
> no reference to it.
>
>> +
>> +#endif
>
> I think it better to add these extern declarations when adding
> corresponding symbols (Of course no issues as is).
Yes, that's no big deal. It won't break as is though since the build is 
added in the last patch.
>
> Furthermore, if you have no plan to change contents of these symbols in
> kernel run time, it's better to have 'const' qualifier to locate the
> symbol to readonly section. However, user of these symbols is machine
> driver and you have a plan to implement it later. They can get 'const'
> when you work for arrangement of existent/new codes.
Good point, I don't think the ops are changed, ever. I'll double-check 
and change if indeed this is the case, thanks for the suggestion.
>
> In this meaning, it might be good to add a new member to 'struct
> snd_soc_acpi_mach' for new drivers to refer to the const ops, then
> 'pdata' member is used from the existent drivers.
Sorry, I don't get your point. the ops structure is included in the 
sof_ops_table, not the snd_soc_acpi_mach.
