From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 31/37] ALSA: firewire-motu: add MOTU
 specific protocol layer
Date: Thu, 16 Jul 2015 01:10:23 +0900
Message-ID: <55A685EF.7090700@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
 <1436623968-10780-32-git-send-email-o-takashi@sakamocchi.jp>
 <20150712010515.GA30499@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D330265D8A
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 18:10:27 +0200 (CEST)
In-Reply-To: <20150712010515.GA30499@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Jonathan,

On JUl 12 2015 10:05, Jonathan Woithe wrote:
> Thanks for coding up a starting point of the MOTU firewire streaming
> driver.  I have been seriously short of time this year and have not had a
> chance to look at this yet.

Your comments, itself, is helpful for developing of MOTU driver, while
in this developing cycle, I focus on the other things.

The main theme of this patchset is to expand current streaming engine to
non-AMDTP protocols, with enough compatibility and reasonable overhead
for in-tree drivers. My intention to add under-developing MOTU driver is
to assist this intention, not for developing MOTU driver itself.

Therefore, in this developing cycle, I have little responses to comments
which doesn't relate to the theme, sorry.


Thanks

Takashi Sakamoto
