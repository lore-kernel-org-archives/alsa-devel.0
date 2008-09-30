From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: AIC23 codec ADC problem
Date: Mon, 29 Sep 2008 17:46:26 -0700
Message-ID: <48E176E2.6050207@boundarydevices.com>
References: <48DFF3F1.8010101@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth01.csee.onr.siteprotect.com
	(smtpauth01.csee.onr.siteprotect.com [64.26.60.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 68FD0245C5
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 02:46:43 +0200 (CEST)
Received: from [192.168.0.251] (unknown [67.42.45.38])
	(Authenticated sender: troy.kisky@boundarydevices.com)
	by smtpauth01.csee.onr.siteprotect.com (Postfix) with ESMTP id
	999FA1C802E
	for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2008 19:46:41 -0500 (CDT)
In-Reply-To: <48DFF3F1.8010101@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Troy Kisky wrote:
> Hi All
> 
> 
> I'm using the TLV320AIC23 to record sound from a mic. It sounds fine
> when I play it back, but when I look at the data, the value
> in one channel is always exactly double the value in the other.
> Since the mic gives the same input to both ADC's I was expecting
> to have the same value in the left & right channels. Has
> anyone seen this before? Any guesses to what I might be doing
> wrong? Can someone using an AIC23 check their data for me?
> I'm using a davinci DM644x platform and spi interface to the codec
> in dsp_a mode.
> 
> 
> 
> sample data
> 00ec40 fffeffff 00040002 00040002 00000000
> 00ec50 fffeffff fffeffff 00000000 fffafffd
> 00ec60 fffeffff 00020001 00040002 00080004
> 00ec70 000a0005 0016000b 0014000a 001a000d
> 00ec80 001c000e 001e000f 00200010 00260013
> 00ec90 001e000f 001e000f 001e000f 001c000e
> 00eca0 001c000e 0018000c 0014000a 0014000a
> 00ecb0 0014000a 000e0007 00120009 0014000a
>           ^        ^        ^        ^
>           Always even
> 
> 
> After swapping the left & right channels
> at the codec
> 
> 011af0 fffcfffe fffeffff 00060003 00060003
> 011b00 000a0005 000c0006 000e0007 000c0006
> 011b10 00080004 00080004 00060003 00060003
> 011b20 00080004 00060003 00060003 00040002
> 011b30 00020001 00020001 00000000 00020001
> 011b40 fffeffff 00000000 00040002 00060003
> 011b50 000c0006 000e0007 00100008 0014000a
> 011b60 00120009 000e0007 00100008 00100008
> 011b70 000e0007 00080004 00080004 00060003
> 011b80 00060003 00060003 00060003 000a0005
> 
> 
> No change, so the ADC's both do convert to
> the same value. But there appears to be a 1 bit
> delay between the two channels.
> 
> My McBsp is reading 1 32 bit element, so I don't
> think it can shift only half of the element.
> 
> 
> 
> After switching to dsp_b mode (an extra bit
> delay before data starts)
> 
> 00b130 fff8fff8 fff5fff5 fffafffa fffcfffc
> 00b140 fffefffe 00010001 00000000 00010001
> 00b150 00020002 00010001 00010001 00010001
> 00b160 00000000 ffffffff 00020002 00000000
> 00b170 00000000 00000000 fffefffe fffefffe
> 00b180 fffdfffd fffdfffd 00000000 ffffffff
> 00b190 00020002 00010001 00020002 00030003
> 00b1a0 00030003 00030003 00050005 00030003
> 00b1b0 00050005 00030003 00010001 00000000
> 
> When I play this back in dsp_b mode I hear
> random soft popping from the speaker, but it is loud.
> 
> Playing it in dsp_a mode is quiet with no popping.
> 
> So, I conclude that recording with the codec is buggy
> in dsp_a mode and playback is buggy in dsp_b mode.
> I hope someone will tell me I'm wrong.
> 
> Thanks
> Troy


I just tried the same code on a different board
of the same type, and it is working fine.

So, please excuse the noise.


Troy
