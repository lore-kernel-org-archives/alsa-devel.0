From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: RE: [patch] patch_cm9880.c to support multi-channel
Date: Fri, 25 Mar 2005 03:52:01 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D6C9@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C530AA.F22637A4"
Received: from cm-msg-02.cmedia.com.tw (61-30-17-228.static.tfn.net.tw [61.30.17.228])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 121CF14E
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2005 21:25:55 +0100 (MET)
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

------_=_NextPart_001_01C530AA.F22637A4
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable


Sorry,

I didn't add the attached file in previous mail, please use this patch. =
Sorry for any inconvenience.

Sincerely,
ChenLi Tien

-----Original Message-----
From:	Tien,  C.L. - =A5=D0=A9=D3=C2=A7
Sent:	2005/3/24 [=ACP=B4=C1=A5|] =A4U=A4=C8 12:53
To:	alsa-devel@alsa-project.org
Cc:=09
Subject:	[Alsa-devel] [patch] patch_cm9880.c to support multi-channel

Summary: <fix multi-channel for model=3D=3Dfull>
Signed-off-by: ChenLi Tien<cltien@cmedia.com.tw>


Hi,

The patch_cm9880.c can't play side/C/B channels from front panel jacks. =
I fixed it by adding select pin.

I also added controls in the allout_init array. I wonder what this model =
for because it is the same as basic_init except the line-in is used as =
output in allout_init.

I plan to add controls for 5/6 stacks ,  which lacks front panel but has =
rear 5/6 jacks. Any idea?

Sincerely,
ChenLi Tien


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=3Dick
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel






------_=_NextPart_001_01C530AA.F22637A4
Content-Type: text/x-patch;
	name="patch_cmedia.c.patch"
Content-Transfer-Encoding: base64
Content-Description: patch_cmedia.c.patch
Content-Disposition: attachment;
	filename="patch_cmedia.c.patch"

SW5kZXg6IGFsc2EtY3ZzL2Fsc2Eta2VybmVsL3BjaS9oZGEvcGF0Y2hfY21lZGlhLmMKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvYWxzYS9hbHNhLWtlcm5lbC9wY2kvaGRhL3BhdGNoX2Nt
ZWRpYS5jLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjYKZGlmZiAtYSAtdSAtcjEuNiBwYXRjaF9j
bWVkaWEuYwotLS0gYWxzYS1jdnMvYWxzYS1rZXJuZWwvcGNpL2hkYS9wYXRjaF9jbWVkaWEuYwky
MiBNYXIgMjAwNSAyMTowMDozNyAtMDAwMAkxLjYKKysrIGFsc2EtY3ZzL2Fsc2Eta2VybmVsL3Bj
aS9oZGEvcGF0Y2hfY21lZGlhLmMJMjQgTWFyIDIwMDUgMTc6NDM6MjIgLTAwMDAKQEAgLTI3OCw4
ICsyNzgsMTAgQEAKIAl7IDB4MGUsIEFDX1ZFUkJfU0VUX1BJTl9XSURHRVRfQ09OVFJPTCwgMHhj
MCB9LAogCS8qIHBvcnQtRyBmb3IgQ0xGRSAocmVhciBwYW5lbCkgKi8KIAl7IDB4MWYsIEFDX1ZF
UkJfU0VUX1BJTl9XSURHRVRfQ09OVFJPTCwgMHhjMCB9LAorCXsgMHgxZiwgQUNfVkVSQl9TRVRf
Q09OTkVDVF9TRUwsIDB4MDIgfSwKIAkvKiBwb3J0LUggZm9yIHNpZGUgKHJlYXIgcGFuZWwpICov
CiAJeyAweDIwLCBBQ19WRVJCX1NFVF9QSU5fV0lER0VUX0NPTlRST0wsIDB4YzAgfSwKKwl7IDB4
MjAsIEFDX1ZFUkJfU0VUX0NPTk5FQ1RfU0VMLCAweDAxIH0sCiAJLyogcG9ydC1DIGZvciBsaW5l
LWluIChyZWFyIHBhbmVsKSAqLwogCXsgMHgwYywgQUNfVkVSQl9TRVRfUElOX1dJREdFVF9DT05U
Uk9MLCAweDIwIH0sCiAJLyogcG9ydC1CIGZvciBtaWMtaW4gKHJlYXIgcGFuZWwpIHdpdGggdnJl
ZiAqLwpAQCAtMzA1LDYgKzMwNywxMCBAQAogCXsgMHgwZSwgQUNfVkVSQl9TRVRfUElOX1dJREdF
VF9DT05UUk9MLCAweGMwIH0sCiAJLyogcG9ydC1HIGZvciBDTEZFIChyZWFyIHBhbmVsKSAqLwog
CXsgMHgxZiwgQUNfVkVSQl9TRVRfUElOX1dJREdFVF9DT05UUk9MLCAweGMwIH0sCisJeyAweDFm
LCBBQ19WRVJCX1NFVF9DT05ORUNUX1NFTCwgMHgwMiB9LAorCS8qIHBvcnQtSCBmb3Igc2lkZSAo
cmVhciBwYW5lbCkgKi8KKwl7IDB4MjAsIEFDX1ZFUkJfU0VUX1BJTl9XSURHRVRfQ09OVFJPTCwg
MHhjMCB9LAorCXsgMHgyMCwgQUNfVkVSQl9TRVRfQ09OTkVDVF9TRUwsIDB4MDEgfSwKIAkvKiBw
b3J0LUMgZm9yIHN1cnJvdW5kIChyZWFyIHBhbmVsKSAqLwogCXsgMHgwYywgQUNfVkVSQl9TRVRf
UElOX1dJREdFVF9DT05UUk9MLCAweGMwIH0sCiAJLyogcG9ydC1CIGZvciBtaWMtaW4gKHJlYXIg
cGFuZWwpIHdpdGggdnJlZiAqLwo=

------_=_NextPart_001_01C530AA.F22637A4--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
