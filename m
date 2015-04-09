From: noman pouigt <variksla@gmail.com>
Subject: Re: recording problem in beagleboard-mcbsp
Date: Thu, 9 Apr 2015 16:02:40 -0700
Message-ID: <CAES_P+-5vgq1LxSsUQLua4j06M4U8+ogLgnEK5KJ-4QPJs1vJQ@mail.gmail.com>
References: <CAES_P+8NEcMfDSDVT5d0UHU4mo8d2-3rJg31zf5GRT0HaLVXYw@mail.gmail.com>
 <CAES_P+-yk29wzBMhO3uYjr1fnXt8iyskr77QLc=AvwCuX=Najg@mail.gmail.com>
 <CAES_P+-ufoqcY++WzvS42tyQLfd2zzuANNp2rPwuUk3x_Tn-jg@mail.gmail.com>
 <551C3D19.2050200@ti.com>
 <CAES_P+_zc1u=grsF4J3rH+uwamWTOrgQKYmcY-9p6b=W9-PxUA@mail.gmail.com>
 <5523A1F3.2000701@ti.com>
 <CAES_P+_nr4LvcU-WQ=ZuhNwCSRuUs=xenqKGpupYAgx01fnATg@mail.gmail.com>
 <5524FA51.9060606@ti.com>
 <CAES_P+8oJ0xDJ-2w02Q0pZmgQyY9tyaRB=+_PqMhTdwuYNRShw@mail.gmail.com>
 <55266B38.6030503@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1134aaae0556a6051352a5ea
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
 [209.85.214.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 748E02605A3
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 01:02:41 +0200 (CEST)
Received: by obbfy7 with SMTP id fy7so2792769obb.2
 for <alsa-devel@alsa-project.org>; Thu, 09 Apr 2015 16:02:40 -0700 (PDT)
In-Reply-To: <55266B38.6030503@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--001a1134aaae0556a6051352a5ea
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2015 at 5:06 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrot=
e:
> On 04/09/2015 02:44 AM, noman pouigt wrote:
>>> First check the /proc/asound/card0/pcm0c/sub0/status while the capture =
is
>>> running and look at the hw_ptr if it has moved at all.
>>
>> It has not moved at all.
>
> So McBSP does not detect start condition on the FS line.
>
>>> Enable more interrupts in sound/soc/omap/mcbsp.c:omap_mcbsp_config(), l=
ike
>>> RUNDFLEN, ROVFLEN and see if you have overflow in McBSP.
>>
>> I did enable the interrupt but all i am getting is below for both
>> playback and capture
>> usecase:
>> omap-mcbsp 48074000.mcbsp: RX Buffer Underflow!
>
> This is because you dump the registers and it read the DDR register. The =
FIFO
> is empty and you try to read data out.
>
>> Remember playback is working in both the slave and master mode (codec sl=
ave
>> and codec master).
>>>
>>> If the DMA has not moved it means that McBSP does not received the FS w=
hich
>>> would indicate the frame start, thus it will not sample data in, thus i=
t will
>>> not trigger the DMA to read the data out.
>>
>> Used scope to check FS and Bit clock and found below (running arecord
>> with 44100):
>> bit clock is running at 1.420 MHz and FS at 44100 kHz. Configured MCBsp
>> in master mode this time.
>>
>>>
>>> Since the capture is working on McBSP2 in McBSP slave (and master also)=
 the
>>> only thing which can be wrong is the way the max98090 is wired up or so=
me mux
>>> issue again as it was before for you.
>>
>> Below is the mux setting which i did and because of which playback is wo=
rking:
>> MCBsp in master mode
>> configured mcbsp1_clkx, mcbsp1_fsx, mcbsp1_dx and mcbsp1_dr
>> +
>> +       mcbsp1_pins: pinmux_mcbsp1_pins {
>> +                pinctrl-single,pins =3D <
>> +                        OMAP3_CORE1_IOPAD(0x2196, PIN_OUTPUT | MUX_MODE=
0)
>> +                        OMAP3_CORE1_IOPAD(0x2198, PIN_OUTPUT | MUX_MODE=
0)
>> +                        OMAP3_CORE1_IOPAD(0x2190, PIN_OUTPUT | MUX_MODE=
0)
>> +                        OMAP3_CORE1_IOPAD(0x2192, PIN_INPUT | MUX_MODE0=
)
>> +                        OMAP3_CORE1_IOPAD(0x218C, PIN_OUTPUT | MUX_MODE=
0)
>> +                >;
>> +        };
>>  };
>>
>> Even if MCBSP_DR is not connected properly it should record atleast nois=
e.
>>
>> I also tried Thomas Niederpr=C3=BCm below advice when running McBsp in s=
lave mode
>> shorten the CLKR and CLKX pins and mux the CLKR pin as INPUT in your
>> dts. Then your
>> bitclock would enter through CLKR as well as CLKX.
>> But this also didn't work.
>>
>> Found out only below register changes between playback and capture:
>> In playback
>> SPCR2: 0x02f5
>> SPCR1: 0x0030
>> In capture:
>> SPCR2: 0x02f0
>> SPCR1: 0x0031
>>
>> There are no difference between any other register. I think mcbsp
>> registers are fine
>> but can you confirm if there should be any more differences?
>> Please advice what might be going wrong?
>
> Hrm, McBSP1 is kind of problematic port since it has 6pin config by defau=
lt.
> It might worth a try to do something like:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/113058.=
html
> has removed.
This patch seems pretty old and I am not able to apply it as i am
using latest kernel.
kernel: 3.19

