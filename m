From: castet.matthieu@free.fr
Subject: intel8x0.c : missing define for disable midi
Date: Mon, 30 Aug 2004 09:12:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1093849936.4132d350e4835@imp5-q.free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ10938499368442b47f4de77281cbacb2efe3f48aa9"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from postfix3-2.free.fr (postfix3-2.free.fr [213.228.0.169])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C0B1C151
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2004 09:12:17 +0200 (MEST)
Received: from imp5-q.free.fr (imp5-q.free.fr [212.27.42.5])
	by postfix3-2.free.fr (Postfix) with ESMTP id 3A5CCC641
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2004 11:07:45 +0200 (CEST)
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

This message is in MIME format.

---MOQ10938499368442b47f4de77281cbacb2efe3f48aa9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi,
this patch add a missing define if you want to remove midi support form i=
t.

why removing midi and jostick support ?
Read the PS of
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D109377408705997&w=3D2,=
 and you
will see that midi and jostick work better with external modules.

Thanks

Matthieu
---MOQ10938499368442b47f4de77281cbacb2efe3f48aa9
Content-Type: text/x-patch; name="intel8x0.c-midi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="intel8x0.c-midi.patch"

LS0tIGxpbnV4LTIuNi44L3NvdW5kL3BjaS9pbnRlbDh4MC5jb3JnCTIwMDQtMDgtMjggMTk6Mjg6
NDEuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuOC9zb3VuZC9wY2kvaW50ZWw4eDAuYwky
MDA0LTA4LTI4IDE5OjI5OjIxLjAwMDAwMDAwMCArMDIwMApAQCAtMjY3MSw2ICsyNjcxLDcgQEAK
IAkJcmV0dXJuIGVycjsKIAl9CiAJCisjaWZkZWYgU1VQUE9SVF9NSURJCiAJaWYgKG1wdV9wb3J0
W2Rldl0gPT0gMHgzMDAgfHwgbXB1X3BvcnRbZGV2XSA9PSAweDMzMCkgewogCQlpZiAoKGVyciA9
IHNuZF9tcHU0MDFfdWFydF9uZXcoY2FyZCwgMCwgTVBVNDAxX0hXX0lOVEVMOFgwLAogCQkJCQkg
ICAgICAgbXB1X3BvcnRbZGV2XSwgMCwKQEAgLTI2ODAsNiArMjY4MSw3IEBACiAJCX0KIAl9IGVs
c2UKIAkJbXB1X3BvcnRbZGV2XSA9IDA7CisjZW5kaWYKIAogCXNwcmludGYoY2FyZC0+bG9uZ25h
bWUsICIlcyBhdCAweCVseCwgaXJxICVpIiwKIAkJY2FyZC0+c2hvcnRuYW1lLCBjaGlwLT5hZGRy
LCBjaGlwLT5pcnEpOwo=

---MOQ10938499368442b47f4de77281cbacb2efe3f48aa9--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
