From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/2][RFC] ALSA: core: optimizations for
	creating new controls
Date: Sat, 07 Mar 2015 13:57:22 +0900
Message-ID: <54FA8532.70909@sakamocchi.jp>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>	<1425570206-21026-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hfv9j5tcp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id D561E26055F
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 05:57:28 +0100 (CET)
In-Reply-To: <s5hfv9j5tcp.wl-tiwai@suse.de>
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

On Mar 6 2015 00:58, Takashi Iwai wrote:
> At Fri,  6 Mar 2015 00:43:24 +0900,
> Takashi Sakamoto wrote:
>>
>> This patchset is for reducing executing time and stack usage at creating
>> new control instances. Nothing fixes.
>>
>> Takashi Sakamoto (2):
>>   ALSA: core: use precomputed table to check userspace control params
>>   ALSA: core: reduce stack usage related to snd_ctl_new()
> 
> Both look good, but just minor nitpicking: could you remove
> superfluous parentheses in cases like below?
> 
> 	if ((a > 0) && (b < 0)) ...
> 
> Most people are no lispers.

Hm. I may be an alien with several eyes and an additional hand in my
nose, when programming conservatively ;)

OK. In next patchset, I'll remove such parentheses, as much as possible.


Thanks

Takashi Sakamoto
