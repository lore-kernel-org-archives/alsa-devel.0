From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC PATCH] alsactl: Do not run udev rule before
	datadir is mounted
Date: Fri, 13 Jun 2014 11:11:28 +0200
Message-ID: <539AC040.6040308@perex.cz>
References: <1402647348-25604-1-git-send-email-david.henningsson@canonical.com>
 <539AB5C7.6020501@perex.cz> <539ABEF0.7020508@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 647862618F2
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 11:11:29 +0200 (CEST)
In-Reply-To: <539ABEF0.7020508@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1289730@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

Date 13.6.2014 11:05, David Henningsson wrote:
> 
> 
> On 2014-06-13 10:26, Jaroslav Kysela wrote:
>> Date 13.6.2014 10:15, David Henningsson wrote:
>>> The 90-alsa-restore.rules udev rule is primarily meant to handle hotplugging,
>>> but sometimes it is also run before /usr is mounted,
>>> and alsactl restore depends on /usr/share/alsa being present.
>>>
>>> If /usr/share/alsa is not present, we're so early in the boot
>>> process that alsa-restore.service (or upstart equivalent) will
>>> run later on.
>>>
>>> BugLink: https://bugs.launchpad.net/bugs/1289730
>>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>>> ---
>>>
>>> I'm not really sure of all quirks in the boot process, and I haven't tested the
>>> patch either, hence the RFC above. Do you think it makes sense?
>>
>> Yes, I think that's ok. Takashi?
>>
>>> Should we also add @sbindir@ to the things to test for?
>>
>> It shouldn't harm anything. Could you prepare a new patch?
> 
> Sure, please find it attached. I was also considering adding something 
> under /var as well, but I didn't do that, because I think it will fall 
> back to an "alsactl init" in that case (right?), so it still makes some 
> sense to run alsactl without /var.

Yes, /var contents is not mandatory. Thanks, I applied it to the
alsa-utils repository.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
