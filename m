From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib linking problem
Date: Mon, 10 Mar 2003 15:01:21 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303101458150.1303-100000@pnote.perex-int.cz>
References: <3E6C7668.63989415@srr.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E6C7668.63989415@srr.ro>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrei Boros <andrei@srr.ro>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Mar 2003, Andrei Boros wrote:

> 
>  Latest cvs alsa-lib compiles ok up to a point where the linker fails on
> a library:
> 
> gcc -shared  conf.lo confmisc.lo input.lo output.lo async.lo error.lo
> dlmisc.lo -Wl,--whole-archive control/.libs/libcontrol.al
> mixer/.libs/libmixer.al pcm/.libs/libpcm.al rawmidi/.libs/librawmidi.al
> timer/.libs/libtimer.al hwdep/.libs/libhwdep.al seq/.libs/libseq.al
> instr/.libs/libinstr.al compat/.libs/libcompat.al
> -Wl,--no-whole-archive  -lm -ldl -lpthread -lc  -Wl,-soname
> -Wl,libasound.so.2 -o .libs/libasound.so.2.0.0
> /usr/i386-slackware-linux/bin/ld: .libs/libasound.so.2.0.0: undefined
> versioned symbol name snd_pcm_forward@@ALSA_0.9.0rc8
> /usr/i386-slackware-linux/bin/ld: failed to set dynamic section sizes:
> Bad value
> collect2: ld returned 1 exit status
> make[2]: *** [libasound.la] Error 1
> make[2]: Leaving directory `/serve/install/alsa-cvs/alsa-lib/src'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-lib/src'
> make: *** [all-recursive] Error 1

It looks like libtool problem. The 1.4.2 version is ok.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
