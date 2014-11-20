From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH] pcm: add new 32-bit DSD sample format
Date: Thu, 20 Nov 2014 21:07:06 +0200
Message-ID: <546E3BDA.2040601@sonarnerd.net>
References: <1410332428-16571-1-git-send-email-gtmkramer@xs4all.nl>	
 <546CF486.7010009@sonarnerd.net> <s5hy4r6xkfu.wl-tiwai@suse.de>
 <1416501288.2996.1.camel@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 296ED2605D1
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 20:07:07 +0100 (CET)
In-Reply-To: <1416501288.2996.1.camel@xs4all.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jurgen Kramer <gtmkramer@xs4all.nl>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 20.11.2014 18:34, Jurgen Kramer wrote:
> DSD is a bit odd wrt LE/BE. Both formats are allowed and used.
> The device (XMOS based/Marantz+Denon) want the following order of
> samples:
> L1 L2 L3 L4 R1 R2 R3 R4. Where Lx/Rx are 8-bit DSD samples, L1-L4 are
> packed to 1 32-bit sample.

What you described is precisely interleaved big endian U32 sample 
format. L1 is the MSB byte and L4 is the LSB byte of big-endian U32.

So "L1 L2 L3 L4" is equal to DSD_U32_BE. The currently advertised 
DSD_U32_LE would be "L4 L3 L2 L1".

> I do think real BE will not work.

Why? Your description precisely matches U32_BE. And seems to work 
correctly for me...

Constructing the U32 by having oldest bit in MSB and newest bit in LSB 
and sending it out as little-endian results in incorrect output. Adding 
byteswap to big-endian format results in correct output (either using 
__builtin_byteswap32() or htonl()).


	- Jussi
