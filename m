From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] dice: simplifying address registration
Date: Sat, 25 Apr 2015 10:49:56 +0200
Message-ID: <553B5534.1060005@ladisch.de>
References: <553A3FC5.60809@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 293D7260676
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 10:50:35 +0200 (CEST)
In-Reply-To: <553A3FC5.60809@sakamocchi.jp>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Currently Dice driver keeps address ranges for each unit instance. But
> there's a way to reuse the same address range.

This requires an additional check for the packet's source node, which is
essentially a duplicate of the core's address lookup code.

> I think this idea can simplify driver probe processing

Yes, but that code is just moved to the module load processing.

> and save resources of host controller.

When using multiple DICE devices, this saves four bytes of FireWire
address space per card, out of the total address space of 2^48 bytes.
Or what other resources do you mean?


Regards,
Clemens