> Or to switch to use McBSP3.

tried this as well but even playback didn't work.
+       mcbsp3_pins: pinmux_mcbsp3_pins {
+                pinctrl-single,pins =3D <
+                        OMAP3_CORE1_IOPAD(0x216C, PIN_OUTPUT | MUX_MODE1)
+                        OMAP3_CORE1_IOPAD(0x216E, PIN_INPUT | MUX_MODE1)
+                        OMAP3_CORE1_IOPAD(0x2170, PIN_OUTPUT | MUX_MODE1)
+                        OMAP3_CORE1_IOPAD(0x2172, PIN_OUTPUT | MUX_MODE0)
+                >;
+        };

attached patch where i replaced the mcbsp1 to mcbsp3 number in machine file=
.
do you think this configuration is  right? I tried both master and slave mo=
de
and both didn't work but i was getting right bit clock and FS clock.

>
> But for some reason now I can not get the recording working via McBSP1 ei=
ther.
> I remember that it worked not that long time ago...
>
> --
> P=C3=A9ter

--001a1134aaae0556a6051352a5ea
Content-Type: text/x-patch; charset=US-ASCII; name="mcbsp3.patch"
Content-Disposition: attachment; filename="mcbsp3.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i8arq64h0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXAzLWJlYWdsZS14bS5kdHMgYi9hcmNo
L2FybS9ib290L2R0cy9vbWFwMy1iZWFnbGUteG0uZHRzCmluZGV4IDI1ZjdiMGEuLjIxNWViODYg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL29tYXAzLWJlYWdsZS14bS5kdHMKKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvb21hcDMtYmVhZ2xlLXhtLmR0cwpAQCAtNTksOCArNTksOCBAQAog
CQljb21wYXRpYmxlID0gInRpLG9tYXAtdHdsNDAzMCI7CiAJCXRpLG1vZGVsID0gIm9tYXAzYmVh
Z2xlIjsKIAotCQl0aSxtY2JzcCA9IDwmbWNic3AyPjsKLQkJdGksY29kZWMgPSA8JnR3bF9hdWRp
bz47CisJCXRpLG1jYnNwID0gPCZtY2JzcDM+OworCQl0aSxjb2RlYyA9IDwmbWF4OTgwOTA+Owog
CX07CiAKIAlncGlvX2tleXMgewpAQCAtMjQ2LDYgKzI0NiwxNSBAQAogCQkJT01BUDNfQ09SRTFf
SU9QQUQoMHgyMTBhLCBQSU5fT1VUUFVUIHwgTVVYX01PREUzKSAgIC8qIGRzc19kYXRhMjMuZHNz
X2RhdGE1ICovCiAJCT47CiAJfTsKKworICAgICAgIG1jYnNwM19waW5zOiBwaW5tdXhfbWNic3Az
X3BpbnMgeworICAgICAgICAgICAgICAgIHBpbmN0cmwtc2luZ2xlLHBpbnMgPSA8CisgICAgICAg
ICAgICAgICAgICAgICAgICBPTUFQM19DT1JFMV9JT1BBRCgweDIxNkMsIFBJTl9PVVRQVVQgfCBN
VVhfTU9ERTEpCisgICAgICAgICAgICAgICAgICAgICAgICBPTUFQM19DT1JFMV9JT1BBRCgweDIx
NkUsIFBJTl9JTlBVVCB8IE1VWF9NT0RFMSkKKyAgICAgICAgICAgICAgICAgICAgICAgIE9NQVAz
X0NPUkUxX0lPUEFEKDB4MjE3MCwgUElOX09VVFBVVCB8IE1VWF9NT0RFMSkKKyAgICAgICAgICAg
ICAgICAgICAgICAgIE9NQVAzX0NPUkUxX0lPUEFEKDB4MjE3MiwgUElOX09VVFBVVCB8IE1VWF9N
T0RFMCkKKyAgICAgICAgICAgICAgICA+OworICAgICAgICB9OwogfTsKIAogJm9tYXAzX3BteF9j
b3JlMiB7CkBAIC0yOTIsNiArMzAxLDExIEBACiAKICZpMmMyIHsKIAljbG9jay1mcmVxdWVuY3kg
PSA8NDAwMDAwPjsKKworCW1heDk4MDkwOiBtYXg5ODA5MEAxMCB7CisJCWNvbXBhdGlibGUgPSAi
bWF4aW0sbWF4OTgwOTAiOworCQlyZWcgPSA8MHgxMD47CisJfTsKIH07CiAKICZpMmMzIHsKQEAg
LTMzOSw2ICszNTMsNyBAQAogCXBpbmN0cmwtMCA9IDwmdWFydDNfcGlucz47CiB9OwogCisKICZn
cGlvMSB7CiAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKIAlwaW5jdHJsLTAgPSA8JmdwaW8x
X3BpbnM+OwpAQCAtMzYzLDYgKzM3OCwyMyBAQAogCXN0YXR1cyA9ICJva2F5IjsKIH07CiAKKy8q
Jm1jYnNwMSB7CisJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKKwlwaW5jdHJsLTAgPSA8Jm1j
YnNwMV9waW5zPjsKKworCXN0YXR1cyA9ICJva2F5IjsKK307Ki8KKworJm1jYnNwMSB7CisgICAg
ICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7Cit9OworCismbWNic3AzIHsKKwlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOworCXBpbmN0cmwtMCA9IDwmbWNic3AzX3BpbnM+OworCisJc3RhdHVzID0g
Im9rYXkiOworfTsKICZkc3MgewogCXN0YXR1cyA9ICJvayI7CiAKZGlmZiAtLWdpdCBhL3NvdW5k
L3NvYy9jb2RlY3MvbWF4OTgwOTAuYyBiL3NvdW5kL3NvYy9jb2RlY3MvbWF4OTgwOTAuYwppbmRl
eCBiMTEyYjFjLi5hNGMzNzQ4IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL21heDk4MDkw
LmMKKysrIGIvc291bmQvc29jL2NvZGVjcy9tYXg5ODA5MC5jCkBAIC0xOTk3LDYgKzE5OTcsMTAg
QEAgc3RhdGljIGludCBtYXg5ODA5MF9kYWlfaHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0
cmVhbSAqc3Vic3RyZWFtLAogCQlzbmRfc29jX3VwZGF0ZV9iaXRzKGNvZGVjLCBNOTgwOTBfUkVH
X0lOVEVSRkFDRV9GT1JNQVQsCiAJCQlNOTgwOTBfV1NfTUFTSywgMCk7CiAJCWJyZWFrOworCWNh
c2UgMjQ6CisJCXNuZF9zb2NfdXBkYXRlX2JpdHMoY29kZWMsIE05ODA5MF9SRUdfSU5URVJGQUNF
X0ZPUk1BVCwKKwkJCU05ODA5MF9XU19NQVNLLCAyKTsKKwkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJ
cmV0dXJuIC1FSU5WQUw7CiAJfQpAQCAtMjA4OSw2ICsyMDkzLDcgQEAgc3RhdGljIGludCBtYXg5
ODA5MF9kYWlfdHJpZ2dlcihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwgaW50
IGNtZCwKIAkJCQlzdHJ1Y3Qgc25kX3NvY19kYWkgKmRhaSkKIHsKIAlzdHJ1Y3Qgc25kX3NvY19j
b2RlYyAqY29kZWMgPSBkYWktPmNvZGVjOworCWludCByZWc7CiAJc3RydWN0IG1heDk4MDkwX3By
aXYgKm1heDk4MDkwID0gc25kX3NvY19jb2RlY19nZXRfZHJ2ZGF0YShjb2RlYyk7CiAKIAlzd2l0
Y2ggKGNtZCkgewpAQCAtMjU4OSwxNSArMjU5NCw2IEBAIHN0YXRpYyBpbnQgbWF4OTgwOTBfaTJj
X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICppMmMsCiAJCWdvdG8gZXJyX2VuYWJsZTsKIAl9CiAK
LQlyZXQgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKCZpMmMtPmRldiwgaTJjLT5pcnEsIE5V
TEwsCi0JCW1heDk4MDkwX2ludGVycnVwdCwgSVJRRl9UUklHR0VSX0ZBTExJTkcgfCBJUlFGX09O
RVNIT1QsCi0JCSJtYXg5ODA5MF9pbnRlcnJ1cHQiLCBtYXg5ODA5MCk7Ci0JaWYgKHJldCA8IDAp
IHsKLQkJZGV2X2VycigmaTJjLT5kZXYsICJyZXF1ZXN0X2lycSBmYWlsZWQ6ICVkXG4iLAotCQkJ
cmV0KTsKLQkJcmV0dXJuIHJldDsKLQl9Ci0KIAlyZXQgPSBzbmRfc29jX3JlZ2lzdGVyX2NvZGVj
KCZpMmMtPmRldiwKIAkJCSZzb2NfY29kZWNfZGV2X21heDk4MDkwLCBtYXg5ODA5MF9kYWksCiAJ
CQlBUlJBWV9TSVpFKG1heDk4MDkwX2RhaSkpOwpkaWZmIC0tZ2l0IGEvc291bmQvc29jL29tYXAv
b21hcC10d2w0MDMwLmMgYi9zb3VuZC9zb2Mvb21hcC9vbWFwLXR3bDQwMzAuYwppbmRleCBmYjFm
NmJiLi4zMTc2ZjFiIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mvb21hcC9vbWFwLXR3bDQwMzAuYwor
KysgYi9zb3VuZC9zb2Mvb21hcC9vbWFwLXR3bDQwMzAuYwpAQCAtNTQsNiArNTQsMTIgQEAgc3Rh
dGljIGludCBvbWFwX3R3bDQwMzBfaHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAq
c3Vic3RyZWFtLAogewogCXN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpydGQgPSBzdWJzdHJl
YW0tPnByaXZhdGVfZGF0YTsKIAl1bnNpZ25lZCBpbnQgZm10OworCXN0cnVjdCBzbmRfc29jX2Rh
aSAqY29kZWNfZGFpID0gcnRkLT5jb2RlY19kYWk7CisJc3RydWN0IHNuZF9zb2NfZGFpICpjcHVf
ZGFpID0gcnRkLT5jcHVfZGFpOworCWludCBlcnIgPSAwOworCWludCByZXQgPSAwOworI2lmIDAK
K2ludCBkaXYsIGNsa19pZCxmcmVxOwogCiAJc3dpdGNoIChwYXJhbXNfY2hhbm5lbHMocGFyYW1z
KSkgewogCWNhc2UgMjogLyogU3RlcmVvIEkyUyBtb2RlICovCkBAIC03MCw3ICs3Niw1OCBAQCBz
dGF0aWMgaW50IG9tYXBfdHdsNDAzMF9od19wYXJhbXMoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFt
ICpzdWJzdHJlYW0sCiAJCXJldHVybiAtRUlOVkFMOwogCX0KIAorCXNuZF9zb2NfcnVudGltZV9z
ZXRfZGFpX2ZtdChydGQsIGZtdCk7CisJc25kX3NvY19kYWlfc2V0X3N5c2Nsayhjb2RlY19kYWks
IDAsIDEzMDAwMDAwLAorCQlTTkRfU09DX0NMT0NLX0lOKTsKK2RpdiA9IGNsa19pZCA9IGZyZXEg
PSAwOworc3dpdGNoIChwYXJhbXNfcmF0ZShwYXJhbXMpKSB7CitjYXNlIDQ0MTAwOiAvKiA0NC4x
MTcgKi8KKyAgICAgICAgZGl2ID0gNjg7CisgICAgICAgIGNsa19pZCA9IE9NQVBfTUNCU1BfU1lT
Q0xLX0NMS1NfRkNMSzsKKyAgICAgICAgZnJlcSA9IDk2MDAwMDAwOworICAgICAgICBicmVhazsK
K2Nhc2UgNDgwMDA6IC8qIDQ4LjAzMiAqLworICAgICAgICBkaXYgPSA1NDsKKyAgICAgICAgY2xr
X2lkID0gT01BUF9NQ0JTUF9TWVNDTEtfQ0xLOworICAgICAgICBmcmVxID0gODMwMDAwMDA7Cisg
ICAgICAgIGJyZWFrOworZGVmYXVsdDoKKyAgICAgICAgcHJpbnRrKEtFUk5fRVJSICJodyBwYXJh
bXM6IHVua25vd24gcmF0ZSAlZFxuIiwKKyAgICAgICAgICAgICAgICBwYXJhbXNfcmF0ZShwYXJh
bXMpKTsKKyAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cit9CisKK3JldCA9IHNuZF9zb2NfZGFpX3Nl
dF9zeXNjbGsoY3B1X2RhaSwgY2xrX2lkLCBmcmVxLCBTTkRfU09DX0NMT0NLX0lOKTsKK2lmIChy
ZXQgPCAwKSB7CisJcHJpbnRrKCJ3aGF0IHRoZSBoZWxsXG4iKTsKKyAgICAgICAgcmV0dXJuIC1F
SU5WQUw7Cit9CityZXQgPSBzbmRfc29jX2RhaV9zZXRfY2xrZGl2KGNwdV9kYWksIE9NQVBfTUNC
U1BfQ0xLR0RWLCBkaXYpOworaWYgKHJldCA8IDApIHsKKwlwcmludGsoIndoYXQgdGhlIGhlbGwg
Z29pbmcgb25cbiIpOworICAgICAgICByZXR1cm4gLUVJTlZBTDsKK30KKyAgICAgICAgcmV0dXJu
IHJldDsKKyNlbHNlCisJc3dpdGNoIChwYXJhbXNfY2hhbm5lbHMocGFyYW1zKSkgeworCWNhc2Ug
MjogLyogU3RlcmVvIEkyUyBtb2RlICovCisJCWZtdCA9CVNORF9TT0NfREFJRk1UX0kyUyB8CisJ
CQlTTkRfU09DX0RBSUZNVF9OQl9ORiB8CisJCQlTTkRfU09DX0RBSUZNVF9DQk1fQ0ZNOworCQli
cmVhazsKKwljYXNlIDQ6IC8qIEZvdXIgY2hhbm5lbCBURE0gbW9kZSAqLworCQlmbXQgPQlTTkRf
U09DX0RBSUZNVF9EU1BfQSB8CisJCQlTTkRfU09DX0RBSUZNVF9JQl9ORiB8CisJCQlTTkRfU09D
X0RBSUZNVF9DQk1fQ0ZNOworCQlicmVhazsKKwlkZWZhdWx0OgorCQlyZXR1cm4gLUVJTlZBTDsK
Kwl9CisKKwlzbmRfc29jX2RhaV9zZXRfc3lzY2xrKGNvZGVjX2RhaSwgMCwgMTMwMDAwMDAsCisJ
CVNORF9TT0NfQ0xPQ0tfSU4pOwogCXJldHVybiBzbmRfc29jX3J1bnRpbWVfc2V0X2RhaV9mbXQo
cnRkLCBmbXQpOworI2VuZGlmCiB9CiAKIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19vcHMgb21hcF90
d2w0MDMwX29wcyA9IHsKQEAgLTIyOCwxMyArMjg1LDEyIEBAIHN0YXRpYyBpbnQgb21hcF90d2w0
MDMwX2NhcmRfcmVtb3ZlKHN0cnVjdCBzbmRfc29jX2NhcmQgKmNhcmQpCiAvKiBEaWdpdGFsIGF1
ZGlvIGludGVyZmFjZSBnbHVlIC0gY29ubmVjdHMgY29kZWMgPC0tPiBDUFUgKi8KIHN0YXRpYyBz
dHJ1Y3Qgc25kX3NvY19kYWlfbGluayBvbWFwX3R3bDQwMzBfZGFpX2xpbmtzW10gPSB7CiAJewot
CQkubmFtZSA9ICJUV0w0MDMwIEhpRmkiLAotCQkuc3RyZWFtX25hbWUgPSAiVFdMNDAzMCBIaUZp
IiwKLQkJLmNwdV9kYWlfbmFtZSA9ICJvbWFwLW1jYnNwLjIiLAotCQkuY29kZWNfZGFpX25hbWUg
PSAidHdsNDAzMC1oaWZpIiwKLQkJLnBsYXRmb3JtX25hbWUgPSAib21hcC1tY2JzcC4yIiwKLQkJ
LmNvZGVjX25hbWUgPSAidHdsNDAzMC1jb2RlYyIsCi0JCS5pbml0ID0gb21hcF90d2w0MDMwX2lu
aXQsCisJCS5uYW1lID0gIm1heDk4MDkwIEhpRmkiLAorCQkuc3RyZWFtX25hbWUgPSAibWF4OTgw
OTAgSGlGaSIsCisJCS5jcHVfZGFpX25hbWUgPSAib21hcC1tY2JzcC4zIiwKKwkJLmNvZGVjX2Rh
aV9uYW1lID0gIkhpRmkiLAorCQkucGxhdGZvcm1fbmFtZSA9ICJvbWFwLW1jYnNwLjMiLAorCQku
Y29kZWNfbmFtZSA9ICJtYXg5ODA5MC4xLTAwMTAiLAogCQkub3BzID0gJm9tYXBfdHdsNDAzMF9v
cHMsCiAJfSwKIAl7Cg==
--001a1134aaae0556a6051352a5ea
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a1134aaae0556a6051352a5ea--
