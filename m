From: castet.matthieu@free.fr
Subject: intel8x0.c AC97_TUNE_HP_ONLY quirk bug for Fujitsu-Siemens E4010
Date: Mon, 30 Aug 2004 09:04:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1093849444.4132d1642f7cf@imp5-q.free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ109384944472be402305519132a088e1819cce0de0"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from postfix4-1.free.fr (postfix4-1.free.fr [213.228.0.62])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AC5EF29A
	for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2004 22:57:44 +0200 (MEST)
Received: from imp4-q.free.fr (imp4-q.free.fr [212.27.42.4])
	by postfix4-1.free.fr (Postfix) with ESMTP id 52B3B18231F
	for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2004 22:57:44 +0200 (CEST)
Resent-To: alsa-devel@alsa-project.org
Resent-Message-ID: <1093985864.4134e648294b7@imp4-q.free.fr>
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

---MOQ109384944472be402305519132a088e1819cce0de0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Hi,
my Fujitsu-Siemens E4010 need AC97_TUNE_HP_ONLY.
I did a patch that add its id the the list, but I don't know if all the c=
omputer
that have a chip with this id need this fix, so I attach also the result =
of
lspci -vn in case you are interested in subdevice id.

Thanks

Matthieu
---MOQ109384944472be402305519132a088e1819cce0de0
Content-Type: text/x-patch; name="intel8x0.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="intel8x0.c.patch"


LS0tIGxpbnV4LTIuNi43L3NvdW5kL3BjaS9pbnRlbDh4MC5jLm9yZwkyMDA0LTA4LTE1IDEyOjEz
OjIyLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42Ljcvc291bmQvcGNpL2ludGVsOHgwLmMJ
MjAwNC0wOC0yOCAxOToxNDowNi4xNjkzNzM3ODQgKzAyMDAKQEAgLTE3ODMsNiArMTc4MywxMiBA
QAogCX0sCiAJewogCQkudmVuZG9yID0gMHg4MDg2LAorCQkuZGV2aWNlID0gMHgyNGM1LAorCQku
bmFtZSA9ICJGdWppdHN1LVNpZW1lbnMgRTQwMTAiLAorCQkudHlwZSA9IEFDOTdfVFVORV9IUF9P
TkxZCisJfSwKKwl7CisJCS52ZW5kb3IgPSAweDgwODYsCiAJCS5kZXZpY2UgPSAweDQwMDAsCiAJ
CS5tYXNrID0gMHhmZmYwLAogCQkubmFtZSA9ICJJbnRlbCBJQ0g1L0FEMTk4NSIsCg==

---MOQ109384944472be402305519132a088e1819cce0de0
Content-Type: application/octet-stream; name="intel8x0.c.id"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="intel8x0.c.id"


MDA6MWYuNSBDbGFzcyAwNDAxOiA4MDg2OjI0YzUgKHJldiAwMykKCVN1YnN5c3RlbTogMTBjZjox
MWMzCglGbGFnczogYnVzIG1hc3RlciwgbWVkaXVtIGRldnNlbCwgbGF0ZW5jeSAwLCBJUlEgMTEK
CUkvTyBwb3J0cyBhdCAxYzAwIFtzaXplPTI1Nl0KCUkvTyBwb3J0cyBhdCAxOGMwIFtzaXplPTY0
XQoJTWVtb3J5IGF0IGQwMTAwYzAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTUx
Ml0KCU1lbW9yeSBhdCBkMDEwMDgwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0y
NTZdCglDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDIKCg==

---MOQ109384944472be402305519132a088e1819cce0de0--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
