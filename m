From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/3] ALSA: fireface: new driver for
 RME Fireface series (MIDI only)
Date: Mon, 7 Dec 2015 11:42:23 +0900
Message-ID: <5664F20F.4010005@sakamocchi.jp>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151206215744.GA6103@marvin.atrad.com.au> <5664E06C.9080705@sakamocchi.jp>
 <20151207013748.GD6213@marvin.atrad.com.au> <5664E64E.7000807@sakamocchi.jp>
 <5664E961.9080907@sakamocchi.jp> <20151207022112.GF6213@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 061CC265005
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 03:42:26 +0100 (CET)
In-Reply-To: <20151207022112.GF6213@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Dec 07 2015 11:21, Jonathan Woithe wrote:
> In general that's true.  For the FF400 at least though the non-nodeID
> component is effectively hard coded on other systems.  If this is used
> solely as an address then we wouldn't have to follow that convention
> obviously, but this assertion would have to be confirmed valid in practice.

I think you mention about a part of value except for node ID. In my 
former example (0xFFC74567), it's 0x4547.

You mean that Fireface 400 ignores the part and sends transactions to 
the fixed local address (i.e. 0x'0001'0000'0000).

Although, this is against the fact that I got in my experiences with 
Fireface 400. The model can reasonably send transactions to the address 
which the driver registered.


Regards

Takashi Sakamoto
