From: Paul Handrigan <Paul.Handrigan@cirrus.com>
Subject: [PATCH 3/3] Add bit shifts to set the correct
	functional mode and the correct clock divider.
Date: Thu, 28 Aug 2014 10:54:10 -0500
Message-ID: <1409241250-22097-3-git-send-email-Paul.Handrigan@cirrus.com>
References: <1409241250-22097-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 181932664E5
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 17:54:41 +0200 (CEST)
In-Reply-To: <1409241250-22097-1-git-send-email-Paul.Handrigan@cirrus.com>
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
Cc: brian.austin@cirrus.com, broonie@kernel.org, lgirdwood@gmail.com, Paul Handrigan <Paul.Handrigan@cirrus.com>, zoltan@raspberrypi.org
List-Id: alsa-devel@alsa-project.org

UmVwb3J0ZWQtYnk6IFpvbHTDoW4gU3plbmN6aSA8em9sdGFuQHJhc3BiZXJyeXBpLm9yZz4KU2ln
bmVkLW9mZi1ieTogUGF1bCBIYW5kcmlnYW4gPFBhdWwuSGFuZHJpZ2FuQGNpcnJ1cy5jb20+Ci0t
LQogc291bmQvc29jL2NvZGVjcy9jczQyNjUuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29k
ZWNzL2NzNDI2NS5jIGIvc291bmQvc29jL2NvZGVjcy9jczQyNjUuYwppbmRleCBjMzFkMjlkLi5l
Mjk5OTQ4IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL2NzNDI2NS5jCisrKyBiL3NvdW5k
L3NvYy9jb2RlY3MvY3M0MjY1LmMKQEAgLTQzNiwxMCArNDM2LDEwIEBAIHN0YXRpYyBpbnQgY3M0
MjY1X3BjbV9od19wYXJhbXMoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCiAJ
aW5kZXggPSBjczQyNjVfZ2V0X2Nsa19pbmRleChjczQyNjUtPnN5c2NsaywgcGFyYW1zX3JhdGUo
cGFyYW1zKSk7CiAJaWYgKGluZGV4ID49IDApIHsKIAkJc25kX3NvY191cGRhdGVfYml0cyhjb2Rl
YywgQ1M0MjY1X0FEQ19DVEwsCi0JCQlDUzQyNjVfQURDX0ZNLCBjbGtfbWFwX3RhYmxlW2luZGV4
XS5mbV9tb2RlKTsKKwkJCUNTNDI2NV9BRENfRk0sIGNsa19tYXBfdGFibGVbaW5kZXhdLmZtX21v
ZGUgPDwgNik7CiAJCXNuZF9zb2NfdXBkYXRlX2JpdHMoY29kZWMsIENTNDI2NV9NQ0xLX0ZSRVEs
CiAJCQlDUzQyNjVfTUNMS19GUkVRX01BU0ssCi0JCQljbGtfbWFwX3RhYmxlW2luZGV4XS5tY2xr
ZGl2KTsKKwkJCWNsa19tYXBfdGFibGVbaW5kZXhdLm1jbGtkaXYgPDwgNCk7CiAKIAl9IGVsc2Ug
ewogCQlkZXZfZXJyKGNvZGVjLT5kZXYsICJjYW4ndCBnZXQgY29ycmVjdCBtY2xrXG4iKTsKLS0g
CjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
