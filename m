From: hugo.ferreira@mail.telepac.pt
Subject: Re: Re: Opti 931: Med931 ver.2.0
Date: Tue, 13 Aug 2002 11:16:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020813101600.YKOU12516.fep06-svc.mail.telepac.pt@[127.0.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from fep06-svc.mail.telepac.pt (fep06-svc.mail.telepac.pt [194.65.5.211])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA19710
	for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2002 12:16:36 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Mark Rages <markrages@mlug.missouri.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Thanks for the reply.

> You can use --with-cards or edit a file in the root directory of the alsa 
> kernel source. sorry, can't remember the name and I'm not on my home 
> computer right now.

You mean I can do a "./cvscompile --with-cards=snd-opti93x" ?

> Seems like I did "make modules" and "make modules 
> install" just like

I'll try this and see what happens. Takashi said
a "make install" would suffice though.

>http://alsa.opensrc.org/index.php?page=WritingAnAlsaDriver
> 
I already have the data sheet, the link above I will
look at.

> You mentioned using a Cyrix CPU. On a Windows-only 
I only mentioned this to explain why I take so long to 
experiment with the driver. Compilation is slooowww....

> I think I've got an old ISA Opti 931 card (purchased new for $7) in a box at 
> home. I can help debug things if neccesary. 

That would be nice. Maybe you will experience the same 
problem as I have and a solution will be quicker to find.

Oh well, "back to the drawing board".

Once again thanks for the feedback.

Regards.
Hugo Ferreira.

> 
> De: Mark Rages <markrages@mlug.missouri.edu>
> Data: 12/08/2002 23:43:02
> Para: hugo.ferreira@mail.telepac.pt
> CC: Takashi Iwai <tiwai@suse.de>,  alsa-devel@alsa-project.org
> Assunto: Re: Re: [Alsa-devel] Opti 931: Med931 ver.2.0
> 
> On Mon, Aug 12, 2002 at 10:30:15AM +0100, hugo.ferreira@mail.telepac.pt wrote:
> > Hi Takashi, Massimo, anyone
> > 
> > Takashi, in response to this last e-mail I patially solved the
> > problem. Just to be in the safe side, I:
> >
> > 1. cleaned the rc2 installation.
> > 2. downloaded the cvs version again (10-08-2002)
> > 3. did a ?./cvscompile?
> > 4. did a ?make install?
> > 
> > It all went fine. I then proceeded to insert ?snd_printk? statements
> > in the code of the drive to see what was happening. The process is 
> > slow and somewhat stressfull 8-[ (Cyrix 200+ with 64Mega). I would 
> > like to know:
> >
> > 1. How may I compile/make and install just the modules that I am 
> > interested in (--with-card ?)
> 
> You can use --with-cards or edit a file in the root directory of the alsa 
> kernel source. sorry, can't remember the name and I'm not on my home 
> computer right now.
> 
> > 2. Do  have to ./cvscompile all the time? I did try just using 
> > ?make? after the 1st config, but this did  not seem to work.
> 
> Seems like I did "make modules" and "make modules install" just like
> when building the Linux kernel. this could be wrong.
>  
> > 3. Do you have any pointers on debugging ALSA diver module? I am sorry
> > but my experioence in this platform is somewhat lacking (make.
> > autoconfig, etc.).
> 
> This is all I've got:
> 
> http://alsa.opensrc.org/index.php?page=WritingAnAlsaDriver
> 
> Read the book linked from above, particualarly the section on debugging.
> 
> Datasheet: ftp://ftp.alsa-project.org/pub/datasheets/opti/82c931.pdf
> 
> I think I've got an old ISA Opti 931 card (purchased new for $7) in a box at 
> home. I can help debug things if neccesary. 
> 
> You mentioned using a Cyrix CPU. On a Windows-only mailing list I'm on, many
> people talk about drivers that only work on certain CPUs. I've never heard
> anything like that on Linux. This is due either to my ignorance, or to Windows 
> users' cluelessness ("Blame the CPU!") or some technical factor I'm not aware 
> of.
> 
> Regards,
> Mark
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Dice - The leading online job board
> for high-tech professionals. Search and apply for tech jobs today!
> http://seeker.dice.com/seeker.epl?rel_code=31
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
