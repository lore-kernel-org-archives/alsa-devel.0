From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 10/39] firewire-lib: Add transfer delay to
 synchronized duplex streams
Date: Mon, 10 Mar 2014 22:43:26 +0900
Message-ID: <531DC17E.7020400@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-11-git-send-email-o-takashi@sakamocchi.jp>
 <531CD97A.6040507@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 683DC2650EE
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 14:43:32 +0100 (CET)
In-Reply-To: <531CD97A.6040507@ladisch.de>
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

(mar 10 2014 06:13), Clemens Ladisch wrote:
> The transfer delay is the offset between the frame in which the packet
> is transmitted and the intended presentation time.  This delay was
> already added by the device when it sent the input packets, so we
> don't need to send it again.

Exactly. Adding TRANSFER_DELAY for out-packets is needless...

IEC 61883-6 said:
"If a function block receives a CIP, processes it and subsequently 
re-transmits it, then the SYT of the outgoing CIP shall be the sum of 
the incoming SYT and the processing delay."

> The frame in which the out-packet will be sent is QUEUE_LENGTH
> frames later than that of the in-packet, so we need to adjust the
> SYT by that amount.  (However, 48 % 16 == 0.)

So basically we need to add nothing to SYT for out-packet.
This patch should be removed.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
