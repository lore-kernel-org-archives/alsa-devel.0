From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: RE: Show currectly selected widget in proc_read for hda driver
Date: Thu, 24 Mar 2005 13:29:54 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D6C3@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C53032.822FE518"
Received: from cm-msg-02.cmedia.com.tw (61-30-17-228.static.tfn.net.tw [61.30.17.228])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 43C4C2AA
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2005 07:06:08 +0100 (MET)
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C53032.822FE518
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable


Execuse me, this one is a better implement. I don't issue the =
GET_CONNECT for list length is 1, which is not necessary and can cause =
problem.

Please ignore previous patch.

Sincerely,
ChenLi Tien

-----Original Message-----
From:	Tien,  C.L. - =A5=D0=A9=D3=C2=A7
Sent:	2005/3/24 [=ACP=B4=C1=A5|] =A4W=A4=C8 12:17
To:	alsa-devel@alsa-project.org
Cc:=09
Subject:	Show currectly selected widget in proc_read for hda driver

Summary: <Show currectly selected widget in proc_read for hda driver>
Signed-off-by: ChenLi Tien<cltien@cmedia.com.tw>

Durind debugging for cm9880 multi-channel playback, I added the * after =
the currently selected widget, mixer widget doesn't need this but other =
3 widget types  need it.

Sincerely,
ChenLi Tien




------_=_NextPart_001_01C53032.822FE518
Content-Type: text/x-patch;
	name="hda_proc.c.patch"
Content-Transfer-Encoding: base64
Content-Description: hda_proc.c.patch
Content-Disposition: attachment;
	filename="hda_proc.c.patch"

SW5kZXg6IGFsc2EtY3ZzL2Fsc2Eta2VybmVsL3BjaS9oZGEvaGRhX3Byb2MuYwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
ClJDUyBmaWxlOiAvY3Zzcm9vdC9hbHNhL2Fsc2Eta2VybmVsL3BjaS9oZGEvaGRhX3Byb2MuYyx2
CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xCmRpZmYgLWEgLXUgLXIxLjEgaGRhX3Byb2MuYwotLS0g
YWxzYS1jdnMvYWxzYS1rZXJuZWwvcGNpL2hkYS9oZGFfcHJvYy5jCTIwIEphbiAyMDA1IDE1OjAy
OjI4IC0wMDAwCTEuMQorKysgYWxzYS1jdnMvYWxzYS1rZXJuZWwvcGNpL2hkYS9oZGFfcHJvYy5j
CTI0IE1hciAyMDA1IDA1OjIwOjU3IC0wMDAwCkBAIC0yNjYsMTMgKzI2NiwxOSBAQAogCiAJCWlm
ICh3aWRfY2FwcyAmIEFDX1dDQVBfQ09OTl9MSVNUKSB7CiAJCQloZGFfbmlkX3QgY29ubltIREFf
TUFYX0NPTk5FQ1RJT05TXTsKLQkJCWludCBjLCBjb25uX2xlbjsKKwkJCWludCBjLCBjb25uX2xl
biwgY3VyciA9IC0xOwogCQkJY29ubl9sZW4gPSBzbmRfaGRhX2dldF9jb25uZWN0aW9ucyhjb2Rl
YywgbmlkLCBjb25uLAogCQkJCQkJCSAgIEhEQV9NQVhfQ09OTkVDVElPTlMpOworCQkJaWYgKGNv
bm5fbGVuID4gMSAmJiB3aWRfdHlwZSAhPSBBQ19XSURfQVVEX01JWCkKKwkJCQljdXJyID0gc25k
X2hkYV9jb2RlY19yZWFkKGNvZGVjLCBuaWQsIDAsCisJCQkJCUFDX1ZFUkJfR0VUX0NPTk5FQ1Rf
U0VMLCAwKTsKIAkJCXNuZF9pcHJpbnRmKGJ1ZmZlciwgIiAgQ29ubmVjdGlvbjogJWRcbiIsIGNv
bm5fbGVuKTsKIAkJCXNuZF9pcHJpbnRmKGJ1ZmZlciwgIiAgICAiKTsKLQkJCWZvciAoYyA9IDA7
IGMgPCBjb25uX2xlbjsgYysrKQorCQkJZm9yIChjID0gMDsgYyA8IGNvbm5fbGVuOyBjKyspIHsK
IAkJCQlzbmRfaXByaW50ZihidWZmZXIsICIgMHglMDJ4IiwgY29ubltjXSk7CisJCQkJaWYgKGMg
PT0gY3VycikKKwkJCQkJc25kX2lwcmludGYoYnVmZmVyLCAiKiIpOworCQkJfQogCQkJc25kX2lw
cmludGYoYnVmZmVyLCAiXG4iKTsKIAkJfQogCX0K

------_=_NextPart_001_01C53032.822FE518--


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
