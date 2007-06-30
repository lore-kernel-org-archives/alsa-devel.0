From: carlo beccaria <becks@stepdev.org>
Subject: Re: roland synth sh-201
Date: Sat, 30 Jun 2007 18:20:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706301815300.11146@debian>
References: <Pine.LNX.4.64.0706280925250.11146@debian>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1539096330-1183220440=:11146"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rubycon.it (rubycon.it [69.60.121.192])
	by alsa0.perex.cz (Postfix) with ESMTP id 84BD8103877
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2007 19:37:06 +0200 (CEST)
Received: from localhost (becks@debian [127.0.0.1])
	by rubycon.it (8.13.8/8.13.8/Debian-2) with ESMTP id l5UGKex2015194
	for <alsa-devel@alsa-project.org>; Sat, 30 Jun 2007 18:20:40 +0200
In-Reply-To: <Pine.LNX.4.64.0706280925250.11146@debian>
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

--8323328-1539096330-1183220440=:11146
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Thu, 28 Jun 2007, carlo beccaria wrote:

> hi all, with this change in usbquirks.h , i can use my synth roland sh-201

i have a new patch for this device (in attach)
with this patch, also the audio works (with jackd)

let me know if you need more info

--
carlo beccaria

--8323328-1539096330-1183220440=:11146
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=sh201.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0706301820400.11146@debian>
Content-Description: 
Content-Disposition: attachment; filename=sh201.patch

LS0tIHVzYnF1aXJrcy5oCTIwMDctMDctMDIgMDE6NDI6NTUuMDAwMDAwMDAw
ICswMjAwDQorKysgdXNicXVpcmtzLXNoMjAxLmgJMjAwNy0wNy0wMiAwMTo0
Mjo1Mi4wMDAwMDAwMDAgKzAyMDANCkBAIC0xMDQyLDYgKzEwNDIsNDAgQEAN
CiAJCS50eXBlID0gUVVJUktfTUlESV9TVEFOREFSRF9JTlRFUkZBQ0UNCiAJ
fQ0KIH0sDQorDQorew0KKyAgLyogUm9sYW5kIFNILTIwMSAqLw0KKwlVU0Jf
REVWSUNFKDB4MDU4MiwgMHgwMGFkKSwNCisJLmRyaXZlcl9pbmZvID0gKHVu
c2lnbmVkIGxvbmcpICYgKGNvbnN0IHN0cnVjdCBzbmRfdXNiX2F1ZGlvX3F1
aXJrKSB7DQorCQkudmVuZG9yX25hbWUgPSAiUm9sYW5kIiwNCisJCS5wcm9k
dWN0X25hbWUgPSAiU0gtMjAxIiwNCisJCS5pZm51bSA9IFFVSVJLX0FOWV9J
TlRFUkZBQ0UsDQorCQkudHlwZSA9IFFVSVJLX0NPTVBPU0lURSwNCisJCS5k
YXRhID0gKGNvbnN0IHN0cnVjdCBzbmRfdXNiX2F1ZGlvX3F1aXJrW10pIHsN
CisJCQl7DQorCQkJCS5pZm51bSA9IDAsDQorCQkJCS50eXBlID0gUVVJUktf
QVVESU9fU1RBTkRBUkRfSU5URVJGQUNFDQorCQkJfSwNCisJCQl7DQorCQkJ
CS5pZm51bSA9IDEsDQorCQkJCS50eXBlID0gUVVJUktfQVVESU9fU1RBTkRB
UkRfSU5URVJGQUNFDQorCQkJfSwNCisJCQl7DQorCQkJCS5pZm51bSA9IDIs
DQorCQkJCS50eXBlID0gUVVJUktfTUlESV9GSVhFRF9FTkRQT0lOVCwNCisJ
CQkJLmRhdGEgPSAmIChjb25zdCBzdHJ1Y3Qgc25kX3VzYl9taWRpX2VuZHBv
aW50X2luZm8pIHsNCisJCQkJCS5vdXRfY2FibGVzID0gMHgwMDAxLA0KKwkJ
CQkJLmluX2NhYmxlcyAgPSAweDAwMDENCisJCQkJfQ0KKwkJCX0sDQorCQkJ
ew0KKwkJCQkuaWZudW0gPSAtMQ0KKwkJCX0NCisJCX0NCisJfQ0KK30sDQor
DQorDQogCS8qIFRPRE86IGFkZCBSb2xhbmQgRVhSIHN1cHBvcnQgKi8NCiB7
DQogCS8qIGhhcyBJRCAweDAwNjcgd2hlbiBub3QgaW4gIkFkdmFuY2VkIERy
aXZlciIgbW9kZSAqLw0K

--8323328-1539096330-1183220440=:11146
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323328-1539096330-1183220440=:11146--
