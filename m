From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Fri, 25 Jan 2019 09:32:38 +0800
Message-ID: <CAOReqxgow+f=LCQ++JM7npFC5nzU_aEhCV72n6A-jhRsJaPybw@mail.gmail.com>
References: <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
 <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
 <c6721670-cf89-5d21-953d-c1fa10d87367@linux.intel.com>
 <CAOReqxgG4TJDXKCEVcDVXvpi_mnLUzqLwF7Rp0H5iAPdbMuZ_Q@mail.gmail.com>
 <44029078-2749-5a3b-7b03-f38461bf268f@linux.intel.com>
 <20190124184412.GH5641@sirena.org.uk>
 <976ec85a-7b21-6c58-90cc-a3d104f9505a@linux.intel.com>
 <20190124192652.GK5641@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0000000000002711a205803e4eae"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 84C8A2674A9
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 02:32:52 +0100 (CET)
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so6989202ljh.6
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 17:32:52 -0800 (PST)
In-Reply-To: <20190124192652.GK5641@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, Vinod Koul <vinod.koul@linaro.org>, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Matthias Reichl <hias@horus.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>, Curtis Malainey <cujomalainey@chromium.org>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

--0000000000002711a205803e4eae
Content-Type: text/plain; charset="UTF-8"

I have a patch to fix the memory leak but I haven't been able to test
it yet because I am remote right now and I accidentally bootlooped the
AMD device I am working on. I will have this tested early next week.
Here is the patch for anyone interested.

Curtis Malainey | Software Engineer | cujomalainey@google.com | 650-898-3849


On Fri, Jan 25, 2019 at 3:26 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jan 24, 2019 at 01:07:17PM -0600, Pierre-Louis Bossart wrote:
>
> > Thanks for the feedback, will send a formal patch with the helper and
> > machine driver changes after I test more with the legacy drivers. Do you
> > have a preference for one patch that deals with multiple machines drivers in
> > one shot, or individual patches? The latter are nicer for backports (e.g.
> > for Chrome), the former nicer for maintainers...
>
> More patches is good, it doesn't make a huge difference if I get one big
> patch or a series of repetitive patches - big serieses are more of an
> issue if they're all different patches needing individual review.

--0000000000002711a205803e4eae
Content-Type: application/octet-stream;
	name="0001-ASoC-soc-core-clear-platform-pointers-on-error.patch"
Content-Disposition: attachment;
	filename="0001-ASoC-soc-core-clear-platform-pointers-on-error.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jrbdeby40>
X-Attachment-Id: f_jrbdeby40

