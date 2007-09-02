From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH] Update quirk for Rane SL 1 (aka. Serato
	Scratch Live)
Date: Sun, 2 Sep 2007 23:44:09 +0100 (BST)
Message-ID: <alpine.BSO.0.9999.0709022314250.2845@metheny.ijneb.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1725350939-1188772785=:2845"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EB8F243B2
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 00:44:10 +0200 (CEST)
Received: from localhost ([127.0.0.1] ident=mark)
	by metheny.ijneb.com with esmtp (Exim 4.62)
	(envelope-from <mark@pogo.org.uk>) id 1IRyAr-0003o4-Mt
	for alsa-devel@alsa-project.org; Sun, 02 Sep 2007 23:44:09 +0100
Content-ID: <alpine.BSO.0.9999.0709022342400.2845@metheny.ijneb.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1725350939-1188772785=:2845
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <alpine.BSO.0.9999.0709022342401.2845@metheny.ijneb.com>

Update quirk for Rane SL 1 (aka. Serato Scratch Live)

Allow the interface's mixer to be used, and give the interface its correct 
name. Move the quirk out of the 'Novation EMS devices' section to a more 
appropriate position next to the Stanton DJ interface.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
--0-1725350939-1188772785=:2845
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=rane-sl1.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.0.9999.0709022339450.2845@metheny.ijneb.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=rane-sl1.patch

ZGlmZiAtciBlN2M5MzU1YWYzZmYgdXNiL3VzYnF1aXJrcy5oDQotLS0gYS91
c2IvdXNicXVpcmtzLmgJRnJpIEF1ZyAzMSAxMjo1MjoxOSAyMDA3ICswMjAw
DQorKysgYi91c2IvdXNicXVpcmtzLmgJU3VuIFNlcCAwMiAyMzoxMjo0NSAy
MDA3ICswMTAwDQpAQCAtMTc0OCw2ICsxNzQ4LDE2IEBAIFlBTUFIQV9ERVZJ
Q0UoMHg3MDEwLCAiVUI5OSIpLA0KIAl9DQogfSwNCiANCisvKiBSYW5lIFNM
IDEgKGFrYS4gU2VyYXRvIFNjcmF0Y2ggTGl2ZSkgZGV2aWNlICovDQorew0K
KwlVU0JfREVWSUNFKDB4MTNlNSwgMHgwMDAxKSwNCisJLmRyaXZlcl9pbmZv
ID0gKHVuc2lnbmVkIGxvbmcpICYgKGNvbnN0IHN0cnVjdCBzbmRfdXNiX2F1
ZGlvX3F1aXJrKSB7DQorCQkudmVuZG9yX25hbWUgPSAiUmFuZSIsDQorCQku
cHJvZHVjdF9uYW1lID0gIlNMLTEiLA0KKwkJLmlmbnVtID0gUVVJUktfTk9f
SU5URVJGQUNFDQorCX0NCit9LA0KKw0KIC8qIE5vdmF0aW9uIEVNUyBkZXZp
Y2VzICovDQogew0KIAlVU0JfREVWSUNFX1ZFTkRPUl9TUEVDKDB4MTIzNSwg
MHgwMDAxKSwNCkBAIC0xNzc0LDE2ICsxNzg0LDYgQEAgWUFNQUhBX0RFVklD
RSgweDcwMTAsICJVQjk5IiksDQogCQkucHJvZHVjdF9uYW1lID0gIlJlTU9U
RTI1IiwNCiAJCS5pZm51bSA9IDAsDQogCQkudHlwZSA9IFFVSVJLX01JRElf
Tk9WQVRJT04NCi0JfQ0KLX0sDQotDQotew0KLQkvKiBTZXJhdG8gU2NyYXRj
aCBMaXZlIERKIEJveCAqLw0KLQlVU0JfREVWSUNFKDB4MTNlNSwgMHgwMDAx
KSwNCi0JLmRyaXZlcl9pbmZvID0gKHVuc2lnbmVkIGxvbmcpICYgKGNvbnN0
IHN0cnVjdCBzbmRfdXNiX2F1ZGlvX3F1aXJrKQ0KLQl7DQotCQkuaWZudW0g
PSBRVUlSS19BTllfSU5URVJGQUNFLA0KLQkJLnR5cGUgPSBRVUlSS19BVURJ
T19TVEFOREFSRF9JTlRFUkZBQ0UNCiAJfQ0KIH0sDQogDQo=

--0-1725350939-1188772785=:2845
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-1725350939-1188772785=:2845--
