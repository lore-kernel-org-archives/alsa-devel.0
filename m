From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [RFC][PATCH 0/3] ALSA: fireface: new driver for
 RME Fireface series (MIDI only)
Date: Mon, 7 Dec 2015 12:07:48 +1030
Message-ID: <20151207013748.GD6213@marvin.atrad.com.au>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151206215744.GA6103@marvin.atrad.com.au>
 <5664E06C.9080705@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D573265005
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 02:37:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5664E06C.9080705@sakamocchi.jp>
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

On Mon, Dec 07, 2015 at 10:27:08AM +0900, Takashi Sakamoto wrote:
> On Dec 07 2015 06:57, Jonathan Woithe wrote:
> >On Sun, Dec 06, 2015 at 10:23:41PM +0900, Takashi Sakamoto wrote:
> >>Unfortunately, ffado library can disturb this functionality.
> >>In RME::Device::init_hardware() function, the library sends a write transaction
> >>to 0x0000801003f4 with invalid value as higher part of address in IEEE 1212 or
> >>ISO/IEC 13213. This is a worst case I describe in patch 03.
> >
> >The number which FFADO writes to this register is not invalid: it is in fact
> >the same number which is used in drivers on other operating systems
> >(obtained from protocol analysis).
> 
> No.
> 
> As long as I tested with a debug option to firewire-ohci module, it sends
> write transaction with '01000000'. This value includes invalid node ID.

Curious.  Fair enough (although I was confused by the reference to the
"higher part" in the commit message: it implied the higher part of the
address in my mind, but in fact the issue with the node ID relates to the
lower part.  Whatever.  I'll look into it at some point.

Regards
  jonathan
