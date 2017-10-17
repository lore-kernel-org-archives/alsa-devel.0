From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH] ALSA: hda: Abort capability probe at
 invalid	register read
Date: Tue, 17 Oct 2017 15:35:18 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB605799E947C@BGSMSX104.gar.corp.intel.com>
References: <20171017144711.23962-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_85DFEED57DC57344B2483EF7BF8CB605799E947CBGSMSX104garcor_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id F194D266DA4
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 17:35:23 +0200 (CEST)
In-Reply-To: <20171017144711.23962-1-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Koul, Vinod" <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

--_002_85DFEED57DC57344B2483EF7BF8CB605799E947CBGSMSX104garcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>+		if (cur_cap =3D=3D -1) {
>+			dev_dbg(bus->dev, "Invalid capability reg read\n");
>+			break;
>+		}

Since we already have a default case in the current code, can we use it ?
I am sending you a untested patch, as proposal.



--_002_85DFEED57DC57344B2483EF7BF8CB605799E947CBGSMSX104garcor_
Content-Type: application/octet-stream;
	name="0001-ALSA-hda-Abort-capability-probe-at-invalid-register-.patch"
Content-Description: 0001-ALSA-hda-Abort-capability-probe-at-invalid-register-.patch
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Abort-capability-probe-at-invalid-register-.patch";
	size=825; creation-date="Tue, 17 Oct 2017 15:31:17 GMT";
	modification-date="Tue, 17 Oct 2017 23:18:20 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxNjkwNjI0MDUxYTc1Yjk1NTkyZmIxYzQ5N2EwYTg4NDRjYmQxYzY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWtlc2ggVWdocmVqYSA8cmFrZXNoLmEudWdocmVqYUBpbnRl
bC5jb20+CkRhdGU6IFdlZCwgMTggT2N0IDIwMTcgMDQ6NDY6NDYgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBBTFNBOiBoZGE6IEFib3J0IGNhcGFiaWxpdHkgcHJvYmUgYXQgaW52YWxpZCByZWdpc3Rl
ciByZWFkCgpJbiB0aGUgY2FzZSBvZiB1bmtub3duIGNhcGFiaWxpdHkgYnJlYWsgdGhlIGxvb3Ag
Ynkgc2V0dGluZyB0aGUKY3VycmVudCBjYXBhYmlsaXR5IHRvIHplcm8KClNpZ25lZC1vZmYtYnk6
IFJha2VzaCBVZ2hyZWphIDxyYWtlc2guYS51Z2hyZWphQGludGVsLmNvbT4KLS0tCiBzb3VuZC9o
ZGEvaGRhY19jb250cm9sbGVyLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQoKZGlmZiAtLWdpdCBhL3NvdW5kL2hkYS9oZGFjX2NvbnRyb2xsZXIuYyBiL3NvdW5kL2hkYS9o
ZGFjX2NvbnRyb2xsZXIuYwppbmRleCA5NzhkYzE4Li44NmMyYjRjIDEwMDY0NAotLS0gYS9zb3Vu
ZC9oZGEvaGRhY19jb250cm9sbGVyLmMKKysrIGIvc291bmQvaGRhL2hkYWNfY29udHJvbGxlci5j
CkBAIC0zMTUsNiArMzE1LDcgQEAgaW50IHNuZF9oZGFjX2J1c19wYXJzZV9jYXBhYmlsaXRpZXMo
c3RydWN0IGhkYWNfYnVzICpidXMpCiAKIAkJZGVmYXVsdDoKIAkJCWRldl9kYmcoYnVzLT5kZXYs
ICJVbmtub3duIGNhcGFiaWxpdHkgJWRcbiIsIGN1cl9jYXApOworCQkJY3VyX2NhcCA9IDA7CiAJ
CQlicmVhazsKIAkJfQogCi0tIAoyLjcuNAoK

--_002_85DFEED57DC57344B2483EF7BF8CB605799E947CBGSMSX104garcor_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_85DFEED57DC57344B2483EF7BF8CB605799E947CBGSMSX104garcor_--
