From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] alsa-lib: Add sys/types.h to include list
Date: Tue, 12 Feb 2013 10:16:13 +0100
Message-ID: <511A085D.4000700@canonical.com>
References: <1360659971-3852-1-git-send-email-david.henningsson@canonical.com>
 <s5hliatoq2i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F2A4260317
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2013 10:16:14 +0100 (CET)
In-Reply-To: <s5hliatoq2i.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, 1109298@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 02/12/2013 10:10 AM, Takashi Iwai wrote:
> At Tue, 12 Feb 2013 10:06:11 +0100,
> David Henningsson wrote:
>>
>> This is needed by snd_pcm_format_silence* functions which
>> return u_int*_t. It was discovered while trying to compile ALSA
>> programs with eglibc 2.17.
>>
>> Credits to Richard Shaw, Gary Buhrmaster, Matthieu Baerts and
>>   Adam Conrad for this fix.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1109298
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=885306
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> For u_int_* types, wouldn't it better to include stdint.h?

Hmm, it looks like stdint.h declares uint_* whereas sys/types.h declares 
u_int_* (notice the _ between "u" and "int"). Do you think we should 
change snd_pcm_format_silence* from u_int to uint?

>
>
> Takashi
>
>> ---
>>   include/asoundlib-head.h |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/asoundlib-head.h b/include/asoundlib-head.h
>> index 20c8a68..6edbab0 100644
>> --- a/include/asoundlib-head.h
>> +++ b/include/asoundlib-head.h
>> @@ -31,6 +31,7 @@
>>   #include <unistd.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>> +#include <sys/types.h>
>>   #include <string.h>
>>   #include <fcntl.h>
>>   #include <assert.h>
>> --
>> 1.7.9.5
>>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
