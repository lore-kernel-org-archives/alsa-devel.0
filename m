From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: firewire-lib: allocate additional
 entries for list of packet descriptor to avoid out-of-bounds access
Date: Sun, 25 Aug 2019 17:41:29 +0900
Message-ID: <20190825084128.GA28851@workstation>
References: <20190825065247.26840-1-o-takashi@sakamocchi.jp>
 <s5hwof14sx1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E36DF80144
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2019 10:41:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwof14sx1.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

On Sun, Aug 25, 2019 at 09:15:38AM +0200, Takashi Iwai wrote:
> On Sun, 25 Aug 2019 08:52:47 +0200,
> Takashi Sakamoto wrote:
> > 
> > This patch is for Linux v5.3-rc7.
> 
> The patch doesn't seem cleanly applicable to for-linus branch (or
> 5.3-rc6).

Oops. Against the commit comment, I rebased this patch onto your 'for-next'
branch...

> Care to fix and resend?

Yes, but in this time would you please abandon this patch. With a bit
consideration after the posting, I concluded that there's another side of
the out-of-bounds bug. It comes from patchset for AMDTP domain which
I'm working for v5.4. I'd like to investigate and work further for the bug.


Thanks and sorry to bother your work.

Takashi Sakamoto
