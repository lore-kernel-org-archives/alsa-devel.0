From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 10/39] firewire-lib: Add transfer delay to
 synchronized duplex streams
Date: Sun, 09 Mar 2014 22:13:30 +0100
Message-ID: <531CD97A.6040507@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-11-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 35BE42655D2
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 22:14:10 +0100 (CET)
In-Reply-To: <1394016507-15761-11-git-send-email-o-takashi@sakamocchi.jp>
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
> Currently, in duplex streams with synchronization mode, this module just pass
> 'presentation timestamp' from in-packets to out-packets. This is enough to
> handle actual device but logically the timestamp should include
> 'transfer delay' and 'processing time'. This means the timestamp in out-packet
> should be at future.
>
> To be simple, this commit add only 'transfer delay'.

> +		*syt += (s->transfer_delay / TICKS_PER_CYCLE) << 12;
> +		*syt += s->transfer_delay % TICKS_PER_CYCLE;
> +		*syt &= CIP_SYT_MASK;

The transfer delay is the offset between the frame in which the packet
is transmitted and the intended presentation time.  This delay was
already added by the device when it sent the input packets, so we
don't need to send it again.

The frame in which the out-packet will be sent is QUEUE_LENGTH
frames later than that of the in-packet, so we need to adjust the
SYT by that amount.  (However, 48 % 16 == 0.)


Regards,
Clemens
