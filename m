From: Eamon Roque <Eamon.Roque@arf.fak12.uni-muenchen.de>
Subject: azt2320 and kernel 2.5.6x
Date: 31 Mar 2003 20:38:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049135910.857.8.camel@saurafix.arf.fak12.uni-muenchen.de>
References: <E18zxfE-0007F1-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: Quoted-Printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18zxfE-0007F1-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

I'm getting the same error messages as some other people on the list
while compiling the alsa drivers with 2.5.6x with the azt2320 driver.
I'm running a freshly updated Debian Woody.=20

gcc -Wp,-MD,sound/isa/.azt2320.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
-iwithprefix include -DMODULE   -DKBUILD_BASENAME=3Dazt2320
-DKBUILD_MODNAME=3Dsnd_azt2320 -c -o
sound/isa/azt2320.o sound/isa/azt2320.c
sound/isa/azt2320.c: In function `snd_card_azt2320_isapnp':
sound/isa/azt2320.c:162: warning: implicit declaration of function
`isapnp_find_dev'
sound/isa/azt2320.c:162: warning: assignment makes pointer from integer
without a cast
sound/isa/azt2320.c:163: structure has no member named `active'
sound/isa/azt2320.c:167: warning: assignment makes pointer from integer
without a cast
sound/isa/azt2320.c:168: structure has no member named `active'
sound/isa/azt2320.c:174: structure has no member named `prepare'
sound/isa/azt2320.c:178: warning: implicit declaration of function
`isapnp_resource_change'
sound/isa/azt2320.c:193: structure has no member named `activate'
sound/isa/azt2320.c:206: structure has no member named `prepare'
sound/isa/azt2320.c:218: structure has no member named `activate'
sound/isa/azt2320.c: In function `snd_card_azt2320_deactivate':
sound/isa/azt2320.c:234: structure has no member named `deactivate'
sound/isa/azt2320.c:236: structure has no member named `deactivate'
sound/isa/azt2320.c: In function `alsa_card_azt2320_init':
sound/isa/azt2320.c:394: warning: implicit declaration of function
`isapnp_probe_cards'
make[2]: *** [sound/isa/azt2320.o] Fehler 1
make[1]: *** [sound/isa] Fehler 2
make: *** [sound] Fehler 2

Could someone help me out in some way?! Is this really because of a
change in the isapnp code?!

Thanks in advance!

Eamon Roque.
IT-G Geisteswissenschaften
LMU M=C3=BCnchen





-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
