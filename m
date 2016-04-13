From: Andreas x Larsson <andreas.x.larsson@axis.com>
Subject: [PATCH] alsa-lib:Make snd_atomic_write_* truly atomic
Date: Wed, 13 Apr 2016 12:42:01 +0200
Message-ID: <570E2279.7060809@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 02D5B2604D6
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 12:42:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 87F9E2E145
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 12:42:02 +0200 (CEST)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id d9pi9HnWEQ7e for <alsa-devel@alsa-project.org>;
 Wed, 13 Apr 2016 12:42:01 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id DAB252E13E
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 12:42:01 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id BF63B1587
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 12:42:01 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id B49C0FBE
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 12:42:01 +0200 (CEST)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
 by thoth.se.axis.com (Postfix) with ESMTP id B288FFB2
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 12:42:01 +0200 (CEST)
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

VW5kZXIgc29tZSB1c2VjYXNlcyBhIHJhY2UgY29uZGl0aW9uIGFwcGVhcnMgaW5zaWRlCnRoZSBz
bmRfYXRvbWljX3dyaXRlXyogZnVuY3Rpb25zLiBUaGUgJ2JlZ2luJyBhbmQgJ2VuZCcKdmFyaWFi
bGVzIGFyZSB1cGRhdGVkIHdpdGggdGhlICsrIG9wZXJhdG9yIHdoaWNoIGlzIG5vdAphdG9taWMg
YnV0IG5lZWRzIHRvIGJlLiBUaGlzIGNhbiBiZSBhY2hpZXZlZCB3aXRoIHRoZQpnY2MgYXRvbWlj
XyogYnVpbHQtaW5zLiBDb21iaW5lZCB3aXRoIF9fQVRPTUlDX1NFUV9DU1QKYXMgdGhlIG1lbW9y
eSBtb2RlbCwgbWVtb3J5IGJhcnJpZXJzIGFyZSBpbnRyb2R1Y2VkIHNvCnRob3NlIGNhbiBhbHNv
IGJlIHJlbW92ZWQgZnJvbSB0aGUgY29kZS4KClNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgeCBMYXJz
c29uIDxhbmRyZWxhbkBheGlzLmNvbT4KU2lnbmVkLW9mZi1ieTogQXJ2aWQgTmlobGfDpXJkIExp
bmRlbGwgPGFydmlkbmxAYXhpcy5jb20+Ci0tLQogIGFsc2EtbGliL2luY2x1ZGUvaWF0b21pYy5o
IHwgNiArKy0tLS0KICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2Fsc2EtbGliL2luY2x1ZGUvaWF0b21pYy5oIGIvYWxzYS1saWIv
aW5jbHVkZS9pYXRvbWljLmgKaW5kZXggYWNkZDNlMi4uN2ZhZmUyMCAxMDA2NDQKLS0tIGEvYWxz
YS1saWIvaW5jbHVkZS9pYXRvbWljLmgKKysrIGIvYWxzYS1saWIvaW5jbHVkZS9pYXRvbWljLmgK
QEAgLTE0MCwxNCArMTQwLDEyIEBAIHN0YXRpYyBfX2lubGluZV9fIHZvaWQgCnNuZF9hdG9taWNf
d3JpdGVfaW5pdChzbmRfYXRvbWljX3dyaXRlX3QgKncpCgogIHN0YXRpYyBfX2lubGluZV9fIHZv
aWQgc25kX2F0b21pY193cml0ZV9iZWdpbihzbmRfYXRvbWljX3dyaXRlX3QgKncpCiAgewotICAg
dy0+YmVnaW4rKzsKLSAgIHdtYigpOworICAgX19hdG9taWNfYWRkX2ZldGNoKCZ3LT5iZWdpbiwg
MSxfX0FUT01JQ19TRVFfQ1NUKTsKICB9CgogIHN0YXRpYyBfX2lubGluZV9fIHZvaWQgc25kX2F0
b21pY193cml0ZV9lbmQoc25kX2F0b21pY193cml0ZV90ICp3KQogIHsKLSAgIHdtYigpOwotICAg
dy0+ZW5kKys7CisgICBfX2F0b21pY19hZGRfZmV0Y2goJnctPmVuZCwgMSwgX19BVE9NSUNfU0VR
X0NTVCk7CiAgfQoKICBzdGF0aWMgX19pbmxpbmVfXyB2b2lkIHNuZF9hdG9taWNfcmVhZF9pbml0
KHNuZF9hdG9taWNfcmVhZF90ICpyLCAKc25kX2F0b21pY193cml0ZV90ICp3KQotLSAKMi4xLjQK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
