From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [PATCH] update isapnp ids for sound galaxy
Date: Fri, 01 Mar 2002 14:14:46 +0100
Message-ID: <m2bse8toop.fsf@vador.mandrakesoft.com>
References: <m2k7swtoy2.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
In-Reply-To: <m2k7swtoy2.fsf@vador.mandrakesoft.com> (Thierry Vignaud's message of "Fri, 01 Mar 2002 14:09:09 +0100")
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

Thierry Vignaud <tvignaud@mandrakesoft.com> writes:

> this patch update an unknown yamaha opl3 id that is unknown to alsa
> but known to harddrake:

another one, for sound galaxy:


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=alsa.diff

--- /home/tv/azt2320.c	Fri Mar  1 14:13:02 2002
+++ alsa-driver-0.9.0beta12/alsa-kernel/isa/azt2320.c	Fri Mar  1 14:13:31 2002
@@ -134,7 +134,7 @@
 static struct isapnp_card_id snd_azt2320_pnpids[] __devinitdata = {
 	/* PRO16V */
 	ISAPNP_AZT2320('A','Z','T',0x1008,0x1008,0x2001),
-	/* --- */
+	/* Aztech Sound Galaxy 16 */
 	ISAPNP_AZT2320('A','Z','T',0x2320,0x0001,0x0002),
 	/* Packard Bell Sound III 336 AM/SP */
 	ISAPNP_AZT2320('A','Z','T',0x3000,0x1003,0x2001),

--=-=-=--


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
