From: Andrei Boros <andrei@srr.ro>
Subject: Re: alsa-driver parse error
Date: Mon, 10 Mar 2003 13:22:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E6C756E.2EDEA9EB@srr.ro>
References: <Pine.LNX.4.44.0303101113450.1071-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from dingo.srr.ro ([212.54.107.183])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA28115
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2003 12:23:00 +0100
Received: from srr.ro
         by dingo.srr.ro (8.9.3/8.9.3) with ESMTP id NAA28246
         for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2003 13:22:23 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


CVS update 5 min. ago gives the following error when attempting driver
compilation with cs46xx and opti92x-ad1848 :

gcc -D__KERNEL__ -DMODULE=1
-I/serve/install/alsa-cvs/alsa-driver/include  -I/usr/src/linux/include
-O2 -march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  
-DEXPORT_SYMTAB -c sound.c
In file included from ../alsa-kernel/core/sound.c:29,
                 from sound.c:1:
/serve/install/alsa-cvs/alsa-driver/include/sound/version.h:6: warning:
`CONFIG_SND_VERSION' redefined
/serve/install/alsa-cvs/alsa-driver/include/sound/version.h:3: warning:
this is the location of the previous definition
In file included from ../alsa-kernel/core/sound.c:29,
                 from sound.c:1:
/serve/install/alsa-cvs/alsa-driver/include/sound/version.h:1: parse
error before `<'
In file included from
/serve/install/alsa-cvs/alsa-driver/include/sound/control.h:25,
                 from ../alsa-kernel/core/sound.c:30,
                 from sound.c:1:
/serve/install/alsa-cvs/alsa-driver/include/sound/asound.h:88: parse
error before `}'
/serve/install/alsa-cvs/alsa-driver/include/sound/asound.h:804: field
`iec958' has incomplete type
make[1]: *** [sound.o] Error 1
make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-driver/acore'




-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
