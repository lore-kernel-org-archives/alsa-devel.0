From: Christian Hartmann <cornogle@googlemail.com>
Subject: [PATCH spi-pxa2xx.c 1/1] : fix spi init of WM510205
 codec via ACPI, the chip hangs on chipselect 1
Date: Thu, 11 Jun 2015 15:04:38 +0200
Message-ID: <CAKor6TezwST=8qR9wuAojvLfxtzrDw+W3vDMP0i_GR+W1eijuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a114905e650de3805183da2fd
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f177.google.com (mail-qk0-f177.google.com
 [209.85.220.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A1942664BB
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 15:04:43 +0200 (CEST)
Received: by qkx62 with SMTP id 62so2686172qkx.3
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 06:04:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patches@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001a114905e650de3805183da2fd
Content-Type: text/plain; charset=UTF-8

Hello,

I have one patch that enables the spi initialization of the WM510205 audio codec
Without the patch, this message indicates that the codec chip fails
with the current chipselect number in spi-pxa2xx:

[    0.296256] pxa2xx-spi 80860F0E:00: cs1 >= max 1
[    0.296270] spi_master spi32766: failed to add SPI device
WM510205:00 from ACPI

So raise num_chipselect by one to enable the codec. The WM510202 is on
chipselect = 1.

With the patch applied I got in dmesg now:

[    6.056829] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
[    6.067035] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
[    6.067214] spi spi-WM510205:00: 8333333 Hz actual, PIO
[    6.067221] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
[    6.067287] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00

would be nice to hear some feedback or comments about this patch.

Notice: Thats my first attempt to make the codec chip via ACPI
working on Linux systems and some other patches are needed to let the
codec work together with the intel_sst_acpi driver. Currently I am
trying to write the also needed machine driver which binds to this
codec chip.
But I can need help from others too, cause I am not so familiar with
the Intel SST ACPI stuff and the baytrail code itself, nor with the
arizona stuff...

cheers
Chris

--001a114905e650de3805183da2fd
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-spi-pxa2xx-raise-num_chipselect-for-this-platform-da.patch"
Content-Disposition: attachment;
	filename="0001-spi-pxa2xx-raise-num_chipselect-for-this-platform-da.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ias765100

RnJvbSBiMGU0MzRkZjExNWQ4YmI5NGMzZGU4MGRjYTY2MGQ1ZDQ0YWM1MmZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gSGFydG1hbm4gPGNvcm5vZ2xlQGdvb2dsZW1h
aWwuY29tPgpEYXRlOiBUaHUsIDExIEp1biAyMDE1IDE0OjUxOjIwICswMjAwClN1YmplY3Q6IFtQ
QVRDSF0gc3BpLXB4YTJ4eCA6IHJhaXNlIG51bV9jaGlwc2VsZWN0IGZvciB0aGlzIHBsYXRmb3Jt
IGRhdGEgaW4KIHB4YTJ4eF9zcGlfYWNwaV9nZXRfcGRhdGEoKQoKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEhhcnRtYW5uIDxjb3Jub2dsZUBnb29nbGVtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL3Nw
aS9zcGktcHhhMnh4LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktcHhhMnh4LmMgYi9kcml2
ZXJzL3NwaS9zcGktcHhhMnh4LmMKaW5kZXggZTMyMjNhYy4uN2I1NGIwNCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9zcGkvc3BpLXB4YTJ4eC5jCisrKyBiL2RyaXZlcnMvc3BpL3NwaS1weGEyeHguYwpA
QCAtMTI3OSw3ICsxMjc5LDcgQEAgcHhhMnh4X3NwaV9hY3BpX2dldF9wZGF0YShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQogCWlmIChhZGV2LT5wbnAudW5pcXVlX2lkICYmICFrc3RydG9p
bnQoYWRldi0+cG5wLnVuaXF1ZV9pZCwgMCwgJmRldmlkKSkKIAkJc3NwLT5wb3J0X2lkID0gZGV2
aWQ7CiAKLQlwZGF0YS0+bnVtX2NoaXBzZWxlY3QgPSAxOworCXBkYXRhLT5udW1fY2hpcHNlbGVj
dCA9IDI7CiAJcGRhdGEtPmVuYWJsZV9kbWEgPSB0cnVlOwogCiAJcmV0dXJuIHBkYXRhOwotLSAK
MS44LjMuMQoK
--001a114905e650de3805183da2fd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a114905e650de3805183da2fd--
