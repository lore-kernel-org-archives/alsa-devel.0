From: Mark Rages <markrages@mlug.missouri.edu>
Subject: Re: Re: Opti 931: Med931 ver.2.0
Date: Mon, 12 Aug 2002 17:43:02 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020812224302.GA12019@mlug.missouri.edu>
References: <20020812093015.MHDE12516.fep06-svc.mail.telepac.pt@[127.0.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlug.missouri.edu (root@mlug.missouri.edu [128.206.61.230])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA11941
	for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2002 00:43:11 +0200
Content-Disposition: inline
In-Reply-To: <20020812093015.MHDE12516.fep06-svc.mail.telepac.pt@[127.0.0.1]>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: hugo.ferreira@mail.telepac.pt
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 12, 2002 at 10:30:15AM +0100, hugo.ferreira@mail.telepac.pt wrote:
> Hi Takashi, Massimo, anyone
> 
> Takashi, in response to this last e-mail I patially solved the
> problem. Just to be in the safe side, I:
>
> 1. cleaned the rc2 installation.
> 2. downloaded the cvs version again (10-08-2002)
> 3. did a ?./cvscompile?
> 4. did a ?make install?
> 
> It all went fine. I then proceeded to insert ?snd_printk? statements
> in the code of the drive to see what was happening. The process is 
> slow and somewhat stressfull 8-[ (Cyrix 200+ with 64Mega). I would 
> like to know:
>
> 1. How may I compile/make and install just the modules that I am 
> interested in (--with-card ?)

You can use --with-cards or edit a file in the root directory of the alsa 
kernel source. sorry, can't remember the name and I'm not on my home 
computer right now.

> 2. Do  have to ./cvscompile all the time? I did try just using 
> ?make? after the 1st config, but this did  not seem to work.

Seems like I did "make modules" and "make modules install" just like
when building the Linux kernel. this could be wrong.
 
> 3. Do you have any pointers on debugging ALSA diver module? I am sorry
> but my experioence in this platform is somewhat lacking (make.
> autoconfig, etc.).

This is all I've got:

http://alsa.opensrc.org/index.php?page=WritingAnAlsaDriver

Read the book linked from above, particualarly the section on debugging.

Datasheet: ftp://ftp.alsa-project.org/pub/datasheets/opti/82c931.pdf

I think I've got an old ISA Opti 931 card (purchased new for $7) in a box at 
home. I can help debug things if neccesary. 

You mentioned using a Cyrix CPU. On a Windows-only mailing list I'm on, many
people talk about drivers that only work on certain CPUs. I've never heard
anything like that on Linux. This is due either to my ignorance, or to Windows 
users' cluelessness ("Blame the CPU!") or some technical factor I'm not aware 
of.

Regards,
Mark


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
