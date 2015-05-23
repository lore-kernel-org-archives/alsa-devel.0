From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/4] ALSA: firewire-lib: use dev_err()
 when	detecting incoming streaming error
Date: Sat, 23 May 2015 13:16:37 +0900
Message-ID: <555FFF25.5030602@sakamocchi.jp>
References: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
 <1432304474-6533-4-git-send-email-o-takashi@sakamocchi.jp>
 <555F6FD6.8090809@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 648872604BE
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 06:16:40 +0200 (CEST)
In-Reply-To: <555F6FD6.8090809@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On May 23 2015 00:08, Takashi Iwai wrote:
> Here you dropped _ratelimited().  Are you sure that it won't give any
> problem?

Similar situation as we discussed before:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-May/092192.html


On May 23 2015 03:05, Clemens Ladisch wrote:
> An aborted stream ends up in the XRUN state; the application is likely
> to prepare and start the stream again.  So it is likely that there
> will be message flooding.

Considering about how frequently this message can be generated at
receiving such problematic packets, Not so flooding.

In the situation, all of committed drivers (fireworks/bebob/oxfw/dice)
stops isochronous contexts and actual streams once, then start new
streams and isochronous contexts. This is because our old packet stream
falls to error state. Therefore, when devices transfers such problematic
packets, different isochronous contexts (old one and new one) generate
the error messages. This means that there're a gap between the generated
error messages, approximately several hundred seconds because it cost
expensive for devices to restart isochronous streams. In my opinion,
this is not such flooding.


Regards

Takashi Sakamoto
