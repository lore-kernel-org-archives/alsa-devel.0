From: Paul Davis <paul@linuxaudiosystems.com>
Subject: issues with pnp code
Date: Fri, 9 May 2003 13:13:25 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305091713.h49HDPc08255@linuxaudiosystems.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

this is from trying to build alsa cvs snapshot apr-27th:

cvscompile --with-cards=virmidi,trident,rme9652,hdsp --with-oss=yes --with-sequencer=yes

gcc -D__KERNEL__ -DMODULE=1 -I/usr/local/music/src/alsa-cvs/older/alsa-driver/include  -I/lib/modules/2.4.20/build/include -O2 -mpreferred-stack-boundary=2 -march=i686 -D__SMP__ -DCONFIG_SMP -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD   -DEXPORT_SYMTAB -c pnp.c
pnp.c:130: redefinition of `pnp_request_card_device'
pnp.h:203: `pnp_request_card_device' previously defined here
pnp.c:143: redefinition of `pnp_release_card_device'
pnp.h:204: `pnp_release_card_device' previously defined here
pnp.c:150: redefinition of `pnp_register_card_driver'
pnp.h:205: `pnp_register_card_driver' previously defined here
pnp.c:199: redefinition of `pnp_unregister_card_driver'
pnp.h:206: `pnp_unregister_card_driver' previously defined here
pnp.c:218: redefinition of `pnp_register_driver'
pnp.h:207: `pnp_register_driver' previously defined here
pnp.c:249: redefinition of `pnp_unregister_driver'
pnp.h:208: `pnp_unregister_driver' previously defined here
pnp.c:267: redefinition of `pnp_init_resource_table'
pnp.h:209: `pnp_init_resource_table' previously defined here
pnp.c:297: redefinition of `pnp_manual_config_dev'
pnp.h:210: `pnp_manual_config_dev' previously defined here
pnp.c:328: redefinition of `pnp_activate_dev'
pnp.h:211: `pnp_activate_dev' previously defined here
make[2]: *** [pnp.o] Error 1
make[2]: Leaving directory `/usr/local/music/src/alsa-cvs/older/alsa-driver/support/pnp'

i explicitly told cvscompile to drop isapnp (--with-isapnp=no) and it
went away. my kernel has:

.config:

#
# Plug and Play configuration
#
CONFIG_PNP=m
CONFIG_ISAPNP=m


include/linux/autoconf.h:

/*
 * Plug and Play configuration
 */
#undef  CONFIG_PNP
#define CONFIG_PNP_MODULE 1
#undef  CONFIG_ISAPNP
#define CONFIG_ISAPNP_MODULE 1


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
