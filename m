From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [PATCH] update isapnp ids
Date: Fri, 01 Mar 2002 14:09:09 +0100
Message-ID: <m2k7swtoy2.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=-=-=

this patch update an unknown yamaha opl3 id that is unknown to alsa
but known to harddrake:


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=alsa.diff

--- /tmp/opl3sa2.c	Fri Mar  1 14:06:21 2002
+++ alsa-driver-0.9.0beta12/alsa-kernel/isa/opl3sa2.c	Fri Mar  1 14:06:39 2002
@@ -177,7 +177,7 @@
 	ISAPNP_OPL3SA2('Y','M','H',0x0020,0x0021),
 	/* Yamaha OPL3-SA3 (integrated on Intel's Pentium II AL440LX motherboard) */
 	ISAPNP_OPL3SA2('Y','M','H',0x0030,0x0021),
-	/* ??? */
+	/* Yamaha OPL3-SA2 */
 	ISAPNP_OPL3SA2('Y','M','H',0x0800,0x0021),
 	/* NeoMagic MagicWave 3DX */
 	ISAPNP_OPL3SA2('N','M','X',0x2200,0x2210),

--=-=-=--


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
