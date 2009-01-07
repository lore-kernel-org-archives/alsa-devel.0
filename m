From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: Bug tracking help wanted (Re: alsa driver #2234
 SoundScape Elite not support)
Date: Wed, 7 Jan 2009 20:03:41 +0100
Message-ID: <20090107200341.ba7bfdd7.krzysztof.h1@poczta.fm>
References: <8D479F36-7BCB-487E-A4A9-25DB7C9A1AD0@hws.edu>
	<20090106181710.3a9ba7cd.krzysztof.h1@poczta.fm>
	<5A449489-AA9E-4D66-8376-771BE195EE0A@hws.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 91FF41037E3
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 20:03:34 +0100 (CET)
In-Reply-To: <5A449489-AA9E-4D66-8376-771BE195EE0A@hws.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Theodore J. Allen" <tjallen@hws.edu>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Jan 2009 13:41:35 -0500
"Theodore J. Allen" <tjallen@hws.edu> wrote:

> sscape: hardware detected at 0x330, using IRQ 5, DMA 1
> ALSA sound/isa/cs423x/cs4231_lib.c:226: codec out - reg 0xc = 0x40
> ALSA sound/isa/cs423x/cs4231_lib.c:1038: cs4231: port = 0x534, id = 0xa
> ALSA sound/isa/cs423x/cs4231_lib.c:1044: CS4231: VERSION (I25) = 0x0
> ALSA sound/isa/cs423x/cs4231_lib.c:1063: unknown CS chip with version 0x0

Hi,

There is one problem here. The codec is not detected. The codec on supported
SoundScape boards is AD1845 which is compatible (more or less) with the
CS4231 codec (hence cs4231 library). According to the wikipedia, the SS Elite
uses AD1848KP codec which is older and not supported by the cs4231 library.
Could you confirm that your card had AD1848KP codec
(big chip with "Analog Devices" and "SoundPort" captions)?

The simplest solution is to try the 2.6.28 or later kernel as the support for 
CS4231 and AD1848 codecs were unified. The new kernel may just work
for you out of the box due to this change. If it does not please send the
dmesg output again.

Thank for your findings,
Krzysztof

----------------------------------------------------------------------
Szef przynudza? Zagraj sobie! 
Kliknij >>  http://link.interia.pl/f200e 
