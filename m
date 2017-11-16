From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH 0/2] ALSA: nm256: Fine-tuning for three
 function implementations
Date: Thu, 16 Nov 2017 18:48:43 +0100
Message-ID: <dfa99045-f213-3dad-b1f4-2e90eb38ddbd@users.sourceforge.net>
References: <d98a2685-ddf9-1cba-839a-d12c5ff8d3ba@users.sourceforge.net>
 <s5hefoy16xg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DF33266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 18:48:50 +0100 (CET)
In-Reply-To: <s5hefoy16xg.wl-tiwai@suse.de>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

>> Two update suggestions were taken into account
>> from static source code analysis.
> 
> Markus, I'd apply this kind of patches only when they are really
> tested on the hardware,

I can not test all software and hardware combinations (so far)
for which I dare to show change possibilities.


> or they were converted systematically by a script like spatch.

There is a general source code transformation pattern involved.
So I find that it is systematic.

But I did not dare to develop a script variant for the semantic patch
language (Coccinelle software) which can handle all special use cases
as a few of them are already demonstrated in this tiny patch series.


> The reason is that you might break something

There are the usual software development risks.


> (and you already broke things in the past).

I presented also some improvable update suggestions.

Another look on the corresponding circumstances might be interesting
for further clarification.


> The merit by such a patch is negligible in comparison of the risk of breakage.

I imagine that you might like a small object code reduction also for
this software module.


> These codes aren't too bad without fixing, after all;
> everyone can read it pretty well as is.

The script "checkpatch.pl" points implementation details out for
further considerations.


> If these patches were tested on a real hardware,

I assume that this aspect can become a big challenge.


> or at least on VM, so that you can show that they don't break anything,

Which test results would you trust (from me)?


> I'll happily apply them for the next (4.16) kernel.

Thanks for your general offer.


> Or, if you're really working on other real changes

I would find a bit more efficient exception handling useful.


> (no cosmetic coding style fixes nor the code shuffling,

I propose to apply also corresponding checkpatch cosmetic.


> but fixing a real bug)

I am trying to adjust the software situation a bit more for better
run time characteristics.


> *and* such a cleanup is mandatory as preliminary, it can be accepted, too.

There are change combinations needed for the proposed software
design direction.
Can you see positive effects here?

Regards,
Markus
