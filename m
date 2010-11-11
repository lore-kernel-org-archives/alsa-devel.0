From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Channel swapping problem on Atmel SSC audio
Date: Thu, 11 Nov 2010 12:27:09 +0000
Message-ID: <201011111227.09633.gineera@aspect135.co.uk>
References: <4CDB217E.2030906@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip09ir2.opaltelecom.net (out1.ip09ir2.opaltelecom.net
	[62.24.128.245]) by alsa0.perex.cz (Postfix) with ESMTP id ED08024469
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 13:27:16 +0100 (CET)
In-Reply-To: <4CDB217E.2030906@bluewatersys.com>
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
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 10 November 2010 22:49, Ryan Mallon wrote:
> I'm working on a custom board using the AT91SAM9G45 processor and a
> TLV320AIC26 SPI attached audio codec using I2S format audio. When doing
> audio playback on the board the left and right channels are occasionally
> flipped.

<snip>

> Has anybody else had this problem, or does anybody have any AT91/Atmel
> hardware that they could test to see if it occurs on other hardware also?

I have worked with the AT91SAM9260 on a project which is currently suspended 
(other priorities), where we had a simiar problem, with a codec on SPI.  
Every time audio was started (capture or playback) the channels could be 
swapped.  Solving that issue remains TODO when we restart.

There was a thread on alsa-devel last month 'Soc Atmel SSC stereo problem' 
with some suggestions.

HTH,

Alan
