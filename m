From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 17/39] firewire-lib: Add quirks for
	Fireworks
Date: Sun, 09 Mar 2014 22:39:16 +0100
Message-ID: <531CDF84.3000503@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-18-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 43FB2262610
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 22:39:54 +0100 (CET)
In-Reply-To: <1394016507-15761-18-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> This commit adds three modifications for Echo Audio's Fireworks quirks.
> ...
> 2.Making this module to calculate data block size and not to check continuity
> One of Fireworks device, AudioFirePre8, always reports 8 data block size in
> in-packets and the data block counter is incremented by 8. But actual value is
> different.

Does this really make it impossible to check DBC?

> 3.Making this module to have the numebr of first data blocks for MIDI messages
> in out-packet
> Fireworks can pick up MIDI messages in first 8 data blocks and ignore in other
> data blocks.

Can this ever make the MIDI rate less than 3125 bytes per second?  If not,
then we can simply apply this quirk to all devices.

(Which reminds me: we must ensure that the rate never exceeds 3125 bytes/s;
most other devices have a smaller buffer than Fireworks devices, and even
those will eventually overflow.)


Regards,
Clemens
