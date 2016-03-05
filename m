From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 2/4] ALSA: dice: handle whole available
 isochronous streams
Date: Sat, 5 Mar 2016 15:47:16 +0100
Message-ID: <20160305154716.1ff2784b@kant>
References: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
 <1457179087-27604-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 502F9260515
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 15:47:19 +0100 (CET)
In-Reply-To: <1457179087-27604-3-git-send-email-o-takashi@sakamocchi.jp>
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

On Mar 05 Takashi Sakamoto wrote:
> This commit enables ALSA dice driver to handle whole available streams.
> 
> In Dice, certain registers represent the number of available streams at
> current sampling transfer frequency for both directions. The parameters
> of each stream are represented in a block of register. This block is
> aligned sequentially. These streams start simultaneously by writing
> enable bit to a register.
> 
> This commit operates these registers when starting/stopping streams. I
> note that this driver fails to handle dice units in which several streams
> are available while IEEE 1394 host controllers support fewer isochronous
> contexts.

Regarding support by host controllers:

OHCI-1394 mandates that host controllers implement at least 4 isochronous
RX DMAs and at least 4 isochronous TX DMAs.  None of the OHCI controllers
that ever came to market violate this requirement as far as I know.

So if you have just a single audio device on the bus, or even two, the
controller won't run out of DMA contexts.

Regarding non-audio FireWire applications:  Most IEEE 1394 video cameras
require one RX stream per camera; some industrial high-bandwidth cameras
take two.  Some DV camcorders offer bidirectional DV transfer over 1394,
hence use 1 RX and/or 1 TX stream depending on the application software on
the host.  The IP-over-1394 protocol, implemented in Linux by the
firewire-net driver, uses 1 isochronous RX DMA context for reception of
asynchronous broadcast transmissions.  The SBP-2 protocol, mainly used as
SCSI-over-1394 encapsulation, does not use isochronous streams.  The
current SBP-3 protocol revision specifies optional isochronous I/O but I
am not aware of any implementation of this protocol feature.

On the other hand, while all OHCIs offer at least 4+4 isoch RX+TX DMAs,
practical experience with the FFADO userspace drivers indicate that most
OHCIs quickly become unreliable when more contexts are being used
simultaneously.  Particularly, the FFADO drivers have a hard time to
maintain synchronicity of the streams, or are flat out unable to establish
synchronization.  Though from what I understand, the ALSA firewire drivers
do this differently, hence may not be affected in the same way as FFADO.
In my and others experience, only LSI controllers (formerly Agere
controllers) and Texas Instruments controllers do not suffer from these
issues when multiple RX/TX streams are active in FFADO.
-- 
Stefan Richter
-======----- --== --=-=
http://arcgraph.de/sr/
