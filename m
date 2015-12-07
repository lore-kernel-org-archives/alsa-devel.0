From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [RFC][PATCH 0/3] ALSA: fireface: new driver for
 RME Fireface series (MIDI only)
Date: Mon, 7 Dec 2015 19:11:08 +1030
Message-ID: <20151207084108.GA6726@marvin.atrad.com.au>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151206215744.GA6103@marvin.atrad.com.au>
 <5664E06C.9080705@sakamocchi.jp>
 <20151207013748.GD6213@marvin.atrad.com.au>
 <5664E64E.7000807@sakamocchi.jp> <5664E961.9080907@sakamocchi.jp>
 <20151207022112.GF6213@marvin.atrad.com.au>
 <56653732.6000107@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 2046E2604AC
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 09:41:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56653732.6000107@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 07, 2015 at 08:37:22AM +0100, Clemens Ladisch wrote:
> Jonathan Woithe wrote:
> > On Mon, Dec 07, 2015 at 11:05:21AM +0900, Takashi Sakamoto wrote:
> >> Furthermore, 0x0010 is not always true because the address range which
> >> drivers allocate on the controller is different depending on situation.
> >
> > In general that's true.  For the FF400 at least though the non-nodeID
> > component is effectively hard coded on other systems.
> 
> That's just because this value happens to be the first free address in
> the FireWire address space.

It's hardcoded (in the way I subsequently detailed) on at least one other
(non-Linux) system: when that particular FF400 register is written the upper
16 bits are a node ID and the lower 16 bits are unconditionally set to
0x0001.  That's not to say that this is the best way, but it's what's done
on that system, with all the caveats that this implies.

In the above system there is no explicit consideration of what addresses
happen to be free.  The address which is chosen does not appear to be the
lowest free address: there would be plenty unused addresses below it in
general.

> If you had other FireWire devices whose drivers allocated addresses, you
> would see different values.

For this reason (that is, other drivers/devices grabbing the resulting
address range) the methodology I detailed above for choosing the target
address is perhaps not the most appropriate for Linux.  Takashi S's tests
indicate that there is no hidden functionality controlled by the lower 16
bits of this register so we are free to adopt our own address selection
philosphy.

> (Maybe even for multiple FF devices, but the driver might be able to share
> the range for all devices.)

The multiple FF400 case would, I expect, be disambiguated by the inclusion
of the node ID in the register value (and hense the address listened to).

Regards
  jonathan
