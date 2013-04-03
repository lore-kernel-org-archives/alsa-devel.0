From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: Re: [PATCH] salsa-lib: Add seq_midi_event.h
Date: Wed, 3 Apr 2013 09:42:40 +0000
Message-ID: <CAD-m0i8GLmX-PebZ31CpPD+RAv6g-4eVP9rinSeZyjBO6q+z9Q@mail.gmail.com>
References: <CAD-m0i9nfOnZ3dq3NS5hhVG+Dqf=Za7A6mTPxbfwnW-VQCDpoQ@mail.gmail.com>
 <s5hsj3qghc8.wl%tiwai@suse.de>
 <CAD-m0i9puLWgXgkrN66+km0_oAuQsp3n8jUv5kpzpfHw3Z6HHQ@mail.gmail.com>
 <s5hfvz98ebp.wl%tiwai@suse.de>
 <CAD-m0i89tPMuOCQ==LY4FqfJgakN4xhxX0Kc+Lab=9gJ7j3Bkw@mail.gmail.com>
 <s5htxno559g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec54307fcd7e6d104d971ac59
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id A4A1C26535C
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 11:42:42 +0200 (CEST)
Received: by mail-pd0-f176.google.com with SMTP id r11so752281pdi.35
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 02:42:41 -0700 (PDT)
In-Reply-To: <s5htxno559g.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--bcaec54307fcd7e6d104d971ac59
Content-Type: text/plain; charset=ISO-8859-1

2013/4/3, Takashi Iwai <tiwai@suse.de>:
> At Tue, 2 Apr 2013 11:56:50 +0000,
> Mihail Zenkov wrote:
>>
>> This patch add seq_midi_event.h. All replaced with dummy functions.
>
> Your MUA breaks the lines so the patch isn't applicable.
> Please fix MUA setup or use an attachment as a last resort.

Sorry, add as attachment.

--bcaec54307fcd7e6d104d971ac59
Content-Type: application/octet-stream; name="salsa-lib-seq_header.patch"
Content-Disposition: attachment; filename="salsa-lib-seq_header.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

