From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib cvs version fails to compile
Date: Wed, 5 Mar 2003 13:31:46 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051331090.1014-100000@pnote.perex-int.cz>
References: <3E65B16B.2DB7080D@srr.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E65B16B.2DB7080D@srr.ro>
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

On Wed, 5 Mar 2003, Andrei Boros wrote:

> 
>  On a Slackware 7.0 system, kernel 2.2.23 I have the following
> situation:
> 
> alsa-0.9-rc7 works (driver, lib, tools).
> 
> Due to some isapnp related problems, Takashi Iwai sent me a patch and
> asked me to try in on the cvs version. While I still have problems with
> the driver part, when I tried to compile alsa-lib from cvs I get the
> following errors:
> 
> cd alsa-lib
> ./cvscompile
> -----------------------------------------------------------------------------------
> gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -O2 -Wall -W
> -pipe -g -Wp,-MD,.deps/timer_query.pp -c  -fPIC -DPIC timer_query.c -o
> timer_query.lo
> {standard input}: Assembler messages:
> {standard input}:3105: Error: invalid attempt to declare external
> version name as default in symbol `snd_timer_query_status@@ALSA_0.9.0'
> make[2]: *** [timer_query.lo] Error 1
> make[2]: Leaving directory `/serve/install/alsa-cvs/alsa-lib/src/timer'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-lib/src'
> make: *** [all-recursive] Error 1
> -----------------------------------------------------------------------------------

It should be fixed in CVS (but I don't know why GCC 3.2 doesn't report 
this problem).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
