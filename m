From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: FIXED: minor bug in make-install target
Date: Tue, 12 Feb 2002 21:07:45 +0100
Message-ID: <3C697611.A908BE03@folkwang-hochschule.de>
References: <3C591414.4FFDF135@folkwang-hochschule.de>
		<s5h3d0mzemh.wl@alsa1.suse.de>
		<3C666090.52D64A93@folkwang-hochschule.de>
		<s5hwuxkxott.wl@alsa2.suse.de>
		<3C67D4BF.C3ECFA56@folkwang-hochschule.de> <s5hpu3cxdl7.wl@alsa2.suse.de>
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
> > > > > At Thu, 31 Jan 2002 10:53:24 +0100,
> > > > > Jörn Nettingsmeier wrote:
> > > > > >
> > > > > > hello jaroslav !
> > > > > >
> > > > > > i just found a minor bug in the make install target of alsa-driver:
> > > > > >
> > > > > > on my system, /usr/src is a link to /data1/src (which is another
> > > > > > disk).
> > > > > >
> > > > > > i have alsa sources on /usr/src/alsa-cvs/alsa-driver
> > > > > >
> > > > > > when i "make install" the kernel modules, i end up with
> > > > > > /lib/modules/<version>/kernel/sound/data1/src/alsa-cvs/alsa-driver/{acore,pci,synth}

> > > please check whether your MAINSRCDIR is defined in Makefile.conf
> > > correctly, in your case, /data1/src/alsa-cvs/alsa-driver.
> > > the latest Rules.make reduces the path name according to this
> > > variable.  it's possbile that the path name is different due to
> > > symlinks..
> >
> > i have
> > mainsrcdir      = .
> > MAINSRCDIR      = /usr/src/alsa-cvs/alsa-driver
> >
> > that's probably because i go to that directory via cd
> > /usr/src/alsa-cvs/alsa-driver.
> > how come the makefile ever knows we are in /data1/src ?
> > pwd reports /usr/...
> 
> is /data1/src is symlinked to /usr/src? 

the other way round:
#ls -ld /usr/src
lrwxrwxrwx    1 root     root           13 Jan 31 10:49 /usr/src ->
../data1/src/

> what says /bin/pwd instead of built-in pwd?

ooooh shit !

nettings@kleineronkel:/usr/src > pwd
/usr/src
nettings@kleineronkel:/usr/src > /bin/pwd
/data1/src

i wasn't even aware that bash has a built-in pwd. good guess, watson
!

> if this inconsistency really comes from the different pwd's, then the
> attached patch might solve the problem...

it does indeed. thanks heaps !

best regards,

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
