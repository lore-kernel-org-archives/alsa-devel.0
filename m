From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Patch to enable IR on Audigy 2 Drive
Date: Mon, 10 Mar 2003 22:31:31 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303102231.31227.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Hi, I've been having a frustrating couple of days getting IR to work on my 
brand new Audigy2 drive... Lots of people seem to have it working, but for 
me, it refused. Enabling it under windows showed that the IR _did_ work, and 
if I rebooted immediately into linux, IR worked there too (although not after 
a power cycle).

It turns out the Audigy2 (and maybe the Audigy as well? I don't know) has a 
different port (A_IOCFG instead of A_HCFG) for accessing the GPIO 
registers... This is actually in the OSS driver, but hadn't made it across to 
ALSA. I assume the people who had this working were all using the OSS driver.

I'd like to point out that I've only done this for the IR.. it might be an 
idea to check the ALSA emu101k source for other occurences of this for the 
Audigy2.. 

Here's a patch against CVS to the IR enabling code.

--- CUT HERE ---
Index: include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.23
diff -r1.23 emu10k1.h
236a237,238
> #define A_IOCFG_GPOUT1		0x0002    /* IR */
> #define A_IOCFG_GPOUT2		0x0001		/* IR */
Index: pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.22
diff -r1.22 emu10k1_main.c
224,230c224,239
< 	if (enable_ir) {	/* enable IR for SB Live */
< 		unsigned int reg = inl(emu->port + HCFG);
< 		outl(reg | HCFG_GPOUT2, emu->port + HCFG);
< 		udelay(500);
< 		outl(reg | HCFG_GPOUT1 | HCFG_GPOUT2, emu->port + HCFG);
< 		udelay(100);
< 		outl(reg, emu->port + HCFG);
---
> 	if (enable_ir) {	/* enable IR for SB Live/Audigy */
> 		if (emu->audigy) {
> 			unsigned int reg = inl(emu->port + A_IOCFG);
> 			outl(reg | A_IOCFG_GPOUT2, emu->port + A_IOCFG);
> 			udelay(500);
> 			outl(reg | A_IOCFG_GPOUT1 | A_IOCFG_GPOUT2, emu->port + A_IOCFG);
> 			udelay(100);
> 			outl(reg, emu->port + A_IOCFG);
> 		} else {
> 			unsigned int reg = inl(emu->port + HCFG);
> 			outl(reg | HCFG_GPOUT2, emu->port + HCFG);
> 			udelay(500);
> 			outl(reg | HCFG_GPOUT1 | HCFG_GPOUT2, emu->port + HCFG);
> 			udelay(100);
> 			outl(reg, emu->port + HCFG);
> 		}
--- CUT HERE ---

-- 
adq


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
