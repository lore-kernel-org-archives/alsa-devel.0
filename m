From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [PATCH 00/19][RFC v2] ALSA:
 firewire-motu: new driver for MOTU FireWire series
Date: Mon, 30 Jan 2017 00:04:56 +1030
Message-ID: <20170129133456.GC15067@marvin.atrad.com.au>
References: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id F094F266CE6
 for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2017 14:35:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
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

On Sun, Jan 29, 2017 at 12:53:58PM +0900, Takashi Sakamoto wrote:
> This patchset updates a part of my previous RFC, just for MOTU FireWire
> series.
> 
> [RFC][PATCH 00/37] ALSA: firewire: support AMDTP variants
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/094789.html
> 
> This patchset adds support for a part of MOTU FireWire series with their
> functionality of packet streaming. Below models are newly supported:
>  - 828
>  - 828mk2
>  - 828mk3 (FireWire/Hybrid)

I like the general architecture of this driver.

It's not clear to me whether you have utilised some information about these
devices from FFADO or have duplicated the protocol reverse engineering
process yourself.  If the former it would be nice to include a brief
acknowlegement since the FFADO MOTU protocol documents and code represents a
large body of work by several people which brought an otherwise undocumented
protocol into the open.  If the latter then clearly it's a moot point.

Regards
  jonathan
