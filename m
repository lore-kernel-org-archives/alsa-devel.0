From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 19/39] fireworks: Add skelton for Fireworks
 based devices
Date: Sat, 01 Mar 2014 00:36:50 +0900
Message-ID: <5310AD12.9080503@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-20-git-send-email-o-takashi@sakamocchi.jp>
 <s5h7g8fn30m.wl%tiwai@suse.de> <5310A5C6.2060602@sakamocchi.jp>
 <s5hfvn3b7d1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 762C02652B7
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 16:36:54 +0100 (CET)
In-Reply-To: <s5hfvn3b7d1.wl%tiwai@suse.de>
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

(Mar 01 2014 00:10), Takashi Iwai wrote:
> Just take a look at linux/bitmap.h :)

OK. Now I get what you mean.

I seek some examples under /sound but there are no drivers which uses 
bitmap functions for this purpose. I guess we probably need further work 
for this, to prevent from buffer over run under CONFIG_SND_MAX_CARDS > 32.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
