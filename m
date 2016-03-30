From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/2] ALSA: bebob/fireworks: remove module
 parameters to reduce maintenance work
Date: Wed, 30 Mar 2016 21:52:31 +0900
Message-ID: <56FBCC0F.40200@sakamocchi.jp>
References: <1459257735-13596-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hshz92y41.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 83C96266A1A
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 14:52:40 +0200 (CEST)
In-Reply-To: <s5hshz92y41.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 29 2016 22:49, Takashi Iwai wrote:
> On Tue, 29 Mar 2016 15:22:13 +0200,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> This patchset removes some module parameters from ALSA bebob and fireworks
>> driver.
>>
>> These two modules have three parameters for users to assign preferable
>> number and strings to a sound card as some modules in ALSA kernel land.
>> However, they're not used so widely, and practically I suspect their
>> advantages.
>>
>> To simplify and unify the shape of modules in ALSA firewire stack, I'd
>> like to remove them.
>
> Well, "it simplifies the code" alone doesn't justify the removal of
> these long-time existing parameters.  You can't know how it's been
> used only from the narrow range surveys.  These are mostly workarounds
> for some special setups, so they don't hit usually.
>
> The usefulness of these parameters is another question, though.
> They are far from perfect, and have logic flaws.  They are present,
> however, mostly for consistency and historical reasons.
> (In some cases it's useful, e.g. a device gives some id string you
>   don't want to spell.  The parameter allows you to rename it.
>   Or, in most cases, the index is used for reserving the first slot to
>   onboard chip for some legacy apps.)
>
> So, the question is how much benefit we can get by this action.  Is
> this small piece of code really so much burden to maintain?  If yes,
> I'd like to hear it at first.  If not, we should evaluate the risk of
> possible breakage as the first priority.

At least, to me. When purging these codes, I do never bother anymore the 
unpractical parameters and the differences of shape between drivers in 
ALSA firewire stack. It's good that I have no need to explain how these 
parameters works and when they don't works as expected.

Actually, ALSA firewire stack is not attractive for most of users and 
developers. It's preferable to keep the amount of codes in the stack as 
small as possible because I can't expect to gain dedicated testers and 
developers. In short, I hope to keep the codes within my capacity and 
exclude the confusion.

If it was as major as HDA, or it had impact to actual market as ASoC, I 
would use the other logic and strategy for software. But in fact, it's not.

I understand what you say. It's within my expectation. However, I hope.


Regards

>>
>> Takashi Sakamoto (2):
>>    ALSA: bebob: remove module parameters to reduce maintenance work
>>    ALSA: fireworks: remove module parameters to reduce maintenance work
>>
>>   sound/firewire/bebob/bebob.c         | 49 +++++-------------------------------
>>   sound/firewire/bebob/bebob.h         |  1 -
>>   sound/firewire/fireworks/fireworks.c | 43 +++----------------------------
>>   sound/firewire/fireworks/fireworks.h |  1 -
>>   4 files changed, 10 insertions(+), 84 deletions(-)
>>
>> --
>> 2.7.3
>>