VGhpcyBwYXRjaCBhZGQgc2VxX21pZGlfZXZlbnQuaC4gQWxsIHJlcGxhY2VkIHdpdGggZHVtbXkg
ZnVuY3Rpb25zLgoKLS0tIHNhbHNhLWxpYi05ZTZiNTJmMTQ4ZmI1YTYzNTJmNDQxZDBiNWE0MTQx
OWMzYTU3Yzc5L2NvbmZpZ3VyZS5hYworKysgc2Fsc2EtbGliLTllNmI1MmYxNDhmYjVhNjM1MmY0
NDFkMGI1YTQxNDE5YzNhNTdjNzktMS9jb25maWd1cmUuYWMKQEAgLTI3Myw2ICsyNzMsNyBAQAog
dGVzdCAiJHNuZHNlcSIgPSAieWVzIiAmJiBlY2hvICIjaW5jbHVkZSBcInNlcV9ldmVudC5oXCIi
ID4+IHNyYy9hc291bmRsaWIuaAogdGVzdCAiJHNuZHNlcSIgPSAieWVzIiAmJiBlY2hvICIjaW5j
bHVkZSBcInNlcS5oXCIiID4+IHNyYy9hc291bmRsaWIuaAogdGVzdCAiJHNuZHNlcSIgPSAieWVz
IiAmJiBlY2hvICIjaW5jbHVkZSBcInNlcW1pZC5oXCIiID4+IHNyYy9hc291bmRsaWIuaAordGVz
dCAiJHNuZHNlcSIgPSAieWVzIiAmJiBlY2hvICIjaW5jbHVkZSBcInNlcV9taWRpX2V2ZW50Lmhc
IiIgPj4gc3JjL2Fzb3VuZGxpYi5oCiBjYXQgIiRzcmNkaXIiL3NyYy9hc291bmRsaWItdGFpbC5o
ID4+IHNyYy9hc291bmRsaWIuaAogCiBlY2hvICJTQUxTQS1MaWIgYnVpbGQgY29uZmlndXJhdGlv
bjoiCi0tLSBzYWxzYS1saWItOWU2YjUyZjE0OGZiNWE2MzUyZjQ0MWQwYjVhNDE0MTljM2E1N2M3
OS9zcmMvTWFrZWZpbGUuYW0KKysrIHNhbHNhLWxpYi05ZTZiNTJmMTQ4ZmI1YTYzNTJmNDQxZDBi
NWE0MTQxOWMzYTU3Yzc5LTEvc3JjL01ha2VmaWxlLmFtCkBAIC02MCw3ICs2MCw3IEBACiBlbmRp
ZgogaWYgQlVJTERfU0VRCiBhbHNhaW5jbHVkZV9IRUFERVJTICs9IFwKLQlzZXEuaCBzZXFfZXZl
bnQuaCBzZXFtaWQuaAorCXNlcS5oIHNlcV9ldmVudC5oIHNlcW1pZC5oIHNlcV9taWRpX2V2ZW50
LmgKIGVuZGlmCiAKIG5vaW5zdF9IRUFERVJTID0gbG9jYWwuaCAKLS0tIC9kZXYvbnVsbAorKysg
c2Fsc2EtbGliLTllNmI1MmYxNDhmYjVhNjM1MmY0NDFkMGI1YTQxNDE5YzNhNTdjNzktMS9zcmMv
c2VxX21pZGlfZXZlbnQuaApAQCAtMCwwICsxLDUyIEBACisjaWZuZGVmIF9fQUxTQV9TRVFfTUlE
SV9FVkVOVF9ICisjZGVmaW5lIF9fQUxTQV9TRVFfTUlESV9FVkVOVF9ICisKK3R5cGVkZWYgc3Ry
dWN0IHNuZF9taWRpX2V2ZW50IHNuZF9taWRpX2V2ZW50X3Q7CisKK19fU0FMU0FfRVhQT1JUX0ZV
TkMKK2ludCBzbmRfbWlkaV9ldmVudF9uZXcoc2l6ZV90IGJ1ZnNpemUsIHNuZF9taWRpX2V2ZW50
X3QgKipyZGV2KQoreworCXJldHVybiAtRU5PTUVNOworfQorX19TQUxTQV9FWFBPUlRfRlVOQwor
aW50IHNuZF9taWRpX2V2ZW50X3Jlc2l6ZV9idWZmZXIoc25kX21pZGlfZXZlbnRfdCAqZGV2LCBz
aXplX3QgYnVmc2l6ZSkKK3sKKwlyZXR1cm4gLUVOT01FTTsKK30KK19fU0FMU0FfRVhQT1JUX0ZV
TkMKK3ZvaWQgc25kX21pZGlfZXZlbnRfZnJlZShzbmRfbWlkaV9ldmVudF90ICpkZXYpCit7Cit9
CitfX1NBTFNBX0VYUE9SVF9GVU5DCit2b2lkIHNuZF9taWRpX2V2ZW50X2luaXQoc25kX21pZGlf
ZXZlbnRfdCAqZGV2KQoreworfQorX19TQUxTQV9FWFBPUlRfRlVOQwordm9pZCBzbmRfbWlkaV9l
dmVudF9yZXNldF9lbmNvZGUoc25kX21pZGlfZXZlbnRfdCAqZGV2KQoreworfQorX19TQUxTQV9F
WFBPUlRfRlVOQwordm9pZCBzbmRfbWlkaV9ldmVudF9yZXNldF9kZWNvZGUoc25kX21pZGlfZXZl
bnRfdCAqZGV2KQoreworfQorX19TQUxTQV9FWFBPUlRfRlVOQwordm9pZCBzbmRfbWlkaV9ldmVu
dF9ub19zdGF0dXMoc25kX21pZGlfZXZlbnRfdCAqZGV2LCBpbnQgb24pCit7Cit9CitfX1NBTFNB
X0VYUE9SVF9GVU5DCitsb25nIHNuZF9taWRpX2V2ZW50X2VuY29kZShzbmRfbWlkaV9ldmVudF90
ICpkZXYsIGNvbnN0IHVuc2lnbmVkIGNoYXIgKmJ1ZiwgbG9uZyBjb3VudCwgc25kX3NlcV9ldmVu
dF90ICpldikKK3sKKwlyZXR1cm4gLUVJTlZBTDsKK30KK19fU0FMU0FfRVhQT1JUX0ZVTkMKK2lu
dCBzbmRfbWlkaV9ldmVudF9lbmNvZGVfYnl0ZShzbmRfbWlkaV9ldmVudF90ICpkZXYsIGludCBj
LCBzbmRfc2VxX2V2ZW50X3QgKmV2KQoreworCXJldHVybiAtRUlOVkFMOworfQorX19TQUxTQV9F
WFBPUlRfRlVOQworbG9uZyBzbmRfbWlkaV9ldmVudF9kZWNvZGUoc25kX21pZGlfZXZlbnRfdCAq
ZGV2LCB1bnNpZ25lZCBjaGFyICpidWYsIGxvbmcgY291bnQsIGNvbnN0IHNuZF9zZXFfZXZlbnRf
dCAqZXYpCit7CisJcmV0dXJuIC1FTk9FTlQ7Cit9CisKKyNlbmRpZiAvKiBfX0FMU0FfU0VRX01J
RElfRVZFTlRfSCAqLwo=
--bcaec54307fcd7e6d104d971ac59
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--bcaec54307fcd7e6d104d971ac59--
