From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to Tx/Rx data via TDM/I2S interface of Intel
 HD Audio controller without a CODEC attached?
Date: Fri, 30 Mar 2012 09:40:16 +0200
Message-ID: <4F756360.6020407@ladisch.de>
References: <934D8D6A4B048048942509C4D57C8A400A845BA6@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 60C22243BC
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Mar 2012 09:37:00 +0200 (CEST)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CD3B62080F
	for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2012 03:36:58 -0400 (EDT)
In-Reply-To: <934D8D6A4B048048942509C4D57C8A400A845BA6@ORSMSX103.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Couch, Kelly J" <kelly.j.couch@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Couch, Kelly J wrote:
> I'm designing software for a specific test application that will
> utilize an Intel HD audio controller.  I must verify the functionality
> of several sets of TDM audio signals (CK, FS, TXD, RXD) from the Intel
> HD Audio controller.  In this scenario, the Intel HD Audio controller
> is NOT connected directly to a CODEC, but to a header.   My proposal
> is to connect these signals directly to an FPGA, using it to loopback
> the data (in various permutations of loopback to channels) to verify
> each of the signals.

Let's see what the spec says:
| SDO =96 Serial Data Out: [...] Data is double pumped =96 i.e., the
| controller drives data onto SDO, and codecs sample data present on
| SDO with respect to every edge of BCLK.  [...]
| SDI =96 Serial Data In: [...] Data is single pumped; codecs drive SDI
| and the controller samples SDI with respect to the rising edge of
| BCLK.

Oh, and outbound and inbound frames use a different format.

I guess this why you're using an FPGA instead of a wire?  :)

> Because the FPGA will be in place of a real CODEC device, I'm
> concerned with how the software side of this approach will work?

The ALSA driver tries to detect the capabilities of the codec(s).
You would have to replace all codec read accesses with hardcoded values
that describe a virtual codec with a suitable widget topology.


Regards,
Clemens
