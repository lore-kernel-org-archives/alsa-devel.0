From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/isa cmi8330.c,1.10,1.11
Date: Mon, 16 Sep 2002 09:22:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2sn0acsa8.fsf@vador.mandrakesoft.com>
References: <E17qVU2-0005tc-00@usw-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vador.mandrakesoft.com (office.mandrakesoft.com [195.68.114.34])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA08721
	for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2002 09:21:27 +0200
In-Reply-To: <E17qVU2-0005tc-00@usw-pr-cvs1.sourceforge.net> (Jaroslav
 Kysela's message of "Sun, 15 Sep 2002 02:14:26 -0700")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=

Jaroslav Kysela <perex@users.sourceforge.net> writes:

> Update of /cvsroot/alsa/alsa-kernel/isa
> In directory usw-pr-cvs1:/tmp/cvs-serv22649
>
> Modified Files:
> 	cmi8330.c 
> Log Message:
> fix nor non-IsaPnP build

wouldn't something like this (untesterd) be better than redefining
isapnp_* ?


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=cmi_vs_isa.diff

Index: isa/Config.in
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/Config.in,v
retrieving revision 1.6
diff -u -3 -p -r1.6 Config.in
--- isa/Config.in	24 Jul 2002 10:42:17 -0000	1.6
+++ isa/Config.in	16 Sep 2002 07:19:37 -0000
@@ -28,7 +28,7 @@ fi
 dep_tristate 'Turtle Beach Maui,Tropez,Tropez+ (Wavefront)' CONFIG_SND_WAVEFRONT $CONFIG_SND
 dep_tristate 'Avance Logic ALS100/ALS120' CONFIG_SND_ALS100 $CONFIG_SND $CONFIG_ISAPNP
 dep_tristate 'Aztech Systems AZT2320' CONFIG_SND_AZT2320 $CONFIG_SND $CONFIG_ISAPNP
-dep_tristate 'C-Media CMI8330' CONFIG_SND_CMI8330 $CONFIG_SND
+dep_tristate 'C-Media CMI8330' CONFIG_SND_CMI8330 $CONFIG_SND CONFIG_ISAPNP
 dep_tristate 'Diamond Technologies DT-019X, Avance Logic ALS-007' CONFIG_SND_DT019X $CONFIG_SND $CONFIG_ISAPNP
 dep_tristate 'Yamaha OPL3-SA2/SA3' CONFIG_SND_OPL3SA2 $CONFIG_SND
 dep_tristate 'Aztech Sound Galaxy' CONFIG_SND_SGALAXY $CONFIG_SND

--=-=-=--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
