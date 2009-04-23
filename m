From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC PATCH 5/5] ASoC: simplify the SSP DMA
	parameters settings by run-time generation
Date: Thu, 23 Apr 2009 17:57:46 +0800
Message-ID: <f17812d70904230257h4a72b03oa26f69663859b9b6@mail.gmail.com>
References: <f17812d70904222208i79604f3evb9950d6351377a83@mail.gmail.com>
	<74d0deb30904230153l5ec490eck211d6ef456869f36@mail.gmail.com>
	<f17812d70904230202t5dc459bbud36c13b11c6d5725@mail.gmail.com>
	<20090423090810.GD30105@sirena.org.uk>
	<f17812d70904230228j394713cbj4f99803d6031387d@mail.gmail.com>
	<20090423093435.GH30105@sirena.org.uk>
	<f17812d70904230241y31291230j85646ac09a72a3cd@mail.gmail.com>
	<20090423094438.GI30105@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364eef74764ff2046835e99d
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FC3F103854
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 11:57:57 +0200 (CEST)
Received: by qyk1 with SMTP id 1so872942qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2009 02:57:46 -0700 (PDT)
In-Reply-To: <20090423094438.GI30105@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

--0016364eef74764ff2046835e99d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Apr 23, 2009 at 5:44 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Apr 23, 2009 at 05:41:55PM +0800, Eric Miao wrote:
>
>> I'd prefer this being added to the original one, provided that you haven't
>> merged and pushed to public. Patch below:
>
> This is word wrapped again and I've already published the changes
> (though only minutes ago so...).
>

Gmail web interface, sorry. That's why I attached the original file.
Now the incremental patch as attached.

-- 
Cheers
- eric

--0016364eef74764ff2046835e99d
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ASoC-change-stereo-mono-to-32-bit-16-bit-for-pxa-ss.patch"
Content-Disposition: attachment;
	filename="0001-ASoC-change-stereo-mono-to-32-bit-16-bit-for-pxa-ss.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ftva36ao0

RnJvbSBlMjAzNzMzNGQ3N2U0ODI2YWFlYmY1ODAwZWVlNDZmNDA5YjBhNjk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmljIE1pYW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNvbT4KRGF0
ZTogVGh1LCAyMyBBcHIgMjAwOSAxNzo0ODo1NiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFTb0M6
IGNoYW5nZSBzdGVyZW8vbW9ubyB0byAzMi1iaXQvMTYtYml0IGZvciBweGEtc3NwCgpUaGUgb3Jp
Z2luYWwgaWRlYSBjYW1lIGZyb20gcEhpbGlwcCwgYW5kIHRoaXMgbWFrZXMgdGhlIGNvZGUgbG9v
a3MKbW9yZSBjb25zaXN0ZW50LgoKU2lnbmVkLW9mZi1ieTogcEhpbGlwcCBaYWJlbCA8cGhpbGlw
cC56YWJlbEBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEVyaWMgTWlhbyA8ZXJpYy5taWFvQG1h
cnZlbGwuY29tPgotLS0KIHNvdW5kL3NvYy9weGEvcHhhLXNzcC5jIHwgICAgNiArKystLS0KIDEg
ZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3NvdW5kL3NvYy9weGEvcHhhLXNzcC5jIGIvc291bmQvc29jL3B4YS9weGEtc3NwLmMKaW5k
ZXggZmI4Y2FjYy4uNmZjNzg3NiAxMDA2NDQKLS0tIGEvc291bmQvc29jL3B4YS9weGEtc3NwLmMK
KysrIGIvc291bmQvc29jL3B4YS9weGEtc3NwLmMKQEAgLTY3LDcgKzY3LDcgQEAgc3RydWN0IHB4
YTJ4eF9wY21fZG1hX2RhdGEgewogfTsKIAogc3RhdGljIHN0cnVjdCBweGEyeHhfcGNtX2RtYV9w
YXJhbXMgKgotc3NwX2dldF9kbWFfcGFyYW1zKHN0cnVjdCBzc3BfZGV2aWNlICpzc3AsIGludCBz
dGVyZW8sIGludCBvdXQpCitzc3BfZ2V0X2RtYV9wYXJhbXMoc3RydWN0IHNzcF9kZXZpY2UgKnNz
cCwgaW50IHdpZHRoNCwgaW50IG91dCkKIHsKIAlzdHJ1Y3QgcHhhMnh4X3BjbV9kbWFfZGF0YSAq
ZG1hOwogCkBAIC03NiwxMyArNzYsMTMgQEAgc3NwX2dldF9kbWFfcGFyYW1zKHN0cnVjdCBzc3Bf
ZGV2aWNlICpzc3AsIGludCBzdGVyZW8sIGludCBvdXQpCiAJCXJldHVybiBOVUxMOwogCiAJc25w
cmludGYoZG1hLT5uYW1lLCAyMCwgIlNTUCVkIFBDTSAlcyAlcyIsIHNzcC0+cG9ydF9pZCwKLQkJ
CXN0ZXJlbyA/ICJTdGVyZW8iIDogIk1vbm8iLCBvdXQgPyAib3V0IiA6ICJpbiIpOworCQkJd2lk
dGg0ID8gIjMyLWJpdCIgOiAiMTYtYml0Iiwgb3V0ID8gIm91dCIgOiAiaW4iKTsKIAogCWRtYS0+
cGFyYW1zLm5hbWUgPSBkbWEtPm5hbWU7CiAJZG1hLT5wYXJhbXMuZHJjbXIgPSAmRFJDTVIob3V0
ID8gc3NwLT5kcmNtcl90eCA6IHNzcC0+ZHJjbXJfcngpOwogCWRtYS0+cGFyYW1zLmRjbWQgPSAo
b3V0ID8gKERDTURfSU5DU1JDQUREUiB8IERDTURfRkxPV1RSRykgOgogCQkJCSAgKERDTURfSU5D
VFJHQUREUiB8IERDTURfRkxPV1NSQykpIHwKLQkJCShzdGVyZW8gPyBEQ01EX1dJRFRINCA6IERD
TURfV0lEVEgyKSB8IERDTURfQlVSU1QxNjsKKwkJCSh3aWR0aDQgPyBEQ01EX1dJRFRINCA6IERD
TURfV0lEVEgyKSB8IERDTURfQlVSU1QxNjsKIAlkbWEtPnBhcmFtcy5kZXZfYWRkciA9IHNzcC0+
cGh5c19iYXNlICsgU1NEUjsKIAogCXJldHVybiAmZG1hLT5wYXJhbXM7Ci0tIAoxLjYuMC40Cgo=
--0016364eef74764ff2046835e99d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016364eef74764ff2046835e99d--
