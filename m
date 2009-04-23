From: Aleh <aleh.fl@gmail.com>
Subject: Benq S32 headphones detection
Date: Thu, 23 Apr 2009 11:58:58 +0300
Message-ID: <op.ust0kjam39g8cz@flip>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=----------Mp0cY7dSqNmNGp6oQ0Q25j
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id A504C103838
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 10:59:01 +0200 (CEST)
Received: by fxm18 with SMTP id 18so453950fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2009 01:59:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------------Mp0cY7dSqNmNGp6oQ0Q25j
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit


Hi,

I had a problem with muting speakers when headphones are plugged-in on my  
Benq S32B. So I added proper board configuration to  
sound/pci/hda/patch_realtek.c and now it works.

I wonder if anyone has similar hardware (S-series Benq laptop) to test the  
patch (attached) if you find it useful.
------------Mp0cY7dSqNmNGp6oQ0Q25j
Content-Disposition: attachment; filename=benq-s32-hda-audio.patch
Content-Type: application/octet-stream; name=benq-s32-hda-audio.patch
Content-Transfer-Encoding: Base64

ZGlmZiAtdU5yIGxpbnV4LTIuNi4yOS4xL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVh
bHRlay5jIGxpbnV4LTIuNi4yOS4xLXdpdGgtYmVucS1zMzIvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMKLS0tIGxpbnV4LTIuNi4yOS4xL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfcmVhbHRlay5jCTIwMDktMDQtMDIgMjM6NTU6MjcuMDAwMDAwMDAw
ICswMzAwCisrKyBsaW51eC0yLjYuMjkuMS13aXRoLWJlbnEtczMyL3NvdW5kL3Bj
aS9oZGEvcGF0Y2hfcmVhbHRlay5jCTIwMDktMDQtMjIgMjA6MTM6MjIuMDAwMDAw
MDAwICswMzAwCkBAIC05OCw2ICs5OCw3IEBACiAJQUxDMjYyX0JFTlFfRUQ4LAog
CUFMQzI2Ml9TT05ZX0FTU0FNRCwKIAlBTEMyNjJfQkVOUV9UMzEsCisJQUxDMjYy
X0JFTlFfUzMyLAogCUFMQzI2Ml9VTFRSQSwKIAlBTEMyNjJfTEVOT1ZPXzMwMDAs
CiAJQUxDMjYyX05FQywKQEAgLTk5ODUsNiArOTk4NiwxNCBAQAogCXt9CiB9Owog
CitzdGF0aWMgc3RydWN0IGhkYV92ZXJiIGFsYzI2Ml9iZW5xX3MzMl91bnNvbF92
ZXJic1tdID0geworCXsweDE4LCBBQ19WRVJCX1NFVF9QSU5fV0lER0VUX0NPTlRS
T0wsIDB4MjR9LAorCXsweDE5LCBBQ19WRVJCX1NFVF9QSU5fV0lER0VUX0NPTlRS
T0wsIDB4MjR9LAorCXsweDE1LCBBQ19WRVJCX1NFVF9VTlNPTElDSVRFRF9FTkFC
TEUsIEFDX1VTUlNQX0VOIHwgQUxDODgwX0hQX0VWRU5UfSwKKwl7MHgxNSwgQUNf
VkVSQl9TRVRfUElOX1dJREdFVF9DT05UUk9MLCBQSU5fSFB9LAorCXt9Cit9Owor
CiAvKiBTYW1zdW5nIFExIFVsdHJhIFZpc3RhIG1vZGVsIHNldHVwICovCiBzdGF0
aWMgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgYWxjMjYyX3VsdHJhX21peGVyW10g
PSB7CiAJSERBX0NPREVDX1ZPTFVNRSgiTWFzdGVyIFBsYXliYWNrIFZvbHVtZSIs
IDB4MGMsIDB4MCwgSERBX09VVFBVVCksCkBAIC0xMDUzNyw2ICsxMDU0Niw3IEBA
CiAJW0FMQzI2Ml9IUF9SUDU3MDBdCT0gImhwLXJwNTcwMCIsCiAJW0FMQzI2Ml9C
RU5RX0VEOF0JPSAiYmVucSIsCiAJW0FMQzI2Ml9CRU5RX1QzMV0JPSAiYmVucS10
MzEiLAorCVtBTEMyNjJfQkVOUV9TMzJdCT0gImJlbnEtczMyIiwKIAlbQUxDMjYy
X1NPTllfQVNTQU1EXQk9ICJzb255LWFzc2FtZCIsCiAJW0FMQzI2Ml9UT1NISUJB
X1MwNl0JPSAidG9zaGliYS1zMDYiLAogCVtBTEMyNjJfVE9TSElCQV9SWDFdCT0g
InRvc2hpYmEtcngxIiwKQEAgLTEwNTkxLDYgKzEwNjAxLDcgQEAKIAlTTkRfUENJ
X1FVSVJLKDB4MTdmZiwgMHgwNTYwLCAiQmVucSBFRDgiLCBBTEMyNjJfQkVOUV9F
RDgpLAogCVNORF9QQ0lfUVVJUksoMHgxN2ZmLCAweDA1OGQsICJCZW5xIFQzMS0x
NiIsIEFMQzI2Ml9CRU5RX1QzMSksCiAJU05EX1BDSV9RVUlSSygweDE3ZmYsIDB4
MDU4ZiwgIkJlbnEgSGlwcG8iLCBBTEMyNjJfSElQUE9fMSksCisJU05EX1BDSV9R
VUlSSygweDE3ZmYsIDB4MDU5MiwgIkJlbnEgUzMyIiwgQUxDMjYyX0JFTlFfUzMy
KSwKIAl7fQogfTsKIApAQCAtMTA3MzcsNiArMTA3NDgsMTkgQEAKIAkJLnVuc29s
X2V2ZW50ID0gYWxjMjYyX2hpcHBvX3Vuc29sX2V2ZW50LAogCQkuaW5pdF9ob29r
ID0gYWxjMjYyX2hpcHBvX2F1dG9tdXRlLAogCX0sCisJW0FMQzI2Ml9CRU5RX1Mz
Ml0gPSB7CisJCS5taXhlcnMgPSB7IGFsYzI2Ml9iYXNlX21peGVyIH0sCisJCS5p
bml0X3ZlcmJzID0geyBhbGMyNjJfaW5pdF92ZXJicywgYWxjMjYyX2JlbnFfczMy
X3Vuc29sX3ZlcmJzfSwKKwkJLm51bV9kYWNzID0gQVJSQVlfU0laRShhbGMyNjJf
ZGFjX25pZHMpLAorCQkuZGFjX25pZHMgPSBhbGMyNjJfZGFjX25pZHMsCisJCS5o
cF9uaWQgPSAweDAzLAorCQkuZGlnX291dF9uaWQgPSBBTEMyNjJfRElHT1VUX05J
RCwKKwkJLm51bV9jaGFubmVsX21vZGUgPSBBUlJBWV9TSVpFKGFsYzI2Ml9tb2Rl
cyksCisJCS5jaGFubmVsX21vZGUgPSBhbGMyNjJfbW9kZXMsCisJCS5pbnB1dF9t
dXggPSAmYWxjMjYyX2NhcHR1cmVfc291cmNlLAorCQkudW5zb2xfZXZlbnQgPSBh
bGMyNjJfaGlwcG9fdW5zb2xfZXZlbnQsCisJCS5pbml0X2hvb2sgPSBhbGMyNjJf
aGlwcG9fYXV0b211dGUsCisJfSwKIAlbQUxDMjYyX1VMVFJBXSA9IHsKIAkJLm1p
eGVycyA9IHsgYWxjMjYyX3VsdHJhX21peGVyIH0sCiAJCS5jYXBfbWl4ZXIgPSBh
bGMyNjJfdWx0cmFfY2FwdHVyZV9taXhlciwK

------------Mp0cY7dSqNmNGp6oQ0Q25j
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------------Mp0cY7dSqNmNGp6oQ0Q25j--
