From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH 1/2] ctl: deprecate APIs of
 dimension information
Date: Tue, 7 Nov 2017 09:34:02 +0900
Message-ID: <db4e937b-c31b-575f-69b6-ce3c627df35c@sakamocchi.jp>
References: <20171104022426.16230-1-o-takashi@sakamocchi.jp>
 <20171104022426.16230-2-o-takashi@sakamocchi.jp>
 <s5hy3nlxct7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 25858266DF5
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 01:34:08 +0100 (CET)
In-Reply-To: <s5hy3nlxct7.wl-tiwai@suse.de>
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

On Nov 05 2017 19:03, Takashi Iwai wrote:
> On Sat, 04 Nov 2017 03:24:25 +0100,
> Takashi Sakamoto wrote:
>>
>> In ALSA control interface of asound.h, 'struct snd_ctl_elem_info' has
>> 'dimen' member to deliver information for multi-dimensional array, however
>> there's no common way to handle the member. As a result, drivers can
>> force userspace applications to handle the information by inconsistent
>> ways.
> 
> Well, the text is slightly misleading.
> Actually the API itself wasn't bad and you can implement it
> consistently.

Hm.

I can assume that a series of echoaudio driver attempts to deliver 
information about elements in the same element via the 'dimen' member. 
This usage might not be so wrong.

The 'dimen' member is supplemental information. It has an effect to the 
way to parse any array relevant to control elements. Current ALSA 
control interface includes two types of the array; value array and 
element array in the same element set. This is a cause of this issue. 
The double nature of meaning of the member brings inconsistent handling 
of these arrays according to the value of 'dimen' member. Thus this is 
an issue of the interface.

If we had any document about usage of the member (e.g. just a few more 
words in asound.h), we would avoid this issue. We've failed to lead 
developers to a consistent usage of the interface.

> But practically seen, we haven't got *any* driver using
> the feature in the correct way for over decades.  The only user was
> echoaudio drivers but it was obviously wrong.  So, judging from the
> situation, keeping this doesn't make much sense -- that's the reason
> for dropping.

No objections for the above sentence just for our judgment of the removal.

>> This issue was reported by a commit 51db452df07b ('Revert "ALSA: echoaudio:
>> purge contradictions between dimension matrix members and total number of
>> members"') to Linux kernel. As a result of discussion at Linux
>> miniconference 2017, usage of 'dimen' member of 'struct snd_ctl_elem_info'
>> is going to be deprecated for future removal.
>>
>> This commit deprecates some APIs related to the dimension information. They
>> are planned to be removed in a development period for Linux kernel v4.21.
> 
> IMO, the version to deprecate the feature may depend on LTS kernel
> version.  4.21 looks OK, but we may shift it.

I still get no merit of your suggestion. Do you mean that the removal of 
ABI should be done in several releases before target LTS will be 
actually released, to produce stable ABI? If so, we need to estimate the 
timing of next LTS. However, it's hard because for recent LTS we got no 
official announcement from stable maintainers till LTS version of Linux 
kernel is actually released. At least, I won't work with such uncertain 
estimations.


Regards

Takashi Sakamoto
