From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 09/39] firewire-lib: Add sort function for
 transmitted packet
Date: Sun, 09 Mar 2014 22:07:05 +0100
Message-ID: <531CD7F9.1000303@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-10-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 74AD82655D2
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 22:07:45 +0100 (CET)
In-Reply-To: <1394016507-15761-10-git-send-email-o-takashi@sakamocchi.jp>
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
> This commit is to assure the continuity of timestamp in in-packets
> transmitted by devices.
>
> Fireworks with firmware version 5.5 or former is a type of device which
> transmits packets with a bit disorder.

Then this should be done only when we actually have one of these known
devices (and only when this error is known to happen, i.e., directly
after a no-data packet); otherwise, this could, in theory, interfere with
dropped packets.

> This commit add sorting of in-packets. When callback of receive-context
> is processed, the parameters of in-packets are stored in sort table and
> sorted by its value of data block counter. The sort algorism works faster
> in ordered sequence than in messy sequence. This is convinient for this
> purpose because the sequence is assumed not to be so messy. After sorting,
> packets are processed except for a last few packets in sort table. These
> packets are stored in buffer once and used in next cycle.

Only a single packet is out of order, i.e., only two packets are exchanged.
So it is not necessary to run a general-purpose sorting algorithm; it would
be sufficient to store a single packet if it is out of order.

> +	if (s->sort_table != NULL)
> +		kfree(s->sort_table);

A NULL check is not necessary for kfree().


Regards,
Clemens
