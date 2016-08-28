From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: Re: [PATCH 1/1] ASoC: Intel: Atom: add a missing star in a memcpy
 call
Date: Sun, 28 Aug 2016 20:31:26 +0200
Message-ID: <c6077e34-64d9-c030-c23a-e2f246deb3ee@m4x.org>
References: <20160828173945.27721-1-nicolas.iooss_linux@m4x.org>
 <1472408231.26978.98.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472408231.26978.98.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 28/08/16 20:17, Joe Perches wrote:
> On Sun, 2016-08-28 at 19:39 +0200, Nicolas Iooss wrote:
>> In sst_prepare_and_post_msg(), when a response is received in "block",
>> the following code gets executed:
>>
>>     *data = kzalloc(block->size, GFP_KERNEL);
>>     memcpy(data, (void *) block->data, block->size);
>>
>> The memcpy() call overwrites the content of the *data pointer instead of
>> filling the newly-allocated memory (which pointer is hold by *data).
>> Fix this by using *data in the memcpy() call.
>>
>> Fixes: 60dc8dbacb00 ("ASoC: Intel: sst: Add some helper functions")
>> Cc: stable@vger.kernel.org # 3.19.x
>> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
>> ---
>>  sound/soc/intel/atom/sst/sst_pvt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
>> index adb32fefd693..7c398b7c9d4b 100644
>> --- a/sound/soc/intel/atom/sst/sst_pvt.c
>> +++ b/sound/soc/intel/atom/sst/sst_pvt.c
>> @@ -289,7 +289,7 @@ int sst_prepare_and_post_msg(struct intel_sst_drv *sst,
>>  				ret = -ENOMEM;
>>  				goto out;
>>  			} else
>> -				memcpy(data, (void *) block->data, block->size);
>> +				memcpy(*data, (void *) block->data, block->size);
>>  		}
>>  	}
>>  out:
> 
> Perhaps this would be nicer using kmemdup too

Thanks for your quick reply! I agree using kmemdup looks nicer here and
your patch looks good. I will send a v2 once I compile-tested it.

Nicolas
