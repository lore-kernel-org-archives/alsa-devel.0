From: Dan Chen <crimsunkg@yahoo.com>
Subject: Re: [Pkg-alsa-devel] Bug#547994: snd-hda-intel and MSI
Date: Thu, 24 Sep 2009 03:04:51 -0700 (PDT)
Message-ID: <107077.93755.qm@web31803.mail.mud.yahoo.com>
References: <20090923143306.GC4488@aragorn.home.lxtec.de>
	<s5hpr9hzmx0.wl%tiwai@suse.de>
	<20090923170635.GD4488@aragorn.home.lxtec.de>
	<604760770909231011t1b05c01dn79d94f8a021a1884@mail.gmail.com>
	<20090923180842.GE4488@aragorn.home.lxtec.de>
	<604760770909231111n7a1d1a0dw1a01b64f7066a574@mail.gmail.com>
	<21151.71754.qm@web31804.mail.mud.yahoo.com>
	<s5htyysvmg7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-185185142-1253786691=:93755"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web31803.mail.mud.yahoo.com (web31803.mail.mud.yahoo.com
	[68.142.207.66]) by alsa0.perex.cz (Postfix) with SMTP id 8D139103873
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 12:04:53 +0200 (CEST)
In-Reply-To: <s5htyysvmg7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, 547994@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

--0-185185142-1253786691=:93755
Content-Type: text/plain; charset=us-ascii

> Dan, your from-address and sign-off address are different in the patch.
> Could you unify?

Indeed, here's a new patch.



      
--0-185185142-1253786691=:93755
Content-Type: application/octet-stream; name="0001-Add-HP-Pavilion-dv4t-1300-to-MSI-whitelist.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Add-HP-Pavilion-dv4t-1300-to-MSI-whitelist.patch"

RnJvbSA0MDlmZGI3Yjc1YzIxYjAzMTE5OTA2OTYwNmM4ODVkMGFjOTE4NzA3
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVu
IDxjcmltc3VuQHVidW50dS5jb20+CkRhdGU6IFdlZCwgMjMgU2VwIDIwMDkg
MjA6MjM6MjcgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBZGQgSFAgUGF2aWxp
b24gZHY0dC0xMzAwIHRvIE1TSSB3aGl0ZWxpc3QKCkJ1Z0xpbms6IGh0dHA6
Ly9idWdzLmRlYmlhbi5vcmcvY2dpLWJpbi9idWdyZXBvcnQuY2dpP2J1Zz01
NDc5OTQKCkVuYWJsZSBNU0kgYnkgZGVmYXVsdCBmb3IgdGhpcyBQYXZpbGlv
biBtb2RlbC4KClNpZ25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1z
dW5AdWJ1bnR1LmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5j
IHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL2hk
YV9pbnRlbC5jIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwppbmRleCAy
MGE2NmY4Li5jOWFkMTgyIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL2hk
YV9pbnRlbC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKQEAg
LTIzMDMsNiArMjMwMyw3IEBAIHN0YXRpYyB2b2lkIF9fZGV2aW5pdCBjaGVj
a19wcm9iZV9tYXNrKHN0cnVjdCBhenggKmNoaXAsIGludCBkZXYpCiAgKiB3
aGl0ZS1saXN0IGZvciBlbmFibGVfbXNpCiAgKi8KIHN0YXRpYyBzdHJ1Y3Qg
c25kX3BjaV9xdWlyayBtc2lfd2hpdGVfbGlzdFtdIF9fZGV2aW5pdGRhdGEg
PSB7CisJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4MzBmNywgIkhQIFBhdmls
aW9uIGR2NHQtMTMwMCIsIDEpLAogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAw
eDM2MDcsICJIUCBDb21wYSBDUTQwIiwgMSksCiAJe30KIH07Ci0tIAoxLjYu
My4zCgo=

--0-185185142-1253786691=:93755
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-185185142-1253786691=:93755--
