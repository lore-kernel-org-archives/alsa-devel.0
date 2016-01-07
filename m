From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/4 v5] ALSA: dice: improve card
	registration processing
Date: Thu, 7 Jan 2016 09:21:44 +0900
Message-ID: <568DAF98.4020504@sakamocchi.jp>
References: <1451537894-28366-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hlh83rrok.wl-tiwai@suse.de> <568CF159.80202@sakamocchi.jp>
 <s5hfuyasvu7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 63E512654F2
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2016 01:21:50 +0100 (CET)
In-Reply-To: <s5hfuyasvu7.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jan 6 2016 22:04, Takashi Iwai wrote:
>> How about the rest of my work for ALSA Dice driver to Linux 4.5?
>>
>> [alsa-devel] [RFC][PATCH 00/10 v2] ALSA: dice: stabiliza packet streaming
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/101897.html
>>
>> It takes almost one month since I posted the RFCv2. We already had a
>> discussion about the patchset in RFCv1 and in my opinion there's no
>> thorough disagreement. If possible, I'd like to merge it in the merge
>> window for Linux 4.5. If we go for it, I'll post them in this night.
> 
> Well, RFC is RFC and not for merging.  If it's meant for merging,
> let's poke relevant people whether it's OK.

Indeed for merging process.

However, in my opinion, RFC is one of ways to show directions for future
works and establish _loose_ agreement among active developers. In terms
of it, I think it's time to put the patchset to the review process for
merging.

But it seems to be a bit late for 4.5. I'll postpone them to next
developing cycle for 4.6.


For 4.5, I'll finish all of my work, and I currently plan for 4.6:
 * Limit PCM substreams to current sampling transfer frequency for Dice
driver
 * Replace tasklet with workqueue for scs1x functionality of OXFW driver.
 * Some works in userspace, mainly libhinawa and hinawa-utils
 * Development of firewire-transceiver module for testing streaming
engine of firewire-lib.


Regards

Takashi Sakamoto
