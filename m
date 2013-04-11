From: Stas Sergeev <stsp@list.ru>
Subject: Re: [PATCH] asoc: add dummy codec
Date: Thu, 11 Apr 2013 19:11:17 +0400
Message-ID: <5166D295.2070400@list.ru>
References: <51669249.8090100@list.ru> <51669353.7090903@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050203080805050000090004"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [94.100.177.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F1F42610AD
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 17:11:26 +0200 (CEST)
In-Reply-To: <51669353.7090903@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Steve Chen <schen@mvista.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050203080805050000090004
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

11.04.2013 14:41, Lars-Peter Clausen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On 04/11/2013 12:36 PM, Stas Sergeev wrote:
>> Hi.
>>
>> The attached patch adds a dummy codec for the
>> asoc subsystem.
>> I use it with the driver that programs the soc to drive
>> I2S from an internal PLLs, and the audio then goes to
>> HDMI, so no external codec is used.
>> I've found spdif_transciever.c, which exactly is such a
>> dummy driver, but it is bound to the particular plat
>> device, so I made the device name a config option, and
>> if not set, the plat device is created with the default
>> name.
>>
>> It may be possible to avoid the usage of the codec driver
>> at all, but I haven't succeeded with this, and the existance
>> of spdif_transciever.c suggests there is no such way.
>> Thoughts?
>>
>> Signed-off-by: Stas Sergeev <stsp@users.sourceforge.net>
>>
> Hi,
>
> There is already a dummy codec driver.
>
> Please take a look at sound/soc/soc-utils.c
>
> - Lars
Lars, indeed, this codec is present in a git kernel and
it wasn't in mine android kernel.
But, that driver is too dummy to even work at all.

The attached patch adds a playback stream for the dummy
codec. Would it be possible to apply this?

Signed-off-by: Stas Sergeev <stsp@users.sourceforge.net>


--------------050203080805050000090004
Content-Type: application/x-patch;
 name="0001-asoc-define-playback-stream-in-dummy-codec.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-asoc-define-playback-stream-in-dummy-codec.patch"

RnJvbSA5NzIzZWMzN2VkODZiMTU2NTAyZmM3OTcyYTFiZGVkMzVjNGU1NWMzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGFzIFNlcmdlZXYgPHN0c3BAdXNlcnMuc291cmNl
Zm9yZ2UubmV0PgpEYXRlOiBUaHUsIDExIEFwciAyMDEzIDE5OjA3OjIwICswNDAwClN1Ympl
Y3Q6IFtQQVRDSF0gYXNvYzogZGVmaW5lIHBsYXliYWNrIHN0cmVhbSBpbiBkdW1teSBjb2Rl
YwoKLS0tCiBzb3VuZC9zb2Mvc29jLXV0aWxzLmMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc29jLXV0aWxz
LmMgYi9zb3VuZC9zb2Mvc29jLXV0aWxzLmMKaW5kZXggZmU0NTQxZC4uNTNlM2M4OSAxMDA2
NDQKLS0tIGEvc291bmQvc29jL3NvYy11dGlscy5jCisrKyBiL3NvdW5kL3NvYy9zb2MtdXRp
bHMuYwpAQCAtOTIsNiArOTIsMTMgQEAgc3RhdGljIHN0cnVjdCBzbmRfc29jX3BsYXRmb3Jt
X2RyaXZlciBkdW1teV9wbGF0Zm9ybSA9IHsKIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19jb2Rl
Y19kcml2ZXIgZHVtbXlfY29kZWM7CiBzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2RyaXZl
ciBkdW1teV9kYWkgPSB7CiAJLm5hbWUgPSAic25kLXNvYy1kdW1teS1kYWkiLAorCS5wbGF5
YmFjayAJPSB7CisJCS5zdHJlYW1fbmFtZQk9ICJQbGF5YmFjayIsCisJCS5jaGFubmVsc19t
aW4JPSAxLAorCQkuY2hhbm5lbHNfbWF4CT0gMzg0LAorCQkucmF0ZXMJCT0gU05EUlZfUENN
X1JBVEVfODAwMF85NjAwMCwKKwkJLmZvcm1hdHMJPSBTTkRSVl9QQ01fRk1UQklUX1MxNl9M
RSwKKwl9LAogfTsKIAogc3RhdGljIGludCBzbmRfc29jX2R1bW15X3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpCi0tIAoxLjcuMTEuNwoK
--------------050203080805050000090004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050203080805050000090004--
