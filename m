From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ld10k1 audigy patch
Date: Tue, 22 Jun 2004 21:04:54 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1087952646.5142.7.camel@mindpipe>
References: <200406220610.i5M6ABEg016715@www5.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200406220610.i5M6ABEg016715@www5.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Peter,

Here is what happens when I apply the patch to ALSA CVS sources:

rlrevell@mindpipe:/usr/src/alsa-cvs$ cat
../ld10k1-0.1.3p2/patch/audigy_v2.patch | patch -p1
patching file alsa-kernel/include/emu10k1.h
Hunk #1 succeeded at 736 (offset 1 line).
Hunk #2 succeeded at 859 (offset 1 line).
Hunk #3 succeeded at 872 (offset 1 line).
Hunk #4 succeeded at 883 (offset 1 line).
Hunk #5 succeeded at 1148 (offset 8 lines).
Hunk #6 succeeded at 1281 (offset 10 lines).
Hunk #7 succeeded at 1326 (offset 10 lines).
Hunk #8 succeeded at 1336 (offset 10 lines).
Hunk #9 succeeded at 1349 (offset 10 lines).
Hunk #10 succeeded at 1370 (offset 10 lines).
patching file alsa-kernel/pci/emu10k1/emu10k1_main.c
Hunk #1 FAILED at 96.
1 out of 1 hunk FAILED -- saving rejects to file
alsa-kernel/pci/emu10k1/emu10k1_main.c.rej
patching file alsa-kernel/pci/emu10k1/emufx.c
Hunk #1 succeeded at 482 (offset -305 lines).
Hunk #2 succeeded at 507 (offset -305 lines).
Hunk #3 succeeded at 518 (offset -305 lines).
Hunk #4 succeeded at 528 (offset -305 lines).
Hunk #5 succeeded at 546 (offset -305 lines).
Hunk #6 succeeded at 562 (offset -305 lines).
Hunk #7 succeeded at 575 (offset -305 lines).
Hunk #8 succeeded at 969 (offset -305 lines).
Hunk #9 succeeded at 1297 (offset -305 lines).
Hunk #10 succeeded at 2051 (offset -303 lines).
Hunk #11 succeeded at 2062 (offset -303 lines).
Hunk #12 succeeded at 2077 (offset -303 lines).
patching file alsa-kernel/pci/emu10k1/emuproc.c

I sent you a patch to make this apply cleanly to ALSA CVS, 
but it does not seem to work once you compile it.

I am running as root.

Also I hope you don't mind that I cc'ed alsa-devel; there is no list 
for ld10k1 and I think it is a very important utility for anyone using 
the emu10k1 driver.  In fact, to do low latency with the emu10k1, a DSP
patch loader like ld10k1 will be required, as you have to be able to 
patch things into the FXBus.

Lee

On Tue, 2004-06-22 at 02:10, Peter Zubaj wrote:
> Did you run ld10k1 as root ????
> 
> This error mesage is little wrong. It means that ld10k1 can't set tram
> size and can have two reasons:
> 1) not aplied audigy patch.
> 2) ld10k1 not run under root - I will make test for this.
> 
> Peter Zubaj
> 
> 
> ____________________________________
> http://www.pobox.sk/ - spolahliva a bezpecna prevadzka
> 
> 
> 
> 



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
