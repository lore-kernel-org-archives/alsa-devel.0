From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib-0.9.0rc4
Date: Wed, 23 Oct 2002 09:42:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210230941280.5772-100000@pnote.perex-int.cz>
References: <3DB5D296.4020006@t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DB5D296.4020006@t-online.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Wolfgang Teichmann <wal_teichmann@t-online.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Oct 2002, Wolfgang Teichmann wrote:

> Hallo,
> 
> I have problems to compile alsa-lib-0.9.0rc4 (RedHat 8.0)
> 
> 
> make[2]: Wechsel in das Verzeichnis Verzeichnis 
> /mnt/archiv/AAA/SOUND/ALSA/stable/alsa-lib-0.9.0rc4/src
> /bin/sh ../libtool --mode=link gcc  -g -O2 -Wl,--version-script=Versions 
> -o libasound.la -rpath /usr/lib -version-info 2:0:0 conf.lo confmisc.lo 
> input.lo output.lo async.lo error.lo dlmisc.lo control/libcontrol.la 
> mixer/libmixer.la pcm/libpcm.la                       
> rawmidi/librawmidi.la timer/libtimer.la               hwdep/libhwdep.la 
> seq/libseq.la instr/libinstr.la               compat/libcompat.la -lm 
> -ldl -lpthread              
> rm -fr .libs/libasound.la .libs/libasound.* .libs/libasound.*
> gcc -shared  conf.lo confmisc.lo input.lo output.lo async.lo error.lo 
> dlmisc.lo -Wl,--whole-archive control/.libs/libcontrol.al 
> mixer/.libs/libmixer.al pcm/.libs/libpcm.al rawmidi/.libs/librawmidi.al 
> timer/.libs/libtimer.al hwdep/.libs/libhwdep.al seq/.libs/libseq.al 
> instr/.libs/libinstr.al compat/.libs/libcompat.al 
> -Wl,--no-whole-archive  -lm -ldl -lpthread -lc  -Wl,-soname 
> -Wl,libasound.so.2 -o .libs/libasound.so.2.0.0
> /usr/bin/ld: .libs/libasound.so.2.0.0: undefined versioned symbol name 
> snd_pcm_hw_params_get_rate_min@ALSA_0.9.0rc4

Seems like that something is broken, but we need to figure what. Anyway, 
you can build library with './configure --with-versioned=no'. It should 
work for all binutils, but it's not a very nice solution.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
