From: "Gilliland, Scott M" <scott.gilliland@gatech.edu>
Subject: Bug in ALSA-utils/arecord with --max-file-time
Date: Thu, 22 Jun 2017 22:08:58 +0000
Message-ID: <CY4PR07MB354415A92C4678709F99FD948DDB0@CY4PR07MB3544.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_CY4PR07MB354415A92C4678709F99FD948DDB0CY4PR07MB3544namp_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0120.outbound.protection.outlook.com [104.47.41.120])
 by alsa0.perex.cz (Postfix) with ESMTP id CE10B266D83
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 00:09:00 +0200 (CEST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_CY4PR07MB354415A92C4678709F99FD948DDB0CY4PR07MB3544namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All,

I seem to have found a minor bug in aplay, within alsa-utils 1.1.4. It's po=
ssible that I'm the first person who's ever hit it. This appears to be the =
correct place to report it; if not, I humbly apologize, and ask for directi=
on on where to submit this.

In aplay.c, around line 3030, we do this calculation:

        max_file_size =3D max_file_time *
                snd_pcm_format_size(hwparams.format,
                                    hwparams.rate * hwparams.channels);

We do this to convert max_file_time from the '--max-file-time' parameter (a=
n int) into max_file_size, a file length in bytes (a long long). Since snd_=
pcm_format_size() may return something 32-bit, this might overflow 32-bits =
when we do the multiplication, wasting the extra bytes of max_file_size.=20

On my test case on an armv7l system, a 1800-second file at 192 KHz recorded=
 in S24_3LE doesn't overflow, but recording in S32_LE does. I accidentally =
found an edge case.  In case anyone wants to know, the failure mode is that=
 arecord will repeatedly create 44 byte .wav files very quickly, since thes=
e are larger than the negative max file size. This continues until you have=
 a directory full of thousands of 44-byte files. Hilarious.

A simple change to cast max_file_time to a long long fixes this in my test =
case. There might be some cleaner solution, but this at least worked for me=
.

        max_file_size =3D (long long) max_file_time *
                snd_pcm_format_size(hwparams.format,
                                    hwparams.rate * hwparams.channels);

Hopefully someone can vet this and carry it over to git. I've attached a pa=
tch file as well.

--

Additionally, while working to report this, I noticed that the bug tracker =
link on the sidebar of https://www.alsa-project.org/main/index.php/Main_Pag=
e is a dead link.

-Scott

--=20
Scott Gilliland
imtc.gatech.edu/people/scott-gilliland

--_002_CY4PR07MB354415A92C4678709F99FD948DDB0CY4PR07MB3544namp_
Content-Type: text/plain; name="max-size-cast.txt"
Content-Description: max-size-cast.txt
Content-Disposition: attachment; filename="max-size-cast.txt"; size=571;
	creation-date="Thu, 22 Jun 2017 22:02:12 GMT";
	modification-date="Thu, 22 Jun 2017 22:02:12 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2Fsc2EtdXRpbHMtMS4xLjQvYXBsYXkvYXBsYXkuYyBiL2Fsc2EtdXRpbHMt
MS4xLjQtbWF4Zml4L2FwbGF5L2FwbGF5LmMKaW5kZXggZjc5M2M4Mi4uMDBhZjY2MiAxMDA2NDQK
LS0tIGEvYWxzYS11dGlscy0xLjEuNC9hcGxheS9hcGxheS5jCisrKyBiL2Fsc2EtdXRpbHMtMS4x
LjQtbWF4Zml4L2FwbGF5L2FwbGF5LmMKQEAgLTMwMjcsNyArMzAyNyw3IEBAIHN0YXRpYyB2b2lk
IGNhcHR1cmUoY2hhciAqb3JpZ19uYW1lKQogCWlmIChjb3VudCA9PSAwKQogCQljb3VudCA9IExM
T05HX01BWDsKIAkvKiBjb21wdXRlIHRoZSBudW1iZXIgb2YgYnl0ZXMgcGVyIGZpbGUgKi8KLQlt
YXhfZmlsZV9zaXplID0gbWF4X2ZpbGVfdGltZSAqCisJbWF4X2ZpbGVfc2l6ZSA9IChsb25nIGxv
bmcpIG1heF9maWxlX3RpbWUgKgogCQlzbmRfcGNtX2Zvcm1hdF9zaXplKGh3cGFyYW1zLmZvcm1h
dCwKIAkJCQkgICAgaHdwYXJhbXMucmF0ZSAqIGh3cGFyYW1zLmNoYW5uZWxzKTsKIAkvKiBXQVZF
LWZpbGUgc2hvdWxkIGJlIGV2ZW4gKEknbSBub3Qgc3VyZSksIGJ1dCB3YXN0aW5nIG9uZSBieXRl
Cg==

--_002_CY4PR07MB354415A92C4678709F99FD948DDB0CY4PR07MB3544namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_CY4PR07MB354415A92C4678709F99FD948DDB0CY4PR07MB3544namp_--
