From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: ALSA + jack + xrun = kernel crash
Date: Sat, 17 May 2003 08:27:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19H0hA-0002q5-00@sc8-sf-list1.sourceforge.net>
References: <1053136440.1197.213.camel@newbie.localnet.local>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "16 May 2003 20:54:01 CDT."
             <1053136440.1197.213.camel@newbie.localnet.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arthur Peters <amp@singingwizard.org>
Cc: Alsa dev list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Hello, I am experiencing a reletivly hard crash (SysRq works but SysRq-B
>prints a message saying it will reboot then doesn't). The crash happens
  [ ... ]
>My hardware is:
>Dual PIII 1Ghz with 512M RAM on a Tyan MB.
  [ .... ]
>My software is:
>ALSA drivers 0.9.3a or current CVS

current CVS (and presumably 0.9.3a) has a severe bug with SMP
systems. i reported it last week, along with as much output as i could
get from my machine when it locked up. nobody has been able to do
anything about it since then.

you will need to back to the cvs snapshot of april 27th to get a
working version for SMP systems.

jaroslav or takashi - any ideas about fixing this?


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
