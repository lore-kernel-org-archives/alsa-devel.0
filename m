From: Gregoire Favre <greg@magma.unil.ch>
Subject: emu10k1-pointer-bug-fix.dif
Date: Thu, 7 Aug 2003 14:51:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030807125113.GF1871@greg.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

I want to use the http://bitstreamout.sourceforge.net/ and in it there
is a dif about a bug:

Index: alsa-kernel/pci/emu10k1/emupcm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /suse/tiwai/cvs/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.20
diff -u -r1.20 emupcm.c
--- alsa-kernel/pci/emu10k1/emupcm.c	9 Apr 2003 14:58:28 -0000	1.20
+++ alsa-kernel/pci/emu10k1/emupcm.c	24 Apr 2003 09:59:19 -0000
@@ -666,8 +666,11 @@
 #else	/* EMU10K1 Open Source code from Creative */
 	if (ptr < epcm->ccca_start_addr)
 		ptr +=3D runtime->buffer_size - epcm->ccca_start_addr;
-	else
+	else {
 		ptr -=3D epcm->ccca_start_addr;
+		if (ptr >=3D runtime->buffer_size)
+			ptr -=3D runtime->buffer_size;
+	}
 #endif
 	// printk("ptr =3D 0x%x, buffer_size =3D 0x%x, period_size =3D 0x%x\n",=
 ptr, runtime->buffer_size, runtime->period_size);
 	return ptr;

I have just checked my 2.6.0-test2-bk4 kernel, and it seems it's not
applied: is it really a bug, should I really apply it?

Thank you very much,

	Gr=E9goire
__________________________________________________________________
http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
