From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: Show currectly selected widget in proc_read for hda driver
Date: Thu, 24 Mar 2005 13:17:30 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D6C2@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C53030.C7186B78"
Received: from cm-msg-02.cmedia.com.tw (61-30-17-228.static.tfn.net.tw [61.30.17.228])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 63CC92AA
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2005 07:06:00 +0100 (MET)
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

------_=_NextPart_001_01C53030.C7186B78
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable


Summary: <Show currectly selected widget in proc_read for hda driver>
Signed-off-by: ChenLi Tien<cltien@cmedia.com.tw>

Durind debugging for cm9880 multi-channel playback, I added the * after =
the currently selected widget, mixer widget doesn't need this but other =
3 widget types  need it.

Sincerely,
ChenLi Tien

------_=_NextPart_001_01C53030.C7186B78
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
CTI0IE1hciAyMDA1IDA0OjU5OjA1IC0wMDAwCkBAIC0yNjYsMTMgKzI2NiwxOSBAQAogCiAJCWlm
ICh3aWRfY2FwcyAmIEFDX1dDQVBfQ09OTl9MSVNUKSB7CiAJCQloZGFfbmlkX3QgY29ubltIREFf
TUFYX0NPTk5FQ1RJT05TXTsKLQkJCWludCBjLCBjb25uX2xlbjsKKwkJCWludCBjLCBjb25uX2xl
biwgY3VyciA9IC0xOworCQkJaWYgKHdpZF90eXBlICE9IEFDX1dJRF9BVURfTUlYKQorCQkJCWN1
cnIgPSBzbmRfaGRhX2NvZGVjX3JlYWQoY29kZWMsIG5pZCwgMCwKKwkJCQkJQUNfVkVSQl9HRVRf
Q09OTkVDVF9TRUwsIDApOwogCQkJY29ubl9sZW4gPSBzbmRfaGRhX2dldF9jb25uZWN0aW9ucyhj
b2RlYywgbmlkLCBjb25uLAogCQkJCQkJCSAgIEhEQV9NQVhfQ09OTkVDVElPTlMpOwogCQkJc25k
X2lwcmludGYoYnVmZmVyLCAiICBDb25uZWN0aW9uOiAlZFxuIiwgY29ubl9sZW4pOwogCQkJc25k
X2lwcmludGYoYnVmZmVyLCAiICAgICIpOwotCQkJZm9yIChjID0gMDsgYyA8IGNvbm5fbGVuOyBj
KyspCisJCQlmb3IgKGMgPSAwOyBjIDwgY29ubl9sZW47IGMrKykgewogCQkJCXNuZF9pcHJpbnRm
KGJ1ZmZlciwgIiAweCUwMngiLCBjb25uW2NdKTsKKwkJCQlpZiAoY29ubl9sZW4gPiAxICYmIGMg
PT0gY3VycikKKwkJCQkJc25kX2lwcmludGYoYnVmZmVyLCAiKiIpOworCQkJfQogCQkJc25kX2lw
cmludGYoYnVmZmVyLCAiXG4iKTsKIAkJfQogCX0K

------_=_NextPart_001_01C53030.C7186B78--


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
