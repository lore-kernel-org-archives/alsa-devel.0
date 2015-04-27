From: Firo Yang <firogm@gmail.com>
Subject: Re: [PATCH] ASoC: Intel: fix Coccinelle kfree warning
Date: Mon, 27 Apr 2015 15:42:22 +0800
Message-ID: <20150427074221.GA6979@firo.lan>
References: <1430062932-26668-1-git-send-email-firogm@gmail.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A905520746@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A905520746@SHSMSX101.ccr.corp.intel.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "Lu, Han" <han.lu@intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "Piskorski, Pawel" <pawel.piskorski@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Jin, Yao" <yao.jin@intel.com>
List-Id: alsa-devel@alsa-project.org

Thanks, Jie.

I find another simlar BUG in 
./sound/soc/intel/baytrail/sst-baytrail-ipc.c::sst_byt_dsp_init()
Does anyone fixed it, too?

Regards
Firo

On Mon, Apr 27, 2015 at 07:23:32AM +0000, Jie, Yang wrote:
>> -----Original Message-----
>> From: Firo Yang [mailto:firogm@gmail.com]
>> Sent: Sunday, April 26, 2015 11:42 PM
>> To: lgirdwood@gmail.com
>> Cc: kernel-janitors@vger.kernel.org; broonie@kernel.org; perex@perex.cz;
>> tiwai@suse.de; Jie, Yang; Lu, Han; jarkko.nikula@linux.intel.com; Piskorski,
>> Pawel; alsa-devel@alsa-project.org; Firo Yang
>> Subject: [PATCH] ASoC: Intel: fix Coccinelle kfree warning
>> 
>> It's not necessary to use kfree() to free memory allocated with devm_kzalloc
>> in a probe function and using kfree leads to a double free.
>> 
>> Signed-off-by: Firo Yang <firogm@gmail.com>
>> ---
>>  sound/soc/intel/haswell/sst-haswell-ipc.c | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c
>> b/sound/soc/intel/haswell/sst-haswell-ipc.c
>> index 344a1e9..324eceb 100644
>> --- a/sound/soc/intel/haswell/sst-haswell-ipc.c
>> +++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
>> @@ -2201,7 +2201,6 @@ dma_err:
>>  dsp_new_err:
>>  	sst_ipc_fini(ipc);
>>  ipc_init_err:
>> -	kfree(hsw);
> 
>It has been fixed by Jin Yao 2 weeks ago:
>http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=ac98b4c015b50b1e452f8d55b612320be7f80825
>
>~Keyon
>
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(sst_hsw_dsp_init);
>> --
>> 2.1.0
>
