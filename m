From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ICE1712/1724 HW mixing?
Date: Wed, 16 May 2007 09:27:40 +0100
Message-ID: <200705160927.40433.gineera@aspect135.co.uk>
References: <464A5D6A.9020104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (unknown [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id E48CA24344
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2007 10:22:34 +0200 (CEST)
In-Reply-To: <464A5D6A.9020104@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 16 May 2007 02:24, Rene Herman wrote:
> Good day.
>
> I've been updating the TerraTec vendor page in the new wiki matrix:
>
> http://bugtrack.alsa-project.org/main/index.php/Matrix:Vendor-Terratec
>
> The problem with information that looks maintained though is that when
> something's _not_ mentioned, it might be interpreted to mean it's not
> actually working....
>
> I have the older TerraTec cards (both ISA and PCI) but not any of the
> ICE1712/ICE1724 ones. Could someone verify/confirm that the ICE1712
> (Envy24?) does not support 24-bit samples?
>
> And that ICE1724 supports only 32-bit in hardware?
>
> Does either chip/driver support hardware mixing?
>
> Filling out some of the Digital I/O tags for any Aureon card that you know
> would be nice as well.
>
> Rene.

My understanding was that ice1712 data format is always 24-bit 'loose-packed' 
into 32-bits (ie with 0's added), the ice1724 is probably the same?  That is 
what the Terratec DMX6fire handbook also says.  The chipset is 24-bit/96Khz 
capable.  Hardware mixing of 10 inputs and 10 outputs is provided.  In the 
notes, it is probably worth mentioning Envy24control, a mixing/control tool 
dedicated to this chipset?

The DMX6fire has both optical and phono SPDIF connectors, and a wavetable 
connector in the front box (for use with DB50XG etc), and works fine since 
1.0.12.

Regards  Alan
