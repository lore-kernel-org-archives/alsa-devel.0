From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: AC3 passthrough on Audigy
Date: Wed, 27 Aug 2003 00:44:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4BF0D8.9080701@superbug.demon.co.uk>
References: <200308260847.KAA24438@www3.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308260847.KAA24438@www3.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: p z oooo <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

p z oooo wrote:
> Hi,
> 
> This is taken from oss driver. It is not tested (I don't own 
> receiver). Can someone try it, maybe this works, I don't know.
> 
> Audigy.conf - copy this to /usr/share/alsa/cards/ and overwrite old 
> one (make backup).
> 
> emu10k1.h.patch - patch for file alsa-driver/alsa-
> kernel/include/emu10k1.h
> 
> emufx.c.patch - patch for file alsa-driver/alsa-
> kernel/pci/emu10k1/emufx.c
> 
> If this doesn't work try to comment out lines
> A_OP(icode, &ptr, iSKIP, A_GPR_COND, A_GPR_COND, A_GPR(gpr - 2), 
> A_C_00000001);
> A_OP(icode, &ptr, iACC3, A_GPR(tmp + 2), A_C_00000000, A_C_00010000, 
> A_GPR(tmp + 2));
> 
> And if this doesn't work too, then delete this mail.
> 
> Peter Zubaj
> 
I tried this on an Audigy2. It does not work.
The non-audio bits on the SPDIF are set correctly, and Audio data is 
being sent out from the port, so for PCM data it is fine. For non-audio 
AC3 data, it fails. Probably due to the samples getting modified in some 
way as they pass thru the DSP.

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
