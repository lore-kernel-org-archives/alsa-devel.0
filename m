From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 18/39] firewire-lib: Add a fallback at
	RCODE_CANCELLED
Date: Sat, 01 Mar 2014 21:23:35 +0900
Message-ID: <5311D147.6010907@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-19-git-send-email-o-takashi@sakamocchi.jp>
 <20140301113444.7c257eb3@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 15CE626530A
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 13:23:38 +0100 (CET)
In-Reply-To: <20140301113444.7c257eb3@stein>
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

(Mar 02 2014 19:34), Stefan Richter wrote:
>> - *         messages
>> + *         messages: use %FW_RETURN_TIMEOUT to avoid retry at RCODE_CANCELLED
>
> For clarity, this should be a semicolon instead of a colon, i.e.
>
>                messages; use %FW_RETURN_TIMEOUT to avoid retry at RCODE_CANCELLED

Exactly. Thank you.


Takashi Sakamoto
o-takashi@sakamocchi.jp
