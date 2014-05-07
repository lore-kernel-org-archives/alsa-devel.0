From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v2] alsactl: Store lockfile in /tmp
Date: Wed, 07 May 2014 11:23:40 +0200
Message-ID: <5369FB9C.2010602@perex.cz>
References: <1399404739-1007-1-git-send-email-julian@jusst.de>
 <s5h4n12qcnc.wl%tiwai@suse.de> <5369F3B7.60105@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AAC12652CC
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 11:23:40 +0200 (CEST)
In-Reply-To: <5369F3B7.60105@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 7.5.2014 10:49, Julian Scheel wrote:
> Am 07.05.2014 09:19, schrieb Takashi Iwai:
>> At Tue,  6 May 2014 21:32:19 +0200,
>> Julian Scheel wrote:
>>>
>>> It can not be generally assumed that the directories in which asound.state
>>> resides are writable. Instead using /tmp as location for lock files seems more
>>> reliable.
>>
>> The subject and changelog don't match with the actual change.
>> Now it's /var/log instead of /tmp, right?
> 
> Sorry for that. Must have been too late.

I also didn't note that. I applied your v2 patch to the git repo - I
forced update now.

>> Besides that, it'd be better to allow a full path name for a lock file
>> instead of a directory name.  If you give a different file name via -f
>> option, you have a high chance to conflict with the existing file in
>> /var/lock.
> 
> So, you'd prefer a --lock-file/-L option which can be used to set an 
> explicit lock file?

I changed '-D' to '-O' option (file) and used '-L' option to select the
"no-lock" behaviour for the global configuration file. Note that the
locking is default only for the global file, other files are not lock
protected.

http://git.alsa-project.org/?p=alsa-utils.git;a=commitdiff;h=158a67f6f5058bec0ac27086a1c6206bfd2ff414

>> Furthermore, for solving *your* problem (restoring from read-only
>> rootfs), an easier option would be allowing to restore the system
>> default without locking.
> 
> While this is true I think making the locking mechanism more robust is a 
> good thing anyway.

Yup.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
