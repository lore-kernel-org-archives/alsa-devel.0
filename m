From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Where did my PCM devices go (using devfs)?
Date: Sat, 17 May 2003 14:55:06 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030517135506.72308.qmail@web40608.mail.yahoo.com>
References: <Pine.LNX.4.44.0305171513480.21997-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0305171513480.21997-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Jaroslav Kysela <perex@suse.cz> wrote:
> Oops. I forget to move devfs stuff. Please, could
> you try CVS again? Thank you.

Not there yet..

gcc -D__KERNEL__ -DMODULE=1
-I/home/chris/Programs/alsa/alsa-driver/include 
-I/home/chris/linux-2.4.20/include -O2
-mpreferred-stack-boundary=2 -march=i686 -D__SMP__
-DCONFIG_SMP -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  
-DEXPORT_SYMTAB -c sound.c
In file included from sound.c:1:
../alsa-kernel/core/sound.c: In function
`snd_register_device_Rsmp_5921fc53':
../alsa-kernel/core/sound.c:219: warning: passing arg
1 of `strcpy' from incompatible pointer type
../alsa-kernel/core/sound.c:229: `dname' undeclared
(first use in this function)
../alsa-kernel/core/sound.c:229: (Each undeclared
identifier is reported only once
../alsa-kernel/core/sound.c:229: for each function it
appears in.)
In file included from sound.c:1:
../alsa-kernel/core/sound.c: In function
`snd_unregister_device_Rsmp_2c38f31f':
../alsa-kernel/core/sound.c:263: `name' undeclared
(first use in this function)
make[1]: *** [sound.o] Error 1
make[1]: Leaving directory
`/home/chris/Programs/alsa/alsa-driver/acore'
make: *** [compile] Error 1


__________________________________________________
Yahoo! Plus
For a better Internet experience
http://www.yahoo.co.uk/btoffer


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
