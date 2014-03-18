From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] pcm: route: Don't handle no matching chmap
 as a serious error
Date: Tue, 18 Mar 2014 23:13:02 +0100
Message-ID: <5328C4EE.4010807@canonical.com>
References: <1395152876-28480-1-git-send-email-tiwai@suse.de>	<53287211.1040803@canonical.com>
 <s5h1txzpisl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040201000709000607070303"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 152B1261B20
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 23:13:03 +0100 (CET)
In-Reply-To: <s5h1txzpisl.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------040201000709000607070303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 03/18/2014 05:34 PM, Takashi Iwai wrote:
> At Tue, 18 Mar 2014 17:19:29 +0100,
> David Henningsson wrote:
>>
>> On 03/18/2014 03:27 PM, Takashi Iwai wrote:
>>> When find_matching_chmap() returns an error for the non-matching
>>> chmap, the caller, snd_pcm_route_open(), also returns an error
>>> although it shouldn't be handled as the fatal error.  This results in
>>> the probe error with PulseAudio and it gives no real output in the
>>> end.
>>
>> Hmm, could you give a more specific example? In case the driver does not
>> support channel maps at all, that case is handled in the beginning of
>> the function.
> 
> Well, the problem is that PulseAudio doesn't work at all with the
> current alsa-lib git prior to the commit in some cases.  That is, the
> commit brought some incompatibility.

Hmm, then the error should be somewhere in determine_chmap instead.
tt_chmap should be NULL (i e, find_matching_chmap is never called) for
using the standard number syntax instead of the new chmap syntax.

What about the patch attached instead (untested) ?

>> So this only happens if the driver supports channel maps, but only
>> non-compatible with the requested map. In which case I believe it's
>> correct that the probing should fail...?
> 
> Could you check whether PA 5.0 works as is with alsa-lib git (before
> the last fix)?  It could be seen on some desktop machines.

Let me know if the attached patch works for you. In case it does not I
will do this testing later.

> 
> 
> Takashi
> 
>>
>>>
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>>  src/pcm/pcm_route.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
>>> index ab17fa78be2c..ac11bdc8adfd 100644
>>> --- a/src/pcm/pcm_route.c
>>> +++ b/src/pcm/pcm_route.c
>>> @@ -940,10 +940,8 @@ static int find_matching_chmap(snd_pcm_t *spcm, snd_pcm_chmap_t *tt_chmap,
>>>  
>>>  	snd_pcm_free_chmaps(chmaps);
>>>  
>>> -	if (*found_chmap == NULL) {
>>> +	if (*found_chmap == NULL)
>>>  		SNDERR("Found no matching channel map");
>>> -		return -EINVAL;
>>> -	}
>>>  	return 0;
>>>  }
>>>  
>>>
>>
>>
>>
>> -- 
>> David Henningsson, Canonical Ltd.
>> https://launchpad.net/~diwic
>>
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------040201000709000607070303
Content-Type: text/x-patch;
 name="0001-route-Return-NULL-in-case-of-zero-found-channels-in-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-route-Return-NULL-in-case-of-zero-found-channels-in-.pa";
 filename*1="tch"

>From 746358818ead057a32330f7c8510cb65a7059e86 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 18 Mar 2014 23:07:19 +0100
Subject: [PATCH] route: Return NULL in case of zero found channels in
 determine_chmap

This should fix the problem where the old route syntax can no longer
be opened.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/pcm/pcm_route.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index ac11bdc..a9097ca 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -883,7 +883,10 @@ static int determine_chmap(snd_config_t *tt, snd_pcm_chmap_t **tt_chmap)
 		}
 	}
 
-
+	if (chmap->channels == 0) {
+		free(chmap);
+		chmap = NULL;
+	}
 	*tt_chmap = chmap;
 	return 0;
 
-- 
1.7.9.5


--------------040201000709000607070303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040201000709000607070303--
