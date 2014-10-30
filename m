From: Mark van Rossum <mvanross@inf.ed.ac.uk>
Subject: Build error on Fedora 21
Date: Thu, 30 Oct 2014 11:10:48 +0000
Message-ID: <54521CB8.7010201@inf.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nougat.ucs.ed.ac.uk (nougat.ucs.ed.ac.uk [129.215.13.205])
 by alsa0.perex.cz (Postfix) with ESMTP id D0D17260629
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:11:04 +0100 (CET)
Received: from beeknow.inf.ed.ac.uk (beeknow.inf.ed.ac.uk [129.215.33.12])
 by nougat.ucs.ed.ac.uk (8.13.8/8.13.4) with ESMTP id s9UBAmHO005048
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 11:10:54 GMT
Received: from [129.215.90.214] (dhcp-90-214.inf.ed.ac.uk [129.215.90.214])
 (authenticated bits=0)
 by beeknow.inf.ed.ac.uk (8.14.4/8.14.4) with ESMTP id s9UBAmKq013235
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 11:10:48 GMT
Content-Disposition: inline
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

SGkKCmFsc2FfdXRpbHNfYWxzYS1jb21waWxlLnNoCgpmYWlscyB3aXRoOgoKbWFrZVsxXTogRW50
ZXJpbmcgZGlyZWN0b3J5ICcvdXNyL3NyYy9rZXJuZWxzLzMuMTcuMC0zMDEuZmMyMS54ODZfNjQn
CiAgIENDIFtNXSAKL3RtcC9hbHNhLWNvbXBpbGUtc2NyaXB0L2Fsc2EtZHJpdmVyLTEuMC4yNS4z
NTg0LmdiMDQ0ZC9hY29yZS9pbmZvLm8KL3RtcC9hbHNhLWNvbXBpbGUtc2NyaXB0L2Fsc2EtZHJp
dmVyLTEuMC4yNS4zNTg0LmdiMDQ0ZC9hY29yZS9pbmZvLmM6IEluIApmdW5jdGlvbiDigJhzbmRf
aW5mb192ZXJzaW9uX3JlYWTigJk6Ci90bXAvYWxzYS1jb21waWxlLXNjcmlwdC9hbHNhLWRyaXZl
ci0xLjAuMjUuMzU4NC5nYjA0NGQvYWNvcmUvaW5mby5jOjEwNjU6MjI6IAplcnJvcjogbWFjcm8g
Il9fREFURV9fIiBtaWdodCBwcmV2ZW50IHJlcHJvZHVjaWJsZSBidWlsZHMgClstV2Vycm9yPWRh
dGUtdGltZV0KICAgICAgICAiQ29tcGlsZWQgb24gIiBfX0RBVEVfXyAiIGZvciBrZXJuZWwgJXMi
CiAgICAgICAgICAgICAgICAgICAgICAgXgpjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRl
ZCBhcyBlcnJvcnMKc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyNTc6IHJlY2lwZSBmb3IgdGFyZ2V0
IAonL3RtcC9hbHNhLWNvbXBpbGUtc2NyaXB0L2Fsc2EtZHJpdmVyLTEuMC4yNS4zNTg0LmdiMDQ0
ZC9hY29yZS9pbmZvLm8nIApmYWlsZWQKbWFrZVszXTogKioqIApbL3RtcC9hbHNhLWNvbXBpbGUt
c2NyaXB0L2Fsc2EtZHJpdmVyLTEuMC4yNS4zNTg0LmdiMDQ0ZC9hY29yZS9pbmZvLm9dIApFcnJv
ciAxCnNjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDA0OiByZWNpcGUgZm9yIHRhcmdldCAKJy90bXAv
YWxzYS1jb21waWxlLXNjcmlwdC9hbHNhLWRyaXZlci0xLjAuMjUuMzU4NC5nYjA0NGQvYWNvcmUn
IGZhaWxlZAptYWtlWzJdOiAqKiogClsvdG1wL2Fsc2EtY29tcGlsZS1zY3JpcHQvYWxzYS1kcml2
ZXItMS4wLjI1LjM1ODQuZ2IwNDRkL2Fjb3JlXSBFcnJvciAyCk1ha2VmaWxlOjEzNzM6IHJlY2lw
ZSBmb3IgdGFyZ2V0IAonX21vZHVsZV8vdG1wL2Fsc2EtY29tcGlsZS1zY3JpcHQvYWxzYS1kcml2
ZXItMS4wLjI1LjM1ODQuZ2IwNDRkJyBmYWlsZWQKbWFrZVsxXTogKioqIApbX21vZHVsZV8vdG1w
L2Fsc2EtY29tcGlsZS1zY3JpcHQvYWxzYS1kcml2ZXItMS4wLjI1LjM1ODQuZ2IwNDRkXSBFcnJv
ciAyCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5ICcvdXNyL3NyYy9rZXJuZWxzLzMuMTcuMC0z
MDEuZmMyMS54ODZfNjQnCk1ha2VmaWxlOjE2NzogcmVjaXBlIGZvciB0YXJnZXQgJ2NvbXBpbGUn
IGZhaWxlZAptYWtlOiAqKiogW2NvbXBpbGVdIEVycm9yIDIKV29ya2luZyBkaXJlY3RvcnkgL3Rt
cC9hbHNhLWNvbXBpbGUtc2NyaXB0L2Fsc2EtZHJpdmVyLTEuMC4yNS4zNTg0LmdiMDQ0ZC4KQ29t
cGlsYXRpb24gb2YgYWxzYS1kcml2ZXIgZmFpbGVkLgpSZXBvcnQgdGhpcyBwcm9ibGVtIHRvIHRo
ZSA8YWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnPiBtYWlsaW5nIGxpc3QuCgotLSAKVGhlIFVu
aXZlcnNpdHkgb2YgRWRpbmJ1cmdoIGlzIGEgY2hhcml0YWJsZSBib2R5LCByZWdpc3RlcmVkIGlu
ClNjb3RsYW5kLCB3aXRoIHJlZ2lzdHJhdGlvbiBudW1iZXIgU0MwMDUzMzYuCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
