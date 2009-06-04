From: Manjunath A M <manjunatham@tataelxsi.co.in>
Subject: Audio driver for dbAu1250 Development board
Date: Thu, 04 Jun 2009 14:58:06 +0530
Message-ID: <4A2793A6.9090800@tataelxsi.co.in>
Reply-To: manjunatham@tataelxsi.co.in
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpin2.mailsecure.in (SMTPIN2.mailsecure.in [121.241.224.3])
	by alsa0.perex.cz (Postfix) with ESMTP id A70CE103911
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 11:28:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "nitinm76 at yahoo.com"@alsa-project.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I am trying to make audio up in dbAu1250 Development board, I downloaded =

linux-2.6.29.4 kernel from the site =

"http://www.linux-mips.org/pub/linux/mips/kernel/v2.6/ " and
applied the patch "asoc-v2.6.29-rc8-2009-03-17.patch"downloaded from =

"http://opensource.wolfsonmicro.com/~git/asoc/"
but while compiling i am getting the bellow errors

********Linux compilation errors*************

sound/soc/au1x/exmmb-ac97.c:24:38: error: asm/mach-exm1200/exm1200.h: No =

such file or directory
sound/soc/au1x/exmmb-ac97.c:26:25: error: linux/exm32.h: No such file or =

directory
sound/soc/au1x/exmmb-ac97.c:58: error: subscripted value is neither =

array nor pointer
sound/soc/au1x/exmmb-ac97.c:65: error: variable =E2snd_soc_machine_exm97=E2 =

has initializer but incomplete type
sound/soc/au1x/exmmb-ac97.c:66: error: unknown field =E2name=E2 specified i=
n =

initializer
sound/soc/au1x/exmmb-ac97.c:66: warning: excess elements in struct =

initializer
sound/soc/au1x/exmmb-ac97.c:66: warning: (near initialization for =

=E2snd_soc_machine_exm97=E2)
sound/soc/au1x/exmmb-ac97.c:67: error: unknown field =E2dai_link=E2 =

specified in initializer
sound/soc/au1x/exmmb-ac97.c:67: warning: excess elements in struct =

initializer
sound/soc/au1x/exmmb-ac97.c:67: warning: (near initialization for =

=E2snd_soc_machine_exm97=E2)
sound/soc/au1x/exmmb-ac97.c:68: error: unknown field =E2num_links=E2 =

specified in initializer
sound/soc/au1x/exmmb-ac97.c:68: warning: excess elements in struct =

initializer
sound/soc/au1x/exmmb-ac97.c:68: warning: (near initialization for =

=E2snd_soc_machine_exm97=E2)
sound/soc/au1x/exmmb-ac97.c:73: error: unknown field =E2machine=E2 specifie=
d =

in initializer
sound/soc/au1x/exmmb-ac97.c:73: warning: initialization from =

incompatible pointer type
sound/soc/au1x/exmmb-ac97.c:74: error: unknown field =E2platform=E2 =

specified in initializer
sound/soc/au1x/exmmb-ac97.c:74: warning: initialization from =

incompatible pointer type
sound/soc/au1x/exmmb-ac97.c:80: error: =E2PSC1_BASE=E2 undeclared here (not =

in a function)
sound/soc/au1x/exmmb-ac97.c: In function =E2psc_to_ac97=E2:
sound/soc/au1x/exmmb-ac97.c:107: error: implicit declaration of function =

=E2au_readl=E2
sound/soc/au1x/exmmb-ac97.c:110: error: implicit declaration of function =

=E2au_writel=E2
sound/soc/au1x/exmmb-ac97.c:111: error: implicit declaration of function =

=E2au_sync=E2
sound/soc/au1x/exmmb-ac97.c:115: error: =E2PSC_CTL=E2 undeclared (first use =

in this function)
sound/soc/au1x/exmmb-ac97.c:115: error: (Each undeclared identifier is =

reported only once
sound/soc/au1x/exmmb-ac97.c:115: error: for each function it appears in.)
sound/soc/au1x/exmmb-ac97.c:117: error: =E2PSC_SEL=E2 undeclared (first use =

in this function)
sound/soc/au1x/exmmb-ac97.c:122: error: =E2PSC_AC97RST=E2 undeclared (first =

use in this function)
sound/soc/au1x/exmmb-ac97.c:124: error: implicit declaration of function =

=E2msleep=E2
sound/soc/au1x/exmmb-ac97.c:133: error: =E2PSC_AC97STAT=E2 undeclared (firs=
t =

use in this function)
sound/soc/au1x/exmmb-ac97.c:140: error: =E2PSC_AC97CFG=E2 undeclared (first =

use in this function)
sound/soc/au1x/exmmb-ac97.c: In function =E2exm1200_mobo_ac97_init=E2:
sound/soc/au1x/exmmb-ac97.c:160: error: implicit declaration of function =

=E2au_readw=E2
sound/soc/au1x/exmmb-ac97.c:160: error: =E2EXM1200_FPGA_BRDCTRL=E2 =

undeclared (first use in this function)
sound/soc/au1x/exmmb-ac97.c:162: error: implicit declaration of function =

=E2au_writew=E2
make[3]: *** [sound/soc/au1x/exmmb-ac97.o] Error 1
make[2]: *** [sound/soc/au1x] Error 2
****************************************************

before applying the patch the board was working but the audio was not =

working..
can you suggest me which kernel source you used and how you got the =

audio working for your board.
can you send me the sample kernel image "vmlinux.srec" image for testing..


Thanks
Manjunath.AM


The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive =

use of the addressee(s) and may contain proprietary, confidential or privil=
eged information. If you are not the intended
 recipient, you should not disseminate, distribute or copy this e-mail. Ple=
ase notify the sender immediately and destroy
 all copies of this message and any attachments contained in it.
