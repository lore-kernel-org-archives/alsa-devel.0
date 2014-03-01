From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 39/39] bebob: Add support for M-Audio
 special Firewire series
Date: Sat, 1 Mar 2014 11:53:40 +0100
Message-ID: <20140301115340.589ab770@stein>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-40-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 5228A2652F1
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 11:53:43 +0100 (CET)
In-Reply-To: <1393558072-25926-40-git-send-email-o-takashi@sakamocchi.jp>
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

On Feb 28 Takashi Sakamoto wrote:
> This commit allows this driver to support some models which M-Audio produces
> with DM1000 but its firmware is special. They are:
>  - Firewire 1814
>  - ProjectMix I/O
[...]
> M-Audio special firmware quirks:
[...]
>  - They often handle requests without responding. In this reason, this driver
>    often fail to handle them correctly.
[...]
> An fallback at timeout in the operations for CMP was already
> added by previous commit. But for isochronous resource management, no fallbacks
> are added. Further works are needed for Linux Firewire Subsystem.

We could add a workaround in drivers/firewire/core-iso.c which works
similar to your CMP related workaround in patch 18/39.  I.e., after a
timed-out lock request to CHANNELS_AVAILABLE or BANDWIDTH_AVAILABLE,
perform a read request to see what happened.  Like your CMP workaround,
this is fragile because it races with concurrent lock requests.

Or we could add a workaround in drivers/firewire/core-card.c which would
attempt to make the local node root node (and thereby IRM) if it detects
that an M-Audio device is currently IRM.

Not sure what's better.
-- 
Stefan Richter
-=====-====- --== ----=
http://arcgraph.de/sr/
