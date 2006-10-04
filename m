From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [alsa-cvslog] alsa-kernel: emu10k1: Fix outl() in
 snd_emu10k1_resume_regs()
Date: Wed, 4 Oct 2006 20:08:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610042005490.9297@tm8103-a.perex-int.cz>
References: <ALOGGER1159978767.86@alsa-project.org>
	<4523DFF2.4020105@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4523DFF2.4020105@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 4 Oct 2006, James Courtier-Dutton wrote:

> Takashi Iwai wrote:
> > -		outl(emu->port + A_IOCFG, emu->saved_a_iocfg);
> > -	outl(emu->port + HCFG, emu->saved_hcfg);
> > +		outl(emu->saved_a_iocfg, emu->port + A_IOCFG);
> > +	outl(emu->saved_hcfg, emu->port + HCFG);
> >   
> Is there any tool to find out who got this wrong in the first place?

Appearently, the bug is in code from first commit of PM code:

Use:

# hg annonate emu10k1_main.c
....
3769:   outl(emu->port + HCFG, emu->saved_hcfg);
....
# hg log -vr 3769
changeset:   3769:f30a961a9d6855846d824f0a23a1565030399e6c
user:        tiwai
date:        Thu Nov 17 16:14:10 2005 +0000
files:       include/emu10k1.h pci/emu10k1/emu10k1.c 
pci/emu10k1/emu10k1_main.c pci/emu10k1/emufx.c pci/emu10k1/emupcm.c 
pci/emu10k1/p16v.c
description:
emu10k1 - Add PM support

Add PM support to emu10k1 driver.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
