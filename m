From: Andrei Boros <andrei@srr.ro>
Subject: Re: cvs alsa-lib compilation :
Date: Thu, 25 Sep 2003 06:46:22 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F72650E.71CFDEE1@srr.ro>
References: <3F6EBB9E.C9C13190@srr.ro>
		<s5hbrtbr2i0.wl@alsa2.suse.de>
		<3F718015.6954A110@srr.ro> <s5hn0cul1m4.wl@alsa2.suse.de>
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

A followup on my last post : 

I remove the symlinks in alsa-lib/src/control (which are broken).
make

/bin/sh ../../libtool --mode=link gcc  -O2 -Wall -W -pipe -g   -o
libcontrol.la   cards.lo hcontrol.lo control.lo control_hw.lo
control_shm.lo setup.lo control_symbols.lo
rm -fr .libs/libcontrol.la .libs/libcontrol.* .libs/libcontrol.*
(cd . && ln -s cards.lo cards.lo)
(cd . && ln -s hcontrol.lo hcontrol.lo)
(cd . && ln -s control.lo control.lo)
(cd . && ln -s control_hw.lo control_hw.lo)
(cd . && ln -s control_shm.lo control_shm.lo)
(cd . && ln -s setup.lo setup.lo)
(cd . && ln -s control_symbols.lo control_symbols.lo)
ar cru .libs/libcontrol.al cards.lo hcontrol.lo control.lo control_hw.lo
control_shm.lo setup.lo control_symbols.lo
ar: cards.lo: Too many levels of symbolic links
make[2]: *** [libcontrol.la] Error 1
make[2]: Leaving directory
`/serve/install/alsa-cvs/alsa-lib/src/control'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-lib/src'
make: *** [all-recursive] Error 1


-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
