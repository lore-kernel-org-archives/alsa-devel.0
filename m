From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: [patch] for 9880 spdif out
Date: Thu, 17 Mar 2005 12:48:16 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D69F@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C52AAC.88DD3B18"
Received: from cm-msg-02.cmedia.com.tw (61-30-17-228.static.tfn.net.tw [61.30.17.228])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3AD41226
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2005 06:43:23 +0100 (MET)
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
Cc: bugtrack@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C52AAC.88DD3B18
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable


Hi,

There is mute control on 9880's spdif (IEC958) out, so it needs to be =
turned on/off in mixer.
The patch is for CVS version and I think it can be patched to azx too. =
Hope this also fix the 9880 SPDIF-out bug.

       Signed-off-by: ChenLi Tien <cltien@cmedia.com.tw>

Sincerely,
ChenLi Tien

------_=_NextPart_001_01C52AAC.88DD3B18
Content-Type: text/x-patch;
	name="hda_codec.c.patch"
Content-Transfer-Encoding: base64
Content-Description: hda_codec.c.patch
Content-Disposition: attachment;
	filename="hda_codec.c.patch"

SW5kZXg6IGFsc2Eta2VybmVsL3BjaS9oZGEvaGRhX2NvZGVjLmMKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmls
ZTogL2N2c3Jvb3QvYWxzYS9hbHNhLWtlcm5lbC9wY2kvaGRhL2hkYV9jb2RlYy5jLHYKcmV0cmll
dmluZyByZXZpc2lvbiAxLjcKZGlmZiAtYSAtdSAtcjEuNyBoZGFfY29kZWMuYwotLS0gYWxzYS1r
ZXJuZWwvcGNpL2hkYS9oZGFfY29kZWMuYwkxNiBNYXIgMjAwNSAxMzozNzowOSAtMDAwMAkxLjcK
KysrIGFsc2Eta2VybmVsL3BjaS9oZGEvaGRhX2NvZGVjLmMJMTcgTWFyIDIwMDUgMDQ6NDA6MTIg
LTAwMDAKQEAgLTk1NSw2ICs5NTUsOCBAQAogCWlmIChjaGFuZ2UgfHwgY29kZWMtPmluX3Jlc3Vt
ZSkgewogCQljb2RlYy0+c3BkaWZfY3RscyA9IHZhbDsKIAkJc25kX2hkYV9jb2RlY193cml0ZShj
b2RlYywgbmlkLCAwLCBBQ19WRVJCX1NFVF9ESUdJX0NPTlZFUlRfMSwgdmFsICYgMHhmZik7CisJ
CXB1dF92b2xfbXV0ZShjb2RlYywgbmlkLCAwLCBIREFfT1VUUFVULCAwLCB2YWwgPyAwIDogMHg4
MCk7CisJCXB1dF92b2xfbXV0ZShjb2RlYywgbmlkLCAxLCBIREFfT1VUUFVULCAwLCB2YWwgPyAw
IDogMHg4MCk7CiAJfQogCXVwKCZjb2RlYy0+c3BkaWZfbXV0ZXgpOwogCXJldHVybiBjaGFuZ2U7
Cg==

------_=_NextPart_001_01C52AAC.88DD3B18--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
