From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 22/39] fireworks: Add proc interface for
	debugging purpose
Date: Tue, 04 Mar 2014 23:10:39 +0900
Message-ID: <5315DEDF.7030805@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-23-git-send-email-o-takashi@sakamocchi.jp>
 <s5h61nzn2wi.wl%tiwai@suse.de> <5311DE06.80105@sakamocchi.jp>
 <s5hppm3ac6e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id B6594265765
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 15:10:47 +0100 (CET)
In-Reply-To: <s5hppm3ac6e.wl%tiwai@suse.de>
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

(Mar 3 2014 18:01), Takashi Iwai wrote:
> You can use another prefix like "firewire-xxx", "firewire#xxx", etc,
> which can be better understood.  Or, create a proc subdirectory
> instead, and put all firewire-specific things there.

OK. I decide to add subdirectory named "firewire" and push these nodes 
to it.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
