From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: CIP Discontinuity with snd-firewire-digi00x
Date: Sun, 5 Jun 2016 09:33:51 +0900
Message-ID: <5753736F.6010902@sakamocchi.jp>
References: <alpine.LNX.2.20.1606041726460.13950@anticlack.com>
 <57535D26.2080105@sakamocchi.jp>
 <alpine.LNX.2.20.1606041805260.17774@anticlack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 4AA27261501
 for <alsa-devel@alsa-project.org>; Sun,  5 Jun 2016 02:33:58 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.20.1606041805260.17774@anticlack.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lin-alsa@noblejury.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 5 2016 08:09, lin-alsa@noblejury.com wrote:
> The relavent dmesg lines (dmesg | grep fire) are here: http://ix.io/OQ2.
> I don't know if the first bit about the config rom has anything to do with
> this, but I hope it helps, and the hex pairs are in that log.

It's really my help, great ;)

> Re: the clock issue, I'm not actually using optical in, if that's what
> you mean. Please explain what you mean to me, I'm a bit confused as to
> your question.

Oops. I was dull just after waking up. (it's an exchange for the quick
reply...)

On Jun 5 2016 07:30, lin-alsa@noblejury.com wrote:
> `Optical mode: adat
> Sampling Rate: 88200
> Clock Source: internal`

Indeed, your unit is set to use internal clock signal as sampling clock.
So no worry about the external signals, sorry.


Well, as long as seeing your log, ALSA digi00x driver detects
discontinuity of data block counter on incoming packets from the unit.
(On IEEE 1394 bus, data is transferred as a form of packet.)
Unfortunately, I cannot reproduce this situation with my unit.

So I think there's two possibility:
1.We work with different drivers; i.e. based on different source code.
2.We work with different state of the unit; i.e. different firmware.

At first, let's confirm the item 1. Could you explain where
snd-firewire-digi00x comes from? Is it from any Linux distribution? Or
you did handy install from somewhere such as my repository in github.com?


Regards

Takashi Sakamoto
