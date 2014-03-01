From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 39/39] bebob: Add support for M-Audio
 special Firewire series
Date: Sat, 1 Mar 2014 15:32:26 +0100
Message-ID: <20140301153226.1673cae7@stein>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-40-git-send-email-o-takashi@sakamocchi.jp>
 <20140301115340.589ab770@stein> <5311DB6D.3020703@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id C19CA265327
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 15:32:29 +0100 (CET)
In-Reply-To: <5311DB6D.3020703@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Mar 01 Takashi Sakamoto wrote:
[M-Audio devices with misbehaving IRM feature]
> Currently I'm also not sure. So I want it pending for my future work.
> 
> Actually, the failure of operation to CSR_CHANNELS_AVAILABLE_HI appears 
> in stopping streams. When starting streams, retries in 
> manage_channels()/manage_bandwidth() works fine. So users can use their 
> devices as usual.
> 
> The disadvantages may appears when the driver handles this failure many 
> times. Then users will see this message 'isochronous resources exhausted'.
> 
> I think the way to recover this state is just to reboot the system. But 
> this state doesn't bring sudden hangup to system. Users can observer 
> what happened.

Another way to recover would be a 1394 bus reset, for example initiated by
"ffadotest BusReset", or "firecontrol <<< 'br short'", or using the
gscanbus GUI.

> With trade-off of the fact that there is no driver for these devices in 
> both of user-land/kernel-land, I want to include these patches.

I agree.
-- 
Stefan Richter
-=====-====- --== ----=
http://arcgraph.de/sr/
