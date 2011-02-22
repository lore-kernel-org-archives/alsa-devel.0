From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Tue, 22 Feb 2011 09:27:48 +0200
Message-ID: <4D636574.9050501@nokia.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com><8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>	<4D5A2466.2060705@nokia.com><8CD9B43DFD8A17C-DE8-B3DD@web-mmc-d01.sysops.aol.com>	<4D5B7AB5.201@nokia.com><8CD9C6B934040FF-13C8-4BFB@web-mmc-d06.sysops.aol.com><4D5D0A0E.5030505@nokia.com>	<8CD9E665EC96F93-126C-1145E@web-mmc-d04.sysops.aol.com>
	<8CD9EC9F73F6CCC-DDC-EA8F@web-mmc-d06.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 96E6B10387F
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 08:27:51 +0100 (CET)
In-Reply-To: <8CD9EC9F73F6CCC-DDC-EA8F@web-mmc-d06.sysops.aol.com>
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

On 02/20/11 06:01, ext ylin@mail.com wrote:
>>> Or can you share the relevant configuration (from your machine =

> driver)
>>> with us?
> =

> And, these are McBSP2 registers with both Tx and Rx audio running.
> **** McBSP2 regs ****
> DRR2:  0xffee
> DRR1:  0x0000
> DXR2:  0x0000
> DXR1:  0x0000
> SPCR2: 0x02f5
> SPCR1: 0x0031
> RCR2:  0x8041
> RCR1:  0x0040
> XCR2:  0x8041
> XCR1:  0x0040
> SRGR2: 0x001f
> SRGR1: 0x0f00
> PCR0:  0x000f
> ***********************

Both the twl and McBSP config seams to be in sync.
I do not see anything, which stands out...

I think you need to implement the PRCM compliant interrupt config to
check for McBSP underflow/overflow.

I'll try to resurrect my Beagle board, since that as well have the twl
codec on McBSP2...

-- =

P=E9ter
