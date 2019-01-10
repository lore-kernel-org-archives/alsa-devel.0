From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: sst: Delay machine device
 creation until after initialization
Date: Thu, 10 Jan 2019 11:50:05 -0600
Message-ID: <8ebe1f52-f1eb-2d6b-84f2-268277308495@linux.intel.com>
References: <20181216184955.20192-1-stephan@gerhold.net>
 <20190110165535.GA12236@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 593A0267547
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 18:50:07 +0100 (CET)
In-Reply-To: <20190110165535.GA12236@gerhold.net>
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
To: Stephan Gerhold <stephan@gerhold.net>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 1/10/19 10:55 AM, Stephan Gerhold wrote:
> On Sun, Dec 16, 2018 at 07:49:56PM +0100, Stephan Gerhold wrote:
>> Right now, the machine devices are created early, before the
>> SST context is initialized. This means that SST might not be
>> fully initialized if sst_acpi_probe() fails later on (e.g. after
>> sst_platform_get_resources() if the IRQ does not exist).

But that's a theoretical point here, isn't it. Your other patch solves 
the IRQ issue so do we have a real problem?

The reason why I am pushing back is that we've moved this code around 
several times and I am concerned about side effects - and none of the 
original developers are still around.

>>
>> However, at least sst-mfld-platform assumes that sst_register_dsp()
>> was called to set the (global) "sst" device pointer, which happens
>> only later in sst_acpi_probe() when sst_context_init() is called.
>> This may cause a NULL pointer dereference later when the ALSA device
>> is first opened:
>>
>>    BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
>>    PGD 0 P4D 0
>>    Oops: 0000 [#1] PREEMPT SMP PTI
>>    CPU: 0 PID: 790 Comm: pulseaudio Not tainted 4.20.0-rc6-mainline-00161-g6531e115b7ab #1
>>    Hardware name: ASUSTeK COMPUTER INC. ME176C/ME176C, BIOS 5.6.5 09/16/2015
>>    RIP: 0010:sst_handle_vb_timer+0x61/0x1b0 [snd_soc_sst_atom_hifi2_platform]
>>    Code: 44 24 04 e9 84 00 00 00 31 c9 c7 04 24 ff ff ff ff 66 89 4c 24 06 84 db 0f 84 90 00 00 00 48 8b 05 c4 23 01 00 be 01 00 00 00 <48> 8b 78 08 48 8b 40 10 48 8b 40 48 e8 2e 5e d7 f0 89 c3 85 c0 78
>>    RSP: 0018:ffff9d968099fa30 EFLAGS: 00010202
>>    RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
>>    RDX: 0000000080000001 RSI: 0000000000000001 RDI: 00000000ffffffff
>>    RBP: ffff968d33384618 R08: 0000000000000001 R09: 00000000000002e3
>>    R10: ffff968d333a0800 R11: 0000000000000000 R12: ffff968d34bc7c00
>>    R13: ffff968d333a3eb0 R14: 0000000000000001 R15: ffff968d333a08c0
>>    FS:  00007f63a7e7b200(0000) GS:ffff968d37600000(0000) knlGS:0000000000000000
>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>    CR2: 0000000000000008 CR3: 00000000297b8000 CR4: 00000000001006f0
>>    Call Trace:
>>     sst_enable_ssp+0x24/0x40 [snd_soc_sst_atom_hifi2_platform]
>>     soc_pcm_open+0xeb/0x960 [snd_soc_core]
>>     ? __debugfs_create_file+0xcd/0x120
>>     dpcm_be_dai_startup+0x183/0x3c0 [snd_soc_core]
>>     dpcm_fe_dai_open+0x10c/0xab0 [snd_soc_core]
>>     snd_pcm_open_substream+0x7f/0x140 [snd_pcm]
>>     snd_pcm_open+0xe6/0x220 [snd_pcm]
>>     ? wake_up_q+0x70/0x70
>>     snd_pcm_playback_open+0x3d/0x70 [snd_pcm]
>>     chrdev_open+0xa3/0x1b0
>>     ? cdev_put.part.0+0x20/0x20
>>     do_dentry_open+0x12f/0x350
>>     path_openat+0x2d1/0x14e0
>>     ? inotify_handle_event+0x17b/0x1e0
>>     do_filp_open+0x93/0x100
>>     ? snd_card_file_remove+0x14b/0x170 [snd]
>>     ? __check_object_size+0x102/0x189
>>     ? _raw_spin_unlock+0x12/0x30
>>     do_sys_open+0x186/0x210
>>     do_syscall_64+0x55/0x160
>>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>    RIP: 0033:0x7f63a992f4c2
>>    Code: 25 00 00 41 00 3d 00 00 41 00 74 4c 48 8d 05 85 70 0d 00 8b 00 85 c0 75 6d 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 0f 87 a2 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
>>    RSP: 002b:00007ffe71196b70 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
>>    RAX: ffffffffffffffda RBX: 0000000000080802 RCX: 00007f63a992f4c2
>>    RDX: 0000000000080802 RSI: 00007ffe71196d20 RDI: 00000000ffffff9c
>>    RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
>>    R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe71196c00
>>    R13: 0000000000000004 R14: 00007ffe71196d20 R15: 0000558466055a80
>>    CR2: 0000000000000008
>>    ---[ end trace 34534a02650ee26c ]---
>>
>> This can be avoided if the machine device creation is delayed
>> in sst_acpi_probe() until after sst_context_init(), when
>> sst_register_dsp() is guaranteed to have already been called.
>>
>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>> ---
>> An other option to fix this would be to add proper NULL checks
>> in the probe method of sst-mfld-platform and/or sst_enable_ssp().
>> Maybe this should be done additionally, but at least in my opinion
>> there is not much point in registering the machine devices if they
>> end up being broken anyway.
>>
>>   sound/soc/intel/atom/sst/sst_acpi.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
>> index ac542535b9d5..493d32923815 100644
>> --- a/sound/soc/intel/atom/sst/sst_acpi.c
>> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
>> @@ -345,6 +345,18 @@ static int sst_acpi_probe(struct platform_device *pdev)
>>   	mach->mach_params.acpi_ipc_irq_index =
>>   		pdata->res_info->acpi_ipc_irq_index;
>>   
>> +	/* Fill sst platform data */
>> +	ctx->pdata = pdata;
>> +	strcpy(ctx->firmware_name, mach->fw_filename);
>> +
>> +	ret = sst_platform_get_resources(ctx);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = sst_context_init(ctx);
>> +	if (ret < 0)
>> +		return ret;
>> +
>>   	plat_dev = platform_device_register_data(dev, pdata->platform, -1,
>>   						NULL, 0);
>>   	if (IS_ERR(plat_dev)) {
>> @@ -365,18 +377,6 @@ static int sst_acpi_probe(struct platform_device *pdev)
>>   		return PTR_ERR(mdev);
>>   	}
>>   
>> -	/* Fill sst platform data */
>> -	ctx->pdata = pdata;
>> -	strcpy(ctx->firmware_name, mach->fw_filename);
>> -
>> -	ret = sst_platform_get_resources(ctx);
>> -	if (ret)
>> -		return ret;
>> -
>> -	ret = sst_context_init(ctx);
>> -	if (ret < 0)
>> -		return ret;
>> -
>>   	sst_configure_runtime_pm(ctx);
>>   	platform_set_drvdata(pdev, ctx);
>>   	return ret;
>> -- 
>> 2.20.0
>>
> Hi,
>
> Mark's mail on the other thread ("ASoC: Intel: sst: Missing IRQ at index
> 5 on BYT-T device") just reminded me that this patch is still open.
>
> With "ASoC: Intel: sst: Fallback to BYT-CR if IRQ 5 is missing" the
> initialization failure is solved for my device, and it does no longer
> run into this BUG. However, the NULL pointer dereference is still
> possible if another device has no or an invalid IRQ listed, causing
> SST initialization to fail.
>
> This patch is one way to avoid it.
>
> Let me know if I should re-send the patch (in case you cannot find it
> anymore). :)
>
> Thanks,
> Stephan
