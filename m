From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: problems compiling from cvs
Date: Wed, 23 Oct 2002 04:52:44 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB5AC8C.4030905@boosthardware.com>
References: <1035314317.3100.4.camel@hamish.iriXx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: m <m@iriXx.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

m wrote:
> hi,
> 
> i was directed to this list by Patrick Shirkey who suggested that i
> might be able to help with testing the midi support for the usb audio
> quattro... i'm also testing an Evolution UC-16 for a magazine review...
> 
> i've downloaded a copy of rc4 from cvs, but am getting the following
> errors on doing
> make ALSAKERNELDIR=../alsa-kernel
> 
> gcc -D__KERNEL__ -DMODULE=1 -I/home/miriam/alsa-driver/include
> -I/lib/modules/2.4.18-6mdk/build/include -O2
> -mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall
> -Wstrict-prototypes -fomit-frame-pointer -pipe -DALSA_BUILD  
> -DEXPORT_SYMTAB -c seq_instr.c
> In file included from ../../alsa-kernel/core/seq/seq_instr.c:25,
>                  from seq_instr.c:1:
> ../../alsa-kernel/core/seq/seq_clientmgr.h:56: parse error before
> `bitmap_member'
> ../../alsa-kernel/core/seq/seq_clientmgr.h:56: warning: no semicolon at
> end of struct or union
> ../../alsa-kernel/core/seq/seq_clientmgr.h:73: parse error before `}'
> make[2]: *** [seq_instr.o] Error 1
> make[2]: Leaving directory `/home/miriam/alsa-driver/acore/seq'
> make[1]: *** [_modsubdir_seq] Error 2
> make[1]: Leaving directory `/home/miriam/alsa-driver/acore'
> make: *** [compile] Error 1
> 
> if anyone could help in interpreting what may be missing here i would be
> very grateful,
> 

You only need to compile alsa-devel, alsa-lib and alsa-utils

for alsa-devel use

./cvscompile --with-cards=usb-audio --with-sequencer=yes;make;make install

then run ./snddevices

for the other two

./cvscompile;make;make install





-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
