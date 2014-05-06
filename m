From: Julian Scheel <julian@jusst.de>
Subject: Re: [PATCH] alsactl: Store lockfile in /tmp
Date: Tue, 06 May 2014 17:00:47 +0200
Message-ID: <5368F91F.50901@jusst.de>
References: <1399377427-23907-1-git-send-email-julian@jusst.de>
 <5368F74C.1020907@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.work.de (smtp1.work.de [212.12.40.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 011F7261A22
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 17:00:48 +0200 (CEST)
Received: from [91.60.47.242] (helo=[172.20.32.187])
 by smtp1.work.de with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.72) (envelope-from <julian@jusst.de>) id 1WhgrP-0007P3-Dm
 for alsa-devel@alsa-project.org; Tue, 06 May 2014 17:00:47 +0200
In-Reply-To: <5368F74C.1020907@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06.05.2014 16:53, Jaroslav Kysela wrote:
> Date 6.5.2014 13:57, Julian Scheel wrote:
>> It can not be generally assumed that the directories in which asound.state
>> resides are writable. Instead using /tmp as location for lock files seems more
>> reliable.
> Apart the missing free for the mallocated string and ommiting the TMPDIR
> environment variable, I think that the right directory for global locks
> is /var/lock . The default asound.state directory is now /var/lib/alsa -
> I don't see the benefit.

The patch does not allocate anything that was not allocated before.
nfile was allocated before and is freed a few lines after the patch 
content. filename is just a pointer, not a newly allocated buffer.
Using /var/lock instead of /tmp sounds sane, yes.

> What's the reason for this change? Perhaps using an environmental
> variable to override the lock path may be more appropriate for a custom
> directory structure.

We're running alsactl restore on startup of an embedded system which 
uses a read-only rootfs. So it can't create the lockfile in the default 
place and hence will not restore anything.

-Julian

>                                     Jaroslav
>
>>
>> Signed-off-by: Julian Scheel <julian@jusst.de>
>> ---
>>   alsactl/lock.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/alsactl/lock.c b/alsactl/lock.c
>> index 587a109..7ca3a09 100644
>> --- a/alsactl/lock.c
>> +++ b/alsactl/lock.c
>> @@ -36,17 +36,24 @@ static int state_lock_(const char *file, int lock, int timeout)
>>   	struct flock lck;
>>   	struct stat st;
>>   	char lcktxt[12];
>> +	char *filename;
>>   	char *nfile;
>>
>>   	if (!do_lock)
>>   		return 0;
>> -	nfile = malloc(strlen(file) + 6);
>> +
>> +	/* only use the actual filename, not the path */
>> +	filename = strrchr(file, '/');
>> +	if (!filename)
>> +		filename = file;
>> +
>> +	nfile = malloc(strlen(filename) + 10);
>>   	if (nfile == NULL) {
>>   		error("No enough memory...");
>>   		return -ENOMEM;
>>   	}
>> -	strcpy(nfile, file);
>> -	strcat(nfile, ".lock");
>> +
>> +	sprintf(nfile, "/tmp/%s.lock", filename);
>>   	lck.l_type = lock ? F_WRLCK : F_UNLCK;
>>   	lck.l_whence = SEEK_SET;
>>   	lck.l_start = 0;
>>
>
>
