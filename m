From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [RFC][PATCH 0/3] ALSA: fireface: new driver for
 RME Fireface series (MIDI only)
Date: Mon, 7 Dec 2015 12:51:12 +1030
Message-ID: <20151207022112.GF6213@marvin.atrad.com.au>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151206215744.GA6103@marvin.atrad.com.au>
 <5664E06C.9080705@sakamocchi.jp>
 <20151207013748.GD6213@marvin.atrad.com.au>
 <5664E64E.7000807@sakamocchi.jp> <5664E961.9080907@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CCAC265043
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 03:21:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5664E961.9080907@sakamocchi.jp>
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

On Mon, Dec 07, 2015 at 11:05:21AM +0900, Takashi Sakamoto wrote:
> More explaination.
> :

Thanks for posting the extended explanation.

> Furthermore, 0x0010 is not always true because the address range which
> drivers allocate on the controller is different depending on situation.

In general that's true.  For the FF400 at least though the non-nodeID
component is effectively hard coded on other systems.  If this is used
solely as an address then we wouldn't have to follow that convention
obviously, but this assertion would have to be confirmed valid in practice.

Regards
  jonathan
