From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: AC3 passthrough on Audigy
Date: Tue, 26 Aug 2003 19:01:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4BA095.1070500@superbug.demon.co.uk>
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
Is this just for the Audigy?
Would it work on the Audigy 2 ?
Is so, I have an Audigy 2 that I could install and do a test with.

Cheers
James




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
