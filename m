From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: AC3 passthrough on Audigy
Date: Thu, 28 Aug 2003 21:33:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4E6700.1040703@superbug.demon.co.uk>
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

Do NOT comment out the following lines.

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
Your patch works up to a point. It will only work on the Audigy, and not 
the Audigy2.
The Audigy and Audigy2 do things slighly differently.
The L and R channels are reversed on the Audigy2, so I have compensated 
for this by using a different routing in Audigy2.conf.

If you add my patches, this will work with both the Audigy and Audigy2. :-)

emu10k1.c.patch - patch for file 
alsa-driver/alsa-kernel/pci/emu10k1/emu10k1.c  (So that is looks for 
Audigy2.conf)

Audigy2.conf - copy this to /usr/share/alsa/cards/  (It is a new file)

Summary: -
If one combines pzad's patch with my own, we have AC3 passthru working 
on all SB cards. SB Live (Worked before), SB Audigy (with pzas's patch) 
and SB Audigy2 (with my patch).

Please check these into the alsa-kernel cvs.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
