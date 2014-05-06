From: Julian Scheel <julian@jusst.de>
Subject: Re: [PATCH] alsactl: Store lockfile in /tmp
Date: Tue, 06 May 2014 20:55:40 +0200
Message-ID: <5369302C.4040502@jusst.de>
References: <1399377427-23907-1-git-send-email-julian@jusst.de>
 <5368F74C.1020907@perex.cz> <s5h61ljuevj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.work.de (smtp1.work.de [212.12.40.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E5212651DC
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 20:55:42 +0200 (CEST)
In-Reply-To: <s5h61ljuevj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 06/05/14 17:05, schrieb Takashi Iwai:
> At Tue, 06 May 2014 16:53:00 +0200,
> Jaroslav Kysela wrote:
>>
>> Date 6.5.2014 13:57, Julian Scheel wrote:
>>> It can not be generally assumed that the directories in which asound.state
>>> resides are writable. Instead using /tmp as location for lock files seems more
>>> reliable.
>>
>> Apart the missing free for the mallocated string and ommiting the TMPDIR
>> environment variable, I think that the right directory for global locks
>> is /var/lock . The default asound.state directory is now /var/lib/alsa -
>> I don't see the benefit.
>
> Agreed.  Above all, using a fixed path with /tmp is really fragile,
> easily leading to a security risk for a service that is run by root
> like this.

I agree that /tmp is not the best choice. It was just what came to my 
mind first when thinking of a place where r/w access shall be possible 
in any system.

>> What's the reason for this change? Perhaps using an environmental
>> variable to override the lock path may be more appropriate for a custom
>> directory structure.
>
> ... or give an option?

What about using /var/lock as default, allowing to explicitly override 
with an option?
I think this would be more correct than the current approach.

-Julian

>>
>>                                     Jaroslav
>>
>>>
>>> Signed-off-by: Julian Scheel <julian@jusst.de>
>>> ---
>>>   alsactl/lock.c | 13 ++++++++++---
>>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/alsactl/lock.c b/alsactl/lock.c
>>> index 587a109..7ca3a09 100644
>>> --- a/alsactl/lock.c
>>> +++ b/alsactl/lock.c
>>> @@ -36,17 +36,24 @@ static int state_lock_(const char *file, int lock, int timeout)
>>>   	struct flock lck;
>>>   	struct stat st;
>>>   	char lcktxt[12];
>>> +	char *filename;
>>>   	char *nfile;
>>>
>>>   	if (!do_lock)
>>>   		return 0;
>>> -	nfile = malloc(strlen(file) + 6);
>>> +
>>> +	/* only use the actual filename, not the path */
>>> +	filename = strrchr(file, '/');
>>> +	if (!filename)
>>> +		filename = file;
>>> +
>>> +	nfile = malloc(strlen(filename) + 10);
>>>   	if (nfile == NULL) {
>>>   		error("No enough memory...");
>>>   		return -ENOMEM;
>>>   	}
>>> -	strcpy(nfile, file);
>>> -	strcat(nfile, ".lock");
>>> +
>>> +	sprintf(nfile, "/tmp/%s.lock", filename);
>>>   	lck.l_type = lock ? F_WRLCK : F_UNLCK;
>>>   	lck.l_whence = SEEK_SET;
>>>   	lck.l_start = 0;
>>>
>>
>>
>> --
>> Jaroslav Kysela <perex@perex.cz>
>> Linux Kernel Sound Maintainer
>> ALSA Project; Red Hat, Inc.
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
