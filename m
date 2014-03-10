From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 17/39] firewire-lib: Add quirks for
	Fireworks
Date: Mon, 10 Mar 2014 21:40:17 +0900
Message-ID: <531DB2B1.9040609@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-18-git-send-email-o-takashi@sakamocchi.jp>
 <531CDF84.3000503@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 32BA72656D0
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 13:40:21 +0100 (CET)
In-Reply-To: <531CDF84.3000503@ladisch.de>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

(Mar 10 2014 06:39), Clemens Ladisch wrote:
> Does this really make it impossible to check DBC?

Just with this quirk, I cannot disable this checking.
I should have described BeBoB quirks here.

> Can this ever make the MIDI rate less than 3125 bytes per second?  If not,
> then we can simply apply this quirk to all devices.

I note that this quirk does not relate to MIDI rate.

Fireworks just ignores MIDI messages in more data blocks than 8 even if 
MIDI rate is enough low.

> (Which reminds me: we must ensure that the rate never exceeds 3125 bytes/s;
> most other devices have a smaller buffer than Fireworks devices, and even
> those will eventually overflow.)

It's another issue, not for fireworks. It should be discussed in the 
other opportunities.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
