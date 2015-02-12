From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/8] ALSA: control: refactoring core codes
Date: Thu, 12 Feb 2015 21:38:35 +0900
Message-ID: <54DC9ECB.8030903@sakamocchi.jp>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hvbj8oaan.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id A4A542604ED
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 13:38:41 +0100 (CET)
In-Reply-To: <s5hvbj8oaan.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Feb 11 2015 22:19, Takashi Iwai wrote:
> At Wed, 11 Feb 2015 19:37:24 +0900,
> Takashi Sakamoto wrote:
>>
>> This patchset is for refactoring core control codes. This is also a
>> preparation for my further work for ALSA control functionality.
> 
> As now is already after the 3.20 merge window open, basically I'd take
> only fix patches now and postpone the rest for 3.21.

I'm posting them for 3.21, not for current 3.20. I should add some
comments about this, sorry to trouble you.

> So, please pick up (and revise) the fix patches that are really worth
> for 3.20 and resubmit them.  Submit the rest as another patchset to be 
> distinguished from the former.

Nothing for 3.20. I'll wait for closing the merge window, then post the
revised patches, but hope to continue discussion.


Regards

Takashi Sakamoto

>> Takashi Sakamoto (8):
>>   ALSA: control: change type from long due to the definition of sizeof
>>     operator
>>   ALSA: control: obsolete switch statement with const value table
>>   ALSA: control: gathering evaluations to access
>>   ALSA: control: add a comment about locking values after creating
>>   ALSA: control: rename loop index to i
>>   ALSA: control: fix over 80 characters lines
>>   ALSA: control: rename to appropriate macro name
>>   ALSA: control: arrange snd_ctl_new() as a local function
>>
>>  sound/core/control.c | 223 ++++++++++++++++++++++++++-------------------------
>>  1 file changed, 113 insertions(+), 110 deletions(-)
>>
>> -- 
>> 2.1.0
