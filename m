From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 2/4] ALSA: dice: postpone card registration
Date: Thu, 24 Dec 2015 22:04:14 +0100
Message-ID: <20151224220414.3a8a90ee@kant>
References: <1450911310-15507-1-git-send-email-o-takashi@sakamocchi.jp>
 <1450911310-15507-3-git-send-email-o-takashi@sakamocchi.jp>
 <20151224215147.1fae080b@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 4410D260642
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2015 22:04:15 +0100 (CET)
In-Reply-To: <20151224215147.1fae080b@kant>
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

On Dec 24 Stefan Richter wrote:
> I am not sure how strictly you want to guarantee the
> delay between last reset and do_registration()'s execution.  Maybe it
> would be beneficial to put the check for card->reset_jiffies and self-
> rescheduling into do_registration(), similar to the two examples from
> firewire-core, or maybe that's not really necessary for your purposes.

Or as I wrote in the other thread:
Maybe you can live with less precision and simply use a fixed relative
delay, disregarding card->reset_jiffies altogether.
-- 
Stefan Richter
-=====-===== ==-- ==---
http://arcgraph.de/sr/