RnJvbSBmNWEyMmFlMzc2MTg4ZWUxYWQ1NGVmZDEyNzQ5NDAyOTUyNDVlZWYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDdXJ0aXMgTWFsYWluZXkgPGN1am9tYWxhaW5leUBjaHJvbWl1
bS5vcmc+CkRhdGU6IFR1ZSwgMjIgSmFuIDIwMTkgMjE6MjM6MjEgLTA4MDAKU3ViamVjdDogW1BB
VENIXSBBU29DOiBzb2MtY29yZTogY2xlYXIgcGxhdGZvcm0gcG9pbnRlcnMgb24gZXJyb3IKCk9y
aWdpbmFsbHkgc25kX3NvY19pbml0X3BsYXRmb3JtIHdhcyBub3QgY2xlYW5pbmcgdXAgaXRzIHBv
aW50ZXJzLCB0aGlzCndhcyBmaXhlZCB0byBhbHdheXMgcmVhbGxvY2F0ZSBkeW5hbWljIG1lbW9y
eSBidXQgY3JlYXRlZCBhIG1lbW9yeSBsZWFrCndoZW4gc25kX3NvY19pbml0X3BsYXRmb3JtIHdh
cyBjYWxsZWQgbXVsdGlwbGUgdGltZXMgZHVyaW5nIHRoZSBzYW1lCnByb2JlIGF0dGVtcHQgYW5k
IGFsc28gdGhyZXcgYXdheSBhbnkgY2hhbmdlcyBtYWRlIHRvIHRoZSBzdHJ1Y3QgYmV0d2Vlbgpj
YWxscy4gSW4gb3JkZXIgdG8gYWNvaWQgcmVhbGxvY2F0aW5nIG1lbW9yeSB0aGF0IGlzIHN0aWxs
IHZhbGlkLCB0aGUKYmVoYXZpb3VyIHdpbGwgYmUgY2hhbmdlZCB0byBjbGVhciB0aGUgZHluYW1p
Y2FsbHkgc2V0IHBvaW50ZXJzIG9uIGEKcHJvYmUgZXJyb3IgYW5kIGEgdW5yZWdpc3RlciBldmVu
dCBhbmQgc25kX3NvY19pbml0X3BsYXRmb3JtIHdpbGwgZ28KYmFjayB0byBpdHMgb3JpZ2luYWwg
YmVoYXZpb3VyIG9mIG9ubHkgYWxsb2NhdGluZyBudWxsIHBvaW50ZXJzIHNvIGl0IHdpbGwKc3Rv
cCB0aHJvd2luZyBhd2F5IHZhbGlkIGNoYW5nZXMuCgpDaGFuZ2UtSWQ6IEliZGVhYzA0MTg2OGRl
YzA5NTU4OGNkMzM5ZTI0OTk1NjllMzVlZjVjClNpZ25lZC1vZmYtYnk6IEN1cnRpcyBNYWxhaW5l
eSA8Y3Vqb21hbGFpbmV5QGNocm9taXVtLm9yZz4KLS0tCiBzb3VuZC9zb2Mvc29jLWNvcmUuYyB8
IDIxICsrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc29jLWNvcmUuYyBiL3Nv
dW5kL3NvYy9zb2MtY29yZS5jCmluZGV4IDhhNThmYTg2Njc1YS4uYjczNTRlYTQ3MjVlIDEwMDY0
NAotLS0gYS9zb3VuZC9zb2Mvc29jLWNvcmUuYworKysgYi9zb3VuZC9zb2Mvc29jLWNvcmUuYwpA
QCAtMTA0OSw3ICsxMDQ5LDcgQEAgc3RhdGljIGludCBzbmRfc29jX2luaXRfcGxhdGZvcm0oc3Ry
dWN0IHNuZF9zb2NfY2FyZCAqY2FyZCwKIAkgKglzb2MuaCA6OiBzdHJ1Y3Qgc25kX3NvY19kYWlf
bGluawogCSAqLwogCS8qIGNvbnZlcnQgTGVnYWN5IHBsYXRmb3JtIGxpbmsgKi8KLQlpZiAoIXBs
YXRmb3JtIHx8IGRhaV9saW5rLT5sZWdhY3lfcGxhdGZvcm0pIHsKKwlpZiAoIXBsYXRmb3JtKSB7
CiAJCXBsYXRmb3JtID0gZGV2bV9remFsbG9jKGNhcmQtPmRldiwKIAkJCQlzaXplb2Yoc3RydWN0
IHNuZF9zb2NfZGFpX2xpbmtfY29tcG9uZW50KSwKIAkJCQlHRlBfS0VSTkVMKTsKQEAgLTEwNzIs
NiArMTA3MiwyNCBAQCBzdGF0aWMgaW50IHNuZF9zb2NfaW5pdF9wbGF0Zm9ybShzdHJ1Y3Qgc25k
X3NvY19jYXJkICpjYXJkLAogCXJldHVybiAwOwogfQogCitzdGF0aWMgdm9pZCBzb2NfY2xlYW51
cF9wbGF0Zm9ybShzdHJ1Y3Qgc25kX3NvY19jYXJkICpjYXJkKQoreworCXN0cnVjdCBzbmRfc29j
X2RhaV9saW5rICpsaW5rOworCWludCBpOworCS8qCisJICogRklYTUUKKwkgKgorCSAqIHRoaXMg
ZnVuY3Rpb24gc2hvdWxkIGJlIHJlbW92ZWQgd2l0aCBzbmRfc29jX2luaXRfcGxhdGZvcm0KKwkg
Ki8KKworCWZvcl9lYWNoX2NhcmRfcHJlbGlua3MoY2FyZCwgaSwgbGluaykgeworCQlpZiAobGlu
ay0+bGVnYWN5X3BsYXRmb3JtKSB7CisJCQlsaW5rLT5sZWdhY3lfcGxhdGZvcm0gPSAwOworCQkJ
bGluay0+cGxhdGZvcm1zICAgICAgID0gTlVMTDsKKwkJfQorCX0KK30KKwogc3RhdGljIGludCBz
bmRfc29jX2luaXRfbXVsdGljb2RlYyhzdHJ1Y3Qgc25kX3NvY19jYXJkICpjYXJkLAogCQkJCSAg
IHN0cnVjdCBzbmRfc29jX2RhaV9saW5rICpkYWlfbGluaykKIHsKQEAgLTIwMTYsNiArMjAzNCw3
IEBAIHN0YXRpYyBpbnQgc29jX2NsZWFudXBfY2FyZF9yZXNvdXJjZXMoc3RydWN0IHNuZF9zb2Nf
Y2FyZCAqY2FyZCkKIAkvKiByZW1vdmUgYW5kIGZyZWUgZWFjaCBEQUkgKi8KIAlzb2NfcmVtb3Zl
X2RhaV9saW5rcyhjYXJkKTsKIAlzb2NfcmVtb3ZlX3BjbV9ydW50aW1lcyhjYXJkKTsKKwlzb2Nf
Y2xlYW51cF9wbGF0Zm9ybShjYXJkKTsKIAogCS8qIHJlbW92ZSBhdXhpbGlhcnkgZGV2aWNlcyAq
LwogCXNvY19yZW1vdmVfYXV4X2RldmljZXMoY2FyZCk7Ci0tIAoyLjIwLjEuMzIxLmc5ZTc0MDU2
OGNlLWdvb2cKCg==
--0000000000002711a205803e4eae
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0000000000002711a205803e4eae--
