From: Clemens Ladisch <clemens@ladisch.de>
Subject: [BUG] (non-)PnP oopses
Date: Fri, 11 Apr 2003 08:36:14 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0304110835130.10925-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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


1) The card drivers terminate their pnp_card_device_id tables with an
entry containing an empty id string:
	{ .id = "" }
but pnp_register_card_driver() in pnp.c expects a NULL id string as
terminator. When no entry matches (e.g. snd-opti92x-ad1848 with a
non-PnP Mozart card), pnp_register_card_driver() runs off the end of
the table and oopses.

2) When snd-opti92x-ad1848 gets loaded for a non-PnP card,
alsa_card_opti9xx_init() will call snd_card_opti9xx_probe() with NULL
parameters. When, additionally, the isapnp module parameter has its
default value of 1, snd_card_opti9xx_pnp() will be called with NULL
parameters, and die.


Clemens




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
