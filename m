From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsactl: Store lockfile in /tmp
Date: Tue, 06 May 2014 16:55:43 +0200
Message-ID: <5368F7EF.1020300@perex.cz>
References: <1399377427-23907-1-git-send-email-julian@jusst.de>
 <5368F74C.1020907@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id F1A2A261A22
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 16:55:43 +0200 (CEST)
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
To: Julian Scheel <julian@jusst.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 6.5.2014 16:53, Jaroslav Kysela wrote:
> Date 6.5.2014 13:57, Julian Scheel wrote:
>> It can not be generally assumed that the directories in which asound.state
>> resides are writable. Instead using /tmp as location for lock files seems more
>> reliable.
> 
> Apart the missing free for the mallocated string and ommiting the TMPDIR

I'm sorry, the filename variable is not mallocated, forget this part,
please.

> environment variable, I think that the right directory for global locks
> is /var/lock . The default asound.state directory is now /var/lib/alsa -
> I don't see the benefit.
> 
> What's the reason for this change? Perhaps using an environmental
> variable to override the lock path may be more appropriate for a custom
> directory structure.
> 
>                                    Jaroslav
> 
>>
>> Signed-off-by: Julian Scheel <julian@jusst.de>
>> ---
>>  alsactl/lock.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/alsactl/lock.c b/alsactl/lock.c
>> index 587a109..7ca3a09 100644
>> --- a/alsactl/lock.c
>> +++ b/alsactl/lock.c
>> @@ -36,17 +36,24 @@ static int state_lock_(const char *file, int lock, int timeout)
>>  	struct flock lck;
>>  	struct stat st;
>>  	char lcktxt[12];
>> +	char *filename;
>>  	char *nfile;
>>  
>>  	if (!do_lock)
>>  		return 0;
>> -	nfile = malloc(strlen(file) + 6);
>> +
>> +	/* only use the actual filename, not the path */
>> +	filename = strrchr(file, '/');
>> +	if (!filename)
>> +		filename = file;
>> +
>> +	nfile = malloc(strlen(filename) + 10);
>>  	if (nfile == NULL) {
>>  		error("No enough memory...");
>>  		return -ENOMEM;
>>  	}
>> -	strcpy(nfile, file);
>> -	strcat(nfile, ".lock");
>> +
>> +	sprintf(nfile, "/tmp/%s.lock", filename);
>>  	lck.l_type = lock ? F_WRLCK : F_UNLCK;
>>  	lck.l_whence = SEEK_SET;
>>  	lck.l_start = 0;
>>
> 
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
