From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: minor bug in make-install target
Date: Sun, 10 Feb 2002 12:59:12 +0100
Message-ID: <3C666090.52D64A93@folkwang-hochschule.de>
References: <3C591414.4FFDF135@folkwang-hochschule.de> <s5h3d0mzemh.wl@alsa1.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> Hi,
> 
> At Thu, 31 Jan 2002 10:53:24 +0100,
> Jörn Nettingsmeier wrote:
> >
> > hello jaroslav !
> >
> > i just found a minor bug in the make install target of alsa-driver:
> >
> > on my system, /usr/src is a link to /data1/src (which is another
> > disk).
> >
> > i have alsa sources on /usr/src/alsa-cvs/alsa-driver
> >
> > when i "make install" the kernel modules, i end up with
> > /lib/modules/<version>/kernel/sound/data1/src/alsa-cvs/alsa-driver/{acore,pci,synth}
> >
> > is it possible to fix the script so that it uses the correct paths
> > even when it's a link ?
> >
> > btw, i also tried a relative link (src -> ../data/src), but the
> > problem remains.
> >
> > moving the module tree by hand works for me, and it might not be
> > worth fixing when the stuff goes into the kernel anyway, but i
> > thought you might want to know.
> 
> I fixed on cvs.
> 
> now Rules.make guesses the destination directory from TREETOPDIR
> variable, which is exported from the toplevel Makefile, so that TOPDIR
> defined in each sub directory doesn't matter.
> 
> this mechanism seems working at least on my system.
> please give a try.

hi takashi !

sorry for the long delay. i have just checked out alsa-cvs again,
and the problem remains.
i still get
/lib/modules/2.4.18-pre9/kernel/sound/data1/src/alsa-cvs/alsa-driver/{pci,acore,synth}

regards,

jörn



-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
