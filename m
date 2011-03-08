From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Tue, 08 Mar 2011 15:36:07 +0200
Message-ID: <4D7630C7.2080105@nokia.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com><8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>	<4D5A2466.2060705@nokia.com><8CD9B43DFD8A17C-DE8-B3DD@web-mmc-d01.sysops.aol.com>	<4D5B7AB5.201@nokia.com><8CD9C6B934040FF-13C8-4BFB@web-mmc-d06.sysops.aol.com><4D5D0A0E.5030505@nokia.com>	<8CD9E665EC96F93-126C-1145E@web-mmc-d04.sysops.aol.com><8CD9EC9F73F6CCC-DDC-EA8F@web-mmc-d06.sysops.aol.com><4D636574.9050501@nokia.com>	<8CDA1851D39EA53-3E0-7A27@web-mmc-d01.sysops.aol.com>
	<8CDA3184E0F0520-4AC-24D6@web-mmc-d01.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 86C43103820
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 14:36:11 +0100 (CET)
In-Reply-To: <8CDA3184E0F0520-4AC-24D6@web-mmc-d01.sysops.aol.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext ylin@mail.com" <ylin@mail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Sorry, I got lost of this mail thread...

On 02/25/11 17:32, ext ylin@mail.com wrote:
> Finally, after 4 days, we caught the problem again.  When channel is =

> swapped, the IRQ is trigger with receive underrun (IRQ_STATUS_REG =3D =

> 0x171e).  And, from the status register, the transmit is overflow as =

> well.  However, I didn't fill zero to one of the transmit channel, and =

> couldn't tell if the playback is swap as well.  Any idea why underun =

> happens, or any suggestion to fix it?

Hrm, underflow on receive, and overflow on transmit at the same time?
Do you had the transmit overflow irq enabled as well?

Do you have access to the OMAP Errata documents? I have seen an Errata
for McBSP2, which was about corruption on transmit operation. It might
be, that the same thing causes nasty effects on the receive side as well.

Because of the nature of this happening in your case, I suspect that we
are facing with some HW race/bug problem.
Receive underflow happens, if DMA tries to read data from McBSP receive
data register when it is empty.
This should not happen, since the McBSP threshold and the DMA size is in
sync, so we should read an amount of data, which is for sure was in the
buffer, when McBSP signaled DMA.

Do you have support contact with TI?
I'll try to reach ours meanwhile, if they have any idea.

Regards,
P=E9ter
