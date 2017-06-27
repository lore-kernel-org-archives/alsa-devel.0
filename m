From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 alsa-lib 1/6] pcm: hw: add helper
 functions to map/unmap status/control data for runtime of PCM substream
Date: Tue, 27 Jun 2017 17:57:55 +0900
Message-ID: <951018eb-0cc9-853b-44a6-491bdd1eb014@sakamocchi.jp>
References: <20170625044124.22234-1-o-takashi@sakamocchi.jp>
 <20170625044124.22234-2-o-takashi@sakamocchi.jp>
 <s5hy3sekcpa.wl-tiwai@suse.de>
 <d9ebcb11-05bd-925c-9a68-5cda5e17cc93@sakamocchi.jp>
 <s5ho9t9q22a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 61E8B266819
 for <alsa-devel@alsa-project.org>; Tue, 27 Jun 2017 10:57:57 +0200 (CEST)
In-Reply-To: <s5ho9t9q22a.wl-tiwai@suse.de>
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

On Jun 27 2017 17:15, Takashi Iwai wrote:
> On Tue, 27 Jun 2017 10:09:37 +0200,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> On Jun 27 2017 00:09, Takashi Iwai wrote:
>>> On Sun, 25 Jun 2017 06:41:19 +0200,
>>> Takashi Sakamoto wrote:
>>>>
>>>> Handling mapping operation for status/control data includes some
>>>> supplemental operations for fallback mode. It's better to have helper
>>>> functions for this purpose.
>>>>
>>>> This commit adds the helper functions.
>>>> ---
>>>>    src/pcm/pcm_hw.c | 48 ++++++++++++++++++++++++++++++++++--------------
>>>>    1 file changed, 34 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
>>>> index a648d12c..abf4afe0 100644
>>>> --- a/src/pcm/pcm_hw.c
>>>> +++ b/src/pcm/pcm_hw.c
>>>> @@ -31,6 +31,7 @@
>>>>    #include <stdlib.h>
>>>>    #include <stddef.h>
>>>>    #include <unistd.h>
>>>> +#include <stdbool.h>
>>>>    #include <signal.h>
>>>>    #include <string.h>
>>>>    #include <fcntl.h>
>>>> @@ -866,7 +867,7 @@ static snd_pcm_sframes_t snd_pcm_hw_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_u
>>>>    	return xfern.result;
>>>>    }
>>>>    -static int snd_pcm_hw_mmap_status(snd_pcm_t *pcm)
>>>> +static int map_status_data(snd_pcm_t *pcm)
>>>>    {
>>>>    	snd_pcm_hw_t *hw = pcm->private_data;
>>>>    	struct snd_pcm_sync_ptr sync_ptr;
>>>> @@ -900,7 +901,7 @@ static int snd_pcm_hw_mmap_status(snd_pcm_t *pcm)
>>>>    	return 0;
>>>>    }
>>>>    -static int snd_pcm_hw_mmap_control(snd_pcm_t *pcm)
>>>> +static int map_control_data(snd_pcm_t *pcm)
>>>>    {
>>>>    	snd_pcm_hw_t *hw = pcm->private_data;
>>>>    	void *ptr;
>>>> @@ -922,10 +923,28 @@ static int snd_pcm_hw_mmap_control(snd_pcm_t *pcm)
>>>>    	return 0;
>>>>    }
>>>>    -static int snd_pcm_hw_munmap_status(snd_pcm_t *pcm)
>>>> +static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
>>>>    {
>>>>    	snd_pcm_hw_t *hw = pcm->private_data;
>>>>    	int err;
>>>> +
>>>> +	hw->sync_ptr_ioctl = (int)force_fallback;
>>>> +
>>>> +	err = map_status_data(pcm);
>>>> +	if (err < 0)
>>>> +		return err;
>>>> +
>>>> +	err = map_control_data(pcm);
>>>> +	if (err < 0)
>>>> +		return err;
>>>
>>> This would leave the status mmap in the error path?
>>
>> In the error path, snd_pcm_hw_open_fd() calls snd_pcm_close(), then
>> The status data is going to be unmapped.
>>
>> snd_pcm_hw_open_fd()
>> ->snd_pcm_close()
>>    ->snd_pcm_hw_close()
>>      ->unmap_status_and_control_data()
>>        ->unmap_status_data()
>>          ->munmap(2) or free(3)
> 
> Ah then there was already a bug there.  It free/munmap unconditionally
> for both status and control even for an error path of the mmap of
> control (while status was mmapped).

Yep. These codes were originally written with a loose manner. But it 
would be allowed because both 'mmap(NULL, non-zero)' and 'free(NULL)' 
generates no error and 'sync_ptr_ioctl' works fine, and 'sync_ptr' is 
assigned to NULL after deallocated.

> But OK, it's no big issue and doesn't need to block the whole patchset
> at this point.

For your information.

======== 8< --------
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <string.h>
#include <limits.h>
#include <errno.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <sys/ioctl.h>
#include <sys/mman.h>

#include <sound/asound.h>

int main(void)
{
     int fd;
     size_t page_size = sysconf(_SC_PAGESIZE);
     int pages;
     void *status;
     int status_length;
     void *control;
     int control_length;

     fd = open("/dev/snd/pcmC0D0p", O_RDWR);
     if (fd < 0) {
         printf("open(2): %s\n", strerror(errno));
         return EXIT_FAILURE;
     }

     /* Map status data. */
     pages = (sizeof(struct snd_pcm_mmap_status) + page_size - 1) / 
page_size;
     status_length = pages * page_size;
     status = MAP_FAILED;
     status = mmap(NULL, status_length, PROT_READ, MAP_FILE | MAP_SHARED,
                   fd, SNDRV_PCM_MMAP_OFFSET_STATUS);
     if (status == MAP_FAILED || status == NULL) {
         close(fd);
         printf("mmap(2): status: %s\n", strerror(errno));
         return EXIT_FAILURE;
     }

     /* Map control data. */
     pages = (sizeof(struct snd_pcm_mmap_control) + page_size - 1) / 
page_size;
     control_length = pages * page_size;
     control = MAP_FAILED;
     control = mmap(NULL, control_length, PROT_READ | PROT_WRITE,
                    MAP_FILE | MAP_SHARED, fd, 
SNDRV_PCM_MMAP_OFFSET_CONTROL);
     if (status == MAP_FAILED || status == NULL) {
         munmap(status, status_length);
         close(fd);
         printf("mmap(2): control: %s\n", strerror(errno));
         return EXIT_FAILURE;
     }

     /* Not error. */
     if (munmap(NULL, 10000) < 0)
         printf("unexpected: munmap(2): NULL: %s\n", strerror(errno));

     /* Generate error. */
     if (munmap(NULL, 0) < 0)
         printf("expected: munmap(2): NULL: %s\n", strerror(errno));
     /* Ditto. */
     if (munmap(control, 0) < 0)
         printf("expected: munmap(2): control: 0: %s\n", strerror(errno));
     /* Ditto. */
     if (munmap(status, 0) < 0)
         printf("expected: munmap(2): status: 0: %s\n", strerror(errno));

     if (munmap(control, control_length) < 0)
         printf("unexpected: munmap(2): control: 0: %s\n", strerror(errno));
     if (munmap(status, status_length) < 0)
         printf("unexpected: munmap(2): status: 0: %s\n", strerror(errno));
     close(fd);

     /* Not error. */
     free(NULL);

     return EXIT_SUCCESS;
}
======== 8< --------


Regards

Takashi Sakamoto
