From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] opl4 depends on opl3
Date: Sun, 5 Dec 2004 13:04:58 +0100
Message-ID: <20041205120458.GA461@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi,

support for OPL4 depends on OPL3, but it's not written in the Makefile.
Let's fix it.

bye,
martin


Summary:
Compiling OPL4 doesn't include the snd-opl3-lib. This change in the
Makefile enables now the compiling of snd-opl3-lib.o for OPL4 soundcards.

Signed-off-by: Martin Langer <martin-langer@gmx.de>



Index: alsa-kernel/drivers/opl3/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/opl3/Makefile,v
retrieving revision 1.22
diff -u -r1.22 Makefile
--- alsa-kernel/drivers/opl3/Makefile	2 Mar 2004 19:51:30 -0000	1.22
+++ alsa-kernel/drivers/opl3/Makefile	5 Dec 2004 11:42:00 -0000
@@ -18,4 +18,5 @@
 sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))
 
 obj-$(CONFIG_SND_OPL3_LIB) += snd-opl3-lib.o
+obj-$(CONFIG_SND_OPL4_LIB) += snd-opl3-lib.o
 obj-$(call sequencer,$(CONFIG_SND_OPL3_LIB)) += snd-opl3-synth.o


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
