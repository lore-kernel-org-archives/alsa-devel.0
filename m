From: Paul Davis <paul@linuxaudiosystems.com>
Subject: PnP code causes build failure?
Date: Tue, 8 Apr 2003 10:57:32 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304081457.h38EvW014624@linuxaudiosystems.com>
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

Just updated from CVS. Using 2.4.20 with gcc 2.95.3.

two things related to PnP that are causing problems. First, at
configure time:

----------------------------------------------------------------------
checking for PnP driver in kernel... no
checking for ISA PnP support... yes
./configure: test: ==: binary operator expected
Symlinking <linux/isapnp.h>...
./configure: test: ==: binary operator expected
Symlinking <linux/pnp.h>...
----------------------------------------------------------------------

then, at compile time, even asking only for non-PnP cards:

----------------------------------------------------------------------
pnp.c: In function `parse_id':
pnp.c:110: `ISAPNP_ANY_ID' undeclared (first use in this function)
pnp.c:110: (Each undeclared identifier is reported only once
pnp.c:110: for each function it appears in.)
pnp.c: At top level:
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
----------------------------------------------------------------------


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
