From: Giuliano Pochini <pochini@shiny.it>
Subject: .dimen ?
Date: 18 May 2003 17:05:33 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053277534.1358.7.camel@Jay>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-BJaucjQq/ffwiT4+W4kU"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-BJaucjQq/ffwiT4+W4kU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



In struct sndrv_ctl_elem_info what is the union .dimen for ?  A grep(1)
in all sources show that it's referenced only in
snd_ctl_elem_info_get_dimension() and
snd_ctl_elem_info_get_dimensions(). The latter seems quite buggy (patch
against 0.9.3 is attached).

Bye.


--=-BJaucjQq/ffwiT4+W4kU
Content-Disposition: attachment; filename=patch.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=patch.txt; charset=ISO-8859-1

--- ./src/control/control.c.old	Sun May 18 16:53:36 2003
+++ ./src/control/control.c	Sun May 18 16:55:59 2003
@@ -1699,10 +1699,10 @@
 	assert(obj);
 	if (obj->access & SNDRV_CTL_ELEM_ACCESS_DINDIRECT)
 		return 0;			/* FIXME: implement indirect access as well */
-	for (i =3D 3; i >=3D 0; i++)
-		if (obj->dimen.d[0])
-			break;
-	return i >=3D 0 ? i + 1 : 0;
+	for (i =3D 3; i >=3D 0; i--)
+		if (obj->dimen.d[i])
+			return(i+1);
+	return 0;
 }
 use_default_symbol_version(__snd_ctl_elem_info_get_dimensions, snd_ctl_ele=
m_info_get_dimensions, ALSA_0.9.3);
=20


--=-BJaucjQq/ffwiT4+W4kU--



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
