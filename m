From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 05/39] firewire-lib: Add support for AMDTP
 in-stream and PCM capture
Date: Wed, 12 Mar 2014 11:00:04 +0900
Message-ID: <531FBFA4.2040106@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-6-git-send-email-o-takashi@sakamocchi.jp>
 <531CD0FA.9090506@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id D94A4261ADB
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 03:00:09 +0100 (CET)
In-Reply-To: <531CD0FA.9090506@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

(Mar 10 2014 05:37), Clemens Ladisch wrote:
> In practice, this error means that a packet was dropped.  I guess this
> doesn't actually happen too often, but eventually, we should handle
> this either by inserting some samples or by stopping the stream.

For inserting some samples, I realize that there are some difficulties:
  - In non-blocking mode, assuming the number of PCM samples in dropped 
packets is difficult because specification just define '0 <= N <= 
SYT_INTERVAL' (N = the number of events in packet). Each device can have 
different sequence of N in packets.
  - In blocking mode, assuming the value of syt in dropped packets is 
difficult because it's related to timing.

So I give up to think about recovering from dropped packets and make 
firewire-lib stops streaming when detecting this state.

But this is not better for BeBoB based devices as I mentioned in 
previous message. So I'll add some flags and codes for BeBoB.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
