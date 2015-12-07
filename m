From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 1/3] fireface: add skeleton for RME
	Fireface series
Date: Mon, 7 Dec 2015 12:35:26 +1030
Message-ID: <20151207020526.GE6213@marvin.atrad.com.au>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <1449408224-13955-2-git-send-email-o-takashi@sakamocchi.jp>
 <20151206221326.GB6103@marvin.atrad.com.au>
 <5664E1AA.7030504@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C1D0265011
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 03:05:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5664E1AA.7030504@sakamocchi.jp>
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

On Mon, Dec 07, 2015 at 10:32:26AM +0900, Takashi Sakamoto wrote:
> On Dec 07 2015 07:13, Jonathan Woithe wrote:
> >>It's reasonable that these models use different protocol for
> >>communication.
> >
> >For FF400 and FF800 the streaming protocol is very similar.  I expect the
> >same to hold for the newer devices too, but will be able to say more once I
> >get a chance to fully probe the UFX.  In other words, at this stage it is
> >fair to say that the streaming component for all devices will be similar,
> >and there is probably no reason to consider there being three completely
> >different firmwares.  There are obviously some differences which will need
> >to be allowed for in places, but the same is true for almost every device
> >family.
> 
> If so, why the vendor (RME GmbH) produces these different firmwares? Could
> I request your opinions about it?

The hardware used is different in each model.  The Fireface product line is
FPGA-based and as such the "firmware" (which is as much to do with the FPGA
bitstream as it is to do with software) is very tightly bound to the exact
nature of the componentry which the FPGA needs to interface with.  This is
why there are separate firmwares for each model.  However, the programming
interface exposed to the bus by the different firmwares have a high degree
of similarity.  There are some differences which are mostly evolutionary,
corresponding to improved ways to implement things in the FPGA, better PCB
layour, and so on.  However, the basic ideas remain the same.  This applies
to the FF400 and FF800 and I expect the streaming portion of the newer units
as well.

RME has revised the signal routing and control portions of their interfaces
in the last few years which has, I expect, changed the way mixer and DSP
control is implemented.  I expect this doesn't impact the streaming
components significantly, although as noted earlier I need to confirm this. 
This newer implementation is known as TotalMixFX while the earlier one was
referred to as TotalMix.

To summarise, the firmware which goes into an RME Fireface interface is
predominantly an FPGA configuration bitstream and is therefore tightly bound
to the underlying hardware.  Therefore there is per-device firmware. 
However, the exposed interface remains consistent across devices.

Does that address your concerns, or have I misinterpreted what you are
asking or referring to?

> >>+	/* TODO: how to detect all of models? */
> >>+	model = "Fireface 400";
> >
> >Though the unit version field of the ConfigROM.
> >
> >Once I get my head around git and how best to keep track of these patch
> >series I can provide a patch for this.  Despite several attempts to truly
> >understand git over the last few years I have so far failed abysmally.  :-(
> 
> Currently, I have no direction to support models except for FF400 because
> I've never seen their packets. Even if you insists that they are similar,
> actually they're somewhat different (and I guess that the difference is
> larger than you expect, at least, isochronous packet streaming management).

I have been working with both the FF400 and the FF800 at the driver level
since 2009.  I am intimately familiar with the isochronous streaming systems
of both and don't have to guess what the differences might be.  I know what
the differences are, and as I eluded to earlier they are not much more than
superficial.

Regards
  jonathan
