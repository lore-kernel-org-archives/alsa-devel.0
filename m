From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 11/39] firewire-lib: Add support for
	channel mapping
Date: Wed, 12 Mar 2014 01:03:13 +0900
Message-ID: <531F33C1.90200@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-12-git-send-email-o-takashi@sakamocchi.jp>
 <531CDB2A.8020304@ladisch.de> <531DB002.9030801@sakamocchi.jp>
 <531EC7F7.7030405@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 73511261AB7
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 17:03:22 +0100 (CET)
In-Reply-To: <531EC7F7.7030405@ladisch.de>
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

(Mar 11 2014 17:23), Clemens Ladisch wrote:
> In code like this:
>
>          for (... s->channels ...)
>              buffer[i] = ...;
>
> it is, as far as the compiler knows, possible that &buffer[i] and
> &s->channels actually point to the same variable, so s->channels must
> be reloaded in every loop iteration.  A local variable avoids that.
>
> (Whether this optimization is worth it is another question ...)

As long as I test with simple codes and gcc, this optimization reduce 
one opcode in a loop. Codes with your way compares address content to a 
register, but codes with my way once push address content to another 
register and compare the two registers.

The read/write functions are called the most freqently, so shorter codes 
are preferable. I realize I should keep it what you wrote. Thanks for 
your indication.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
