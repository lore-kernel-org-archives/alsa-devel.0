From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: Re: current cvs, unresolved symbol in snd-msnd-pinnacle.o
Date: Sat, 20 Jul 2002 00:06:30 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020719220630.34677.qmail@web12207.mail.yahoo.com>
References: <200207192045.NAA16694@cmn29.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200207192045.NAA16694@cmn29.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,

snd-msnd-pinnacle behaves better now after changing
alsa-kernel/core/sound.c a bit:

(last lines of the file here:)
>>>
  /* wrappers */
#ifdef CONFIG_SND_DEBUG_MEMORY
EXPORT_SYMBOL(snd_wrapper_kmalloc);
EXPORT_SYMBOL(snd_wrapper_kfree);
EXPORT_SYMBOL(snd_wrapper_vmalloc);
EXPORT_SYMBOL(snd_wrapper_vfree);
#endif
#ifdef HACK_PCI_ALLOC_CONSISTENT
EXPORT_SYMBOL(snd_pci_hack_alloc_consistent);
#endif
<<<

Takashi, please put the additional two lines
 EXPORT_SYMBOL(snd_wrapper_vmalloc);
 EXPORT_SYMBOL(snd_wrapper_vfree);
into cvs.

ciao, 
karsten

 --- Fernando Pablo Lopez-Lezcano
<nando@ccrma.Stanford.EDU> schrieb: > > > Found this
last evening, just confirmed it is
> still there:
> > >
> > > # depmod -ae
> > > depmod: *** Unresolved symbols in
> > >
>
/lib/modules/2.4.18-11.ll/kernel/drivers/sound/isa/msnd/snd-msnd-pinnacle.o
> > > depmod: 	vfree
> >
> > i hope it's fixed on cvs now.  please give a try.
> 
> Not there yet, sorry... :-(
> 
> # depmod -ae
> depmod: *** Unresolved symbols in  
>
/lib/modules/2.4.18-11.ll/kernel/drivers/sound/isa/msnd/snd-msnd-pinnacle.o
> depmod: 	snd_wrapper_vfree
> 
> -- Fernando
> 
> 
>
-------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel 

__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
