From: Andrei Boros <andrei@srr.ro>
Subject: Re: cvs alsa-lib compilation :
Date: Wed, 24 Sep 2003 14:29:25 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F718015.6954A110@srr.ro>
References: <3F6EBB9E.C9C13190@srr.ro> <s5hbrtbr2i0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> >  gate:~/install/alsa-cvs/alsa-lib# ./cvscompile
> > configure.in:44: warning: do not use m4_patsubst: use patsubst or
> > m4_bpatsubst
> > configure.in:182: warning: do not use m4_regexp: use regexp or
> > m4_bregexp
> > autoheader: `include/config.h.in' is unchanged
> > CFLAGS=-O2 -Wall -W -pipe -g
> 
> ARGH, again autotools problem!
> 
> please tell me the version of automake, autoconf and libtool.
> and check which tool causes this error by running the sequence in
> cvscompile script manually.
> 

gate:~/install/alsa-cvs/alsa-utils/alsactl# automake --version
automake (GNU automake) 1.5

gate:~/install/alsa-cvs/alsa-utils/alsactl# autoconf --version
autoconf (GNU Autoconf) 2.53

gate:~/install/alsa-cvs/alsa-utils/alsactl# libtool --version
ltmain.sh (GNU libtool) 1.4.2 (1.922.2.53 2001/09/11 03:18:52)

Running each command in cvscompile : 

gate:~/install/alsa-cvs/alsa-lib# autoheader
configure.in:44: warning: do not use m4_patsubst: use patsubst or
m4_bpatsubst
configure.in:182: warning: do not use m4_regexp: use regexp or
m4_bregexp
autoheader: `include/config.h.in' is unchanged



-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
