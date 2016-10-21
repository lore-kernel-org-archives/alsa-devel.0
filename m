From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: M-audio Audiophile Firewire
Date: Sat, 22 Oct 2016 08:51:15 +0900
Message-ID: <fd56b817-96b3-1784-725c-21a5bef7497a@sakamocchi.jp>
References: <CAPzTivG=yDAbFZo+u5qauE_LdpqhUM5fT9MT9+hrmi3gTsTGqw@mail.gmail.com>
 <1f6dd683-f550-651b-93d2-87560dd298ff@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 59CA326655F
 for <alsa-devel@alsa-project.org>; Sat, 22 Oct 2016 01:51:18 +0200 (CEST)
In-Reply-To: <1f6dd683-f550-651b-93d2-87560dd298ff@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peti Pap <roachkiller44@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Oct 22 2016 08:28, Peti Pap wrote:
> Hi,
>
> Thank you the fast answers. Tomorrow I do - again (umpteen) - clean
install
> and if you can/want help - I try to set up the things with your help.
> Anyway, the "lates time" was last week, and I updated fully my System, and
> I tried to compile the latest ffado2 too. (Unfortunately... I am just a
> "next...next finish-man" on Linux... so not so much analytical thinking I
> have). But here the time 1:24am, so I try to sleep, and after when I
> installed the Mint (or if you have recomendation wich distro is better for
> making music (I wanna use the Tracktion Linux ver.)... but I dont want a
> lot of unnecessary software packs (like in the Ubuntu Studio or KX).... so
> after the installation I'll write again (already... today :) )

Please don't omit address list for CC...

Although your unit (M-Audio AudioPhile FW) is one of units based on
DM1000 and BeBoB firmware, it has a unique quirk related firmware loading.

ALSA bebob driver can handle the quirk partly with an condition;
firmware version 5058 or later is required. So what you should do is to
check the version. If your unit has younger version of firmware, you
need to update it with drivers for old Windows operating system.

In detail, see comment of this patch:
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/firewire/bebob/bebob.c?id=a2b2a7798fb6a5c639189e5c8f608a56fdc7a222


Regards

Takashi Sakamoto
