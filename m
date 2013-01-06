From: Jean-Samuel Reynaud <js.reynaud@gmail.com>
Subject: Roland-Boss RC-300 support
Date: Sun, 6 Jan 2013 20:16:31 +0100
Message-ID: <CAEzrNVQop3Og5KwcHM9cHH_FdUWEkD4iBx-dBBxeEsuH_+o1JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b111e65dfdfa204d2a38caa
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com
 [209.85.160.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 04764264FF5
 for <alsa-devel@alsa-project.org>; Sun,  6 Jan 2013 20:16:32 +0100 (CET)
Received: by mail-pb0-f49.google.com with SMTP id un15so10084043pbc.22
 for <alsa-devel@alsa-project.org>; Sun, 06 Jan 2013 11:16:32 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--047d7b111e65dfdfa204d2a38caa
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

I have a Boss RC-300 loop station with an USB connector. The windows
driver add an audio device but it was not working under linux. So
please find attached, the patch for supporting audio in this device.
Note that midi is not working yet but I'm working on it...


Regards,

--047d7b111e65dfdfa204d2a38caa
Content-Type: application/octet-stream; name="rc-300.diff"
Content-Disposition: attachment; filename="rc-300.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hbmkb8j60

KioqIHNvdW5kL3VzYi9xdWlya3MtdGFibGUuaC5vbGQJMjAxMy0wMS0wNSAyMjoyMDowNi4wMDAw
MDAwMDAgKzAxMDAKLS0tIHNvdW5kL3VzYi9xdWlya3MtdGFibGUuaAkyMDEzLTAxLTA2IDIwOjEx
OjMxLjU3MzMyMzA0NiArMDEwMAoqKioqKioqKioqKioqKioKKioqIDMyNCwzMjkgKioqKgotLS0g
MzI0LDM1OSAtLS0tCiAgICogUm9sYW5kL1JvbGFuZEVEL0VkaXJvbC9CT1NTIGRldmljZXMKICAg
Ki8KICB7CisgCVVTQl9ERVZJQ0UoMHgwNTgyLCAweDAxMzgpLAorIAkuZHJpdmVyX2luZm8gPSAo
dW5zaWduZWQgbG9uZykgJiAoY29uc3Qgc3RydWN0IHNuZF91c2JfYXVkaW9fcXVpcmspIHsKKyAJ
CS52ZW5kb3JfbmFtZSA9ICJSb2xhbmQiLAorIAkJLnByb2R1Y3RfbmFtZSA9ICJSQy0zMDAiLAor
IAkJLmlmbnVtID0gUVVJUktfQU5ZX0lOVEVSRkFDRSwKKyAJCS50eXBlID0gUVVJUktfQ09NUE9T
SVRFLAorIAkJLmRhdGEgPSAoY29uc3Qgc3RydWN0IHNuZF91c2JfYXVkaW9fcXVpcmtbXSkgewor
IAkJCXsKKyAJCQkJLmlmbnVtID0gMCwKKyAJCQkJLnR5cGUgPSBRVUlSS19JR05PUkVfSU5URVJG
QUNFCisgCQkJfSwKKyAJCQl7CisgCQkJICAuaWZudW0gPSAxLCAvLyBPVVQKKyAJCQkJLnR5cGUg
PSBRVUlSS19BVURJT19TVEFOREFSRF9JTlRFUkZBQ0UKKyAJCQl9LAorIAkJCXsKKyAJCQkgIC5p
Zm51bSA9IDIsIC8vIElOCisgCQkJCS50eXBlID0gUVVJUktfQVVESU9fU1RBTkRBUkRfSU5URVJG
QUNFCisgCQkJfSwKKyAJCQl7CisgCQkJICAuaWZudW0gPSAzLCAvLyBNaWRpCisgCQkJCS50eXBl
ID0gUVVJUktfTUlESV9TVEFOREFSRF9JTlRFUkZBQ0UKKyAJCQl9LAorIAkJCXsKKyAJCQkJLmlm
bnVtID0gLTEKKyAJCQl9CisgCQl9CisgCX0KKyB9LAorIHsKICAJVVNCX0RFVklDRSgweDA1ODIs
IDB4MDAwMCksCiAgCS5kcml2ZXJfaW5mbyA9ICh1bnNpZ25lZCBsb25nKSAmIChjb25zdCBzdHJ1
Y3Qgc25kX3VzYl9hdWRpb19xdWlyaykgewogIAkJLnZlbmRvcl9uYW1lID0gIlJvbGFuZCIsCg==
--047d7b111e65dfdfa204d2a38caa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--047d7b111e65dfdfa204d2a38caa--
