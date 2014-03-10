From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 11/39] firewire-lib: Add support for
	channel mapping
Date: Mon, 10 Mar 2014 21:28:50 +0900
Message-ID: <531DB002.9030801@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-12-git-send-email-o-takashi@sakamocchi.jp>
 <531CDB2A.8020304@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 469FA2656E0
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 13:28:56 +0100 (CET)
In-Reply-To: <531CDB2A.8020304@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

(Mar 10 2014 06:20), Clemens Ladisch wrote:
> This change is not necessary.  I used a separate local variable
> deliberately to allow the compiler to recognize that it cannot be
> aliased with the buffer contents.

I cannot understand your intention.

> AFAICS the dual-wire format could be handled easier by setting pcm_positions[]
> in the dice driver.

Currently I have no interests of dice driver.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
