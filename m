From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 39/39] bebob: Add support for M-Audio
 special Firewire series
Date: Sat, 01 Mar 2014 22:06:53 +0900
Message-ID: <5311DB6D.3020703@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-40-git-send-email-o-takashi@sakamocchi.jp>
 <20140301115340.589ab770@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 75054265327
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 14:06:59 +0100 (CET)
In-Reply-To: <20140301115340.589ab770@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Stefan,

(Mar 01 2014 19:53), Stefan Richter wrote:
> We could add a workaround in drivers/firewire/core-iso.c which works
> similar to your CMP related workaround in patch 18/39.  I.e., after a
> timed-out lock request to CHANNELS_AVAILABLE or BANDWIDTH_AVAILABLE,
> perform a read request to see what happened.  Like your CMP workaround,
> this is fragile because it races with concurrent lock requests.
>
> Or we could add a workaround in drivers/firewire/core-card.c which would
> attempt to make the local node root node (and thereby IRM) if it detects
> that an M-Audio device is currently IRM.
>
> Not sure what's better.

Currently I'm also not sure. So I want it pending for my future work.

Actually, the failure of operation to CSR_CHANNELS_AVAILABLE_HI appears 
in stopping streams. When starting streams, retries in 
manage_channels()/manage_bandwidth() works fine. So users can use their 
devices as usual.

The disadvantages may appears when the driver handles this failure many 
times. Then users will see this message 'isochronous resources exhausted'.

I think the way to recover this state is just to reboot the system. But 
this state doesn't bring sudden hangup to system. Users can observer 
what happened.

With trade-off of the fact that there is no driver for these devices in 
both of user-land/kernel-land, I want to include these patches.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
