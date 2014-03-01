From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 26/39] fireworks: Add command/response
 functionality into hwdep interface
Date: Sat, 01 Mar 2014 22:18:57 +0900
Message-ID: <5311DE41.6030801@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-27-git-send-email-o-takashi@sakamocchi.jp>
 <s5h4n3jn2p3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 1945D265327
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 14:19:03 +0100 (CET)
In-Reply-To: <s5h4n3jn2p3.wl%tiwai@suse.de>
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

Iwai-san,

(Feb 28 2014 15:58), Takashi Iwai wrote:
> Better to have a sanity check of resp_buf_size value.  You can't trust
> a value given by a user.

Exactly. I add codes with clamp() to check it.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
