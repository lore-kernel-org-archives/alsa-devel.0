From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [RFC][PATCH 0/3] ALSA: fireface: new driver for
 RME Fireface series (MIDI only)
Date: Mon, 7 Dec 2015 13:31:15 +1030
Message-ID: <20151207030115.GH6213@marvin.atrad.com.au>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151206215744.GA6103@marvin.atrad.com.au>
 <5664E06C.9080705@sakamocchi.jp>
 <20151207013748.GD6213@marvin.atrad.com.au>
 <5664E64E.7000807@sakamocchi.jp> <5664E961.9080907@sakamocchi.jp>
 <20151207022112.GF6213@marvin.atrad.com.au>
 <5664F20F.4010005@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 5389B265055
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 04:01:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5664F20F.4010005@sakamocchi.jp>
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

On Mon, Dec 07, 2015 at 11:42:23AM +0900, Takashi Sakamoto wrote:
> On Dec 07 2015 11:21, Jonathan Woithe wrote:
> >In general that's true.  For the FF400 at least though the non-nodeID
> >component is effectively hard coded on other systems.  If this is used
> >solely as an address then we wouldn't have to follow that convention
> >obviously, but this assertion would have to be confirmed valid in practice.
> 
> I think you mention about a part of value except for node ID.

Yes, that's what I was referring to.  Sorry for not being clearer.

> In my former example (0xFFC74567), it's 0x4547.

Right.  Node ID is in the upper 16 bits, and another value (0x4547 in the
above example) in the lower 16 bits.

> You mean that Fireface 400 ignores the part and sends transactions to the
> fixed local address (i.e. 0x'0001'0000'0000).

No, what I meant was that the low part (the 0x4547 in your example) is
always 0x0001 on other systems for the FF400.  Apologies for the confusion.

> The model can reasonably send transactions to the address which the driver
> registered.

Ok, that's good.  It means we're free to choose exactly what suits us.

jonathan
