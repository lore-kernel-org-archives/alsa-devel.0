From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: [patch] c-media 9880 hda codec id
Date: Wed, 16 Mar 2005 02:17:50 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D697@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Received: from cm-msg-02.cmedia.com.tw (61-30-17-228.static.tfn.net.tw [61.30.17.228])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0BE9C1FF
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2005 20:06:36 +0100 (MET)
Content-Class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Following change need to be added for newer C-Media 9880 codec ID.

	Signed-off-by: ChenLi Tien <cltien@cmedia.com.tw>

Index: hda_codec.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_codec.c,v
retrieving revision 1.6
diff -a -u -r1.6 hda_codec.c
--- hda_codec.c 22 Feb 2005 17:17:57 -0000      1.6
+++ hda_codec.c 15 Mar 2005 17:22:04 -0000
@@ -50,6 +50,7 @@
 static struct hda_vendor_id hda_vendor_ids[] =3D {
        { 0x10ec, "Realtek" },
        { 0x434d, "C-Media" },
+       { 0x13f6, "C-Media" },
        {} /* terminator */
 };
=20
Index: patch_cmedia.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_cmedia.c,v
retrieving revision 1.3
diff -a -u -r1.3 patch_cmedia.c
--- patch_cmedia.c      22 Feb 2005 17:53:32 -0000      1.3
+++ patch_cmedia.c      15 Mar 2005 17:22:04 -0000
@@ -616,5 +616,6 @@
  */
 struct hda_codec_preset snd_hda_preset_cmedia[] =3D {
        { .id =3D 0x434d4980, .name =3D "CMI9880", .patch =3D =
patch_cmi9880 },
+       { .id =3D 0x13f69880, .name =3D "CMI9880", .patch =3D =
patch_cmi9880 },
        {} /* terminator */
 };







-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
