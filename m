From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH 1/2] ctl: deprecate APIs of
 dimension information
Date: Wed, 8 Nov 2017 07:36:28 +0900
Message-ID: <8da317ee-ed5b-2e8a-4842-55a364dc01f4@sakamocchi.jp>
References: <20171104022426.16230-1-o-takashi@sakamocchi.jp>
 <20171104022426.16230-2-o-takashi@sakamocchi.jp>
 <s5hy3nlxct7.wl-tiwai@suse.de>
 <db4e937b-c31b-575f-69b6-ce3c627df35c@sakamocchi.jp>
 <s5hzi7ywmch.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 56473267232
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 23:36:31 +0100 (CET)
In-Reply-To: <s5hzi7ywmch.wl-tiwai@suse.de>
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

On Nov 7 2017 16:59, Takashi Iwai wrote:
> On Tue, 07 Nov 2017 01:34:02 +0100,
> Takashi Sakamoto wrote:
>>
>>>> This commit deprecates some APIs related to the dimension information. They
>>>> are planned to be removed in a development period for Linux kernel v4.21.
>>>
>>> IMO, the version to deprecate the feature may depend on LTS kernel
>>> version.  4.21 looks OK, but we may shift it.
>>
>> I still get no merit of your suggestion. Do you mean that the removal
>> of ABI should be done in several releases before target LTS will be
>> actually released, to produce stable ABI? If so, we need to estimate
>> the timing of next LTS. However, it's hard because for recent LTS we
>> got no official announcement from stable maintainers till LTS version
>> of Linux kernel is actually released. At least, I won't work with such
>> uncertain estimations.
> 
> The feature removal isn't what we can guarantee at a certain kernel
> version.  As long as we have a real (not theoretical) user, it
> shouldn't be dropped.  It's still unwritten "no regression" rule.
> 
> That said, we may announce and prepare / plan the deprecation, but we
> can't define the exact kernel version in general.  And considering LTS
> release is one of the decision factors.

If it comes from a general theory, I'm willing to follow it.

But in this case, we can be optimistic. As you know, the minor feature 
is just used in drivers/software related to models produced by Echo 
Digital Audio corp. The other probability is usage by user-defined 
control element set on any userspace application. As my recent work 
declared, this feature has been long-abandoned and no application exists 
(if such application exists, developers have already found such bugs 
which I've fixed recently before I worked...).

If the feature were used by majority, it would be more difficult to 
deprecate/remove it, and we need to be deliberate. Depending on cases, 
deprecation is impossible itself. But this feature is quite minor and 
got little popularity. Practically, we can safely remove the minor 
feature in any timing after modified version of echoaudio stuffs are 
disseminated. My proposed schedule takes 6 kernel releases for it. In 
the schedule, v4.21 release is the deadline of the feature, but if you'd 
like to keep the deadline undecided for such theory/rule, I have no 
objection to it. To me, deprecation of this feature for future removal 
is more important to avoid developers' misuses to which I addressed, 
than actual removal.

[1] 
https://github.com/takaswie/presentations/blob/master/20171027/contents.md


Regards

Takashi Sakamoto
