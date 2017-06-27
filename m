From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 alsa-lib 1/6] pcm: hw: add helper
 functions to map/unmap status/control data for runtime of PCM substream
Date: Tue, 27 Jun 2017 17:09:37 +0900
Message-ID: <d9ebcb11-05bd-925c-9a68-5cda5e17cc93@sakamocchi.jp>
References: <20170625044124.22234-1-o-takashi@sakamocchi.jp>
 <20170625044124.22234-2-o-takashi@sakamocchi.jp>
 <s5hy3sekcpa.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 5B4A7266819
 for <alsa-devel@alsa-project.org>; Tue, 27 Jun 2017 10:09:39 +0200 (CEST)
In-Reply-To: <s5hy3sekcpa.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 27 2017 00:09, Takashi Iwai wrote:
> On Sun, 25 Jun 2017 06:41:19 +0200,
> Takashi Sakamoto wrote:
>>
>> Handling mapping operation for status/control data includes some
>> supplemental operations for fallback mode. It's better to have helper
>> functions for this purpose.
>>
>> This commit adds the helper functions.
>> ---
>>   src/pcm/pcm_hw.c | 48 ++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 34 insertions(+), 14 deletions(-)
>>
>> diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
>> index a648d12c..abf4afe0 100644
>> --- a/src/pcm/pcm_hw.c
>> +++ b/src/pcm/pcm_hw.c
>> @@ -31,6 +31,7 @@
>>   #include <stdlib.h>
>>   #include <stddef.h>
>>   #include <unistd.h>
>> +#include <stdbool.h>
>>   #include <signal.h>
>>   #include <string.h>
>>   #include <fcntl.h>
>> @@ -866,7 +867,7 @@ static snd_pcm_sframes_t snd_pcm_hw_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_u
>>   	return xfern.result;
>>   }
>>   
>> -static int snd_pcm_hw_mmap_status(snd_pcm_t *pcm)
>> +static int map_status_data(snd_pcm_t *pcm)
>>   {
>>   	snd_pcm_hw_t *hw = pcm->private_data;
>>   	struct snd_pcm_sync_ptr sync_ptr;
>> @@ -900,7 +901,7 @@ static int snd_pcm_hw_mmap_status(snd_pcm_t *pcm)
>>   	return 0;
>>   }
>>   
>> -static int snd_pcm_hw_mmap_control(snd_pcm_t *pcm)
>> +static int map_control_data(snd_pcm_t *pcm)
>>   {
>>   	snd_pcm_hw_t *hw = pcm->private_data;
>>   	void *ptr;
>> @@ -922,10 +923,28 @@ static int snd_pcm_hw_mmap_control(snd_pcm_t *pcm)
>>   	return 0;
>>   }
>>   
>> -static int snd_pcm_hw_munmap_status(snd_pcm_t *pcm)
>> +static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
>>   {
>>   	snd_pcm_hw_t *hw = pcm->private_data;
>>   	int err;
>> +
>> +	hw->sync_ptr_ioctl = (int)force_fallback;
>> +
>> +	err = map_status_data(pcm);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	err = map_control_data(pcm);
>> +	if (err < 0)
>> +		return err;
> 
> This would leave the status mmap in the error path?

In the error path, snd_pcm_hw_open_fd() calls snd_pcm_close(), then The 
status data is going to be unmapped.

snd_pcm_hw_open_fd()
->snd_pcm_close()
   ->snd_pcm_hw_close()
     ->unmap_status_and_control_data()
       ->unmap_status_data()
         ->munmap(2) or free(3)


Thanks

Takashi Sakamoto
