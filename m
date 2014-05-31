From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] [PATCH] firewire-lib: Use IEC 61883-6
 compliant labels for Raw Audio/
Date: Sat, 31 May 2014 09:35:11 +0200
Message-ID: <5389862F.7060309@ladisch.de>
References: <5389818C.7080205@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0CA4F265457
 for <alsa-devel@alsa-project.org>; Sat, 31 May 2014 09:35:41 +0200 (CEST)
In-Reply-To: <5389818C.7080205@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> I don't touch this label issue with my patchset because there is a bit
> possibility to cause a regression. But now, I have a confidence that
> this modification is reasonable. In detail, please see an attached patch.

> According to AM824 in IEC 61883-6:2002, 2 bits in LSB of label for Raw Audio
> data means Valid Length Code (VBL). Ths value is:
> - b00 for 24 bits sample (label is 0x40)
> - b01 for 20 bits sample (label is 0x41)
> - b10 for 16 bits sample (label is 0x42)
>
> But current firewire-lib apply 24 bits label for both of 16/24 bits samples.
>
> As long as I investigate with BeBoB/Fireworks and OXFW, all of them have a
> behaviour to ignore this label

Same for DICE.


Acked-by: Clemens Ladisch <clemens@ladisch.de>
