From: "Jin, Yao" <yao.jin@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: Intel: sst_hsw: remove kfree
 for memory allocated with devm_kzalloc
Date: Fri, 17 Apr 2015 05:34:43 +0800
Message-ID: <55302AF3.1010901@linux.intel.com>
References: <1429191978-25839-1-git-send-email-weiyj_lk@163.com> <552FC268.2020503@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <552FC268.2020503@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, weiyj_lk@163.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, dan.carpenter@oracle.com, pawel.piskorski@intel.com, yang.jie@intel.com, han.lu@intel.com
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

For HSW, a patch "[PATCH] ASoC: Intel: Remove invalid kfree of devm
allocated data" to fix this issue has been applied.

But yes, we also need a similar patch for Baytrail.

Thanks
Jin Yao

On 2015/4/16 22:08, Jarkko Nikula wrote:
> On 04/16/2015 04:46 PM, weiyj_lk@163.com wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> It's not necessary to free memory allocated with devm_kzalloc
>> and using kfree leads to a double free.
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> ---
>>   sound/soc/intel/haswell/sst-haswell-ipc.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c
>> b/sound/soc/intel/haswell/sst-haswell-ipc.c
>> index 344a1e9..324eceb 100644
>> --- a/sound/soc/intel/haswell/sst-haswell-ipc.c
>> +++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
>> @@ -2201,7 +2201,6 @@ dma_err:
>>   dsp_new_err:
>>       sst_ipc_fini(ipc);
>>   ipc_init_err:
>> -    kfree(hsw);
>>       return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(sst_hsw_dsp_init);
>>
> Similar case than with baytrail. Here introduced by commit 0e7921e9583b
> ("ASoC: Intel: Use the generic IPC/mailbox APIs in Broadwell")
> 
> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
