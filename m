From: "Likely, Grant" <Grant.Likely@gdcanada.com>
Subject: High latency using OSS emulation layer
Date: Sun, 12 Sep 2004 22:46:37 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1125D9E6416F00489EA977418E764B4F0C346E@CGYSVW100.gdcan.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4994C.A6F28E16"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4994C.A6F28E16
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm working on a real-time audio processing application that must use =
the OSS interface for capture and playback of 8Khz samples.  My =
development platform has the 2.6 kernel and the ALSA drivers installed, =
so I'm using the OSS emulation layer.

The problem that I'm having is that I cannot get less than about 1/2 =
second of latency between input and output.  I need to get latencies in =
the order of 1-10ms.  Using a test program, I've narrowed it down my OSS =
calls.  I've attached the test program to the bottom of this email.  Can =
anybody see what I am doing wrong?

I can reproduce this problem both with the my intel i8x0 (snd-intel8x0) =
and with a usb headset (snd-usb-audio).  I've also duplicated it on both =
a recent 2.6.8 kernel on my laptop, and on a 2.4.19 kernel on an =
embedded Intel Xscale (arm) platform using alsa-drivers-1.0.5.  Latency =
is consistently 1/2 second regardless of buffer size, sample width, or =
if the device is opened with O_NDELAY.

However, if I set the sampling rate to 44100, the latency disappears.  =
It is unaffected for sampling rates of 8kHz and 16kHz (The latency isn't =
even halved between 8 and 16, it is exactly the same)

Thanks,
grant.

------_=_NextPart_001_01C4994C.A6F28E16
Content-Type: text/x-csrc;
	name="sndtest.c"
Content-Transfer-Encoding: base64
Content-Description: sndtest.c
Content-Disposition: attachment;
	filename="sndtest.c"

CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPHN5cy9zb3VuZGNhcmQuaD4KI2luY2x1
ZGUgPGZjbnRsLmg+CgojZGVmaW5lIFNBTVBMRV9SQVRFXzhLSFogICAoODAwMCkKI2RlZmluZSBT
QU1QTEVfUkFURV8xNktIWiAgKDE2MDAwKQojZGVmaW5lIFNBTVBMRV9SQVRFICAgICAgICBTQU1Q
TEVfUkFURV84S0haCiNkZWZpbmUgU0FNUExFX1dJRFRIICAgICAgICgxKQojZGVmaW5lIFNBTVBM
RV9DT1VOVCAgICAgICAoMzIpCgojZGVmaW5lIFBBQ0tFVF9TSVpFICAgICAgICAoU0FNUExFX0NP
VU5UICogU0FNUExFX1dJRFRIKQojZGVmaW5lIFBBQ0tFVF9SQVRFICAgICAgICAoU0FNUExFX1JB
VEUvUEFDS0VUX1NJWkUpCiNkZWZpbmUgUEFDS0VUX1BFUklPRF9VUyAgICgxMDAwMDAwKlNBTVBM
RV9DT1VOVC9TQU1QTEVfUkFURSkKCiNkZWZpbmUgTUFYX1NPVVJDRVMgICAgICgxNikKI2RlZmlu
ZSBSWF9CVUZGRVJfU0laRSAgKFBBQ0tFVF9TSVpFICogMikKCnN0YXRpYyBpbnQgICAgICAgICAg
ICAgICAgYXVkaW9fZmQgPSAtMTsKCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsK
CiAgICBpbnQgbXludW1mcmFnbWVudHMgPSAzOwogICAgaW50IG15ZnJhZ21lbnRzaXplID0gMTI7
CiAgICBpbnQgZnJhZ3NpemU7CiAgICBpbnQgYXBhcjsKICAgIGludCBhdWJ1Zl9zaXplOwogICAg
aW50IHJlczsKICAgIGludCBsZW47CiAgICBzdHJ1Y3QgYXVkaW9fYnVmX2luZm8gYWJpbmZvOyAK
CiAgICB1bnNpZ25lZCBjaGFyIHR4X2J1ZmZlcltQQUNLRVRfU0laRV07CgogICAgaWYgKGFyZ2Mg
PiAxKQogICAgICAgIC8vYXVkaW9fZmQgPSBvcGVuKGFyZ3ZbMV0sIE9fUkRXUiB8IE9fTkRFTEFZ
LCAwKTsKICAgICAgICBhdWRpb19mZCA9IG9wZW4oYXJndlsxXSwgT19SRFdSLCAwKTsKICAgIGVs
c2UKICAgICAgICBhdWRpb19mZCA9IG9wZW4oIi9kZXYvZHNwIiwgT19SRFdSLCAwKTsKICAgIGlm
IChhdWRpb19mZCA9PSAtMSkKICAgIHsKICAgICAgICBwcmludGYoIkNvdWxkIG5vdCBvcGVuICVz
XG4iLCBhcmd2WzFdKTsKICAgICAgICBleGl0KC0xKTsKICAgIH0KCiNpZiAwCiAgICAvLwogICAg
Ly8gU2V0IHRoZSBzYW1wbGluZyBGT1JNQVQKICAgIC8vCiAgICBhcGFyPUFGTVRfUzE2X0xFOwog
ICAgcmVzPWlvY3RsKGF1ZGlvX2ZkLFNORENUTF9EU1BfU0VURk1ULCZhcGFyKTsKICAgIGlmKHJl
cyA9PSAtMSkKICAgIHsKICAgICAgICBwZXJyb3IoIkVSUk9SOiBpb2N0bDogU05EQ1RMX0RTUF9T
RVRGTVQiKTsKICAgICAgICByZXR1cm4oLTEpOwogICAgfQogICAgaWYoIGFwYXIgIT0gQUZNVF9T
MTZfTEUpCiAgICB7CiAgICAgICAgcGVycm9yKCJFUlJPUjogMTYgYml0IGZvcm1hdCBub3Qgc3Vw
cG9ydGVkIik7CiAgICAgICAgcmV0dXJuKC0xKTsKICAgIH0KI2VuZGlmCgojaWYgMAogICAgLy8K
ICAgIC8vIFNldCB0aGUgc2FtcGxpbmcgUkFURQogICAgLy8KICAgIC8vYXBhcj04MDAwOwogICAg
Ly9hcGFyPTE2MDAwOwogICAgYXBhcj00NDEwMDsKICAgIHJlcz1pb2N0bChhdWRpb19mZCxTTkRD
VExfRFNQX1NQRUVELCZhcGFyKTsKICAgIGlmKHJlcyA9PSAtMSkKICAgIHsKICAgICAgICBwZXJy
b3IoIkVSUk9SOiBpb2N0bDogU05EQ1RMX0RTUF9TUEVFRCIpOwogICAgICAgIHJldHVybigtMSk7
CiAgICB9CiAgICBwcmludGYoInNhbXBsaW5ncmF0ZT0lZFxuIixhcGFyKTsKI2VuZGlmCgojaWYg
MAogICAgLy8KICAgIC8vIFNldCB0aGUgc2FtcGxlIEZSQUdNRU5UIFNJWkUKICAgIC8vCiAgICBh
cGFyPSgobXludW1mcmFnbWVudHMtMSkgPDwgMTYpIHwgbXlmcmFnbWVudHNpemU7CiAgICBwcmlu
dGYoImZyYWdtZW50IHBhcmFtZXRlciA9ICV4XG4iLGFwYXIpOwogICAgcmVzPWlvY3RsKGF1ZGlv
X2ZkLFNORENUTF9EU1BfU0VURlJBR01FTlQsJmFwYXIpOwogICAgaWYocmVzID09IC0xKQogICAg
ewogICAgICAgIHBlcnJvcigiRVJST1I6IGlvY3RsOiBTTkRDVExfRFNQX1NFVEZSQUdNRU5UIik7
CiAgICAgICAgZXhpdCgtMSk7CiAgICB9CiNlbmRpZgoKCiNpZiAxCiAgICAvLwogICAgLy8gRGlz
cGxheSB0aGUgc2FtcGxpbmcgbGF0ZW5jeQogICAgLy8KICAgIHJlcz1pb2N0bChhdWRpb19mZCxT
TkRDVExfRFNQX0dFVE9TUEFDRSwmYWJpbmZvKTsKICAgIGlmKHJlcyA9PSAtMSkKICAgIHsKICAg
ICAgICBwZXJyb3IoIkVSUk9SOiBpb2N0bDogU05EQ1RMX0RTUF9HRVRPU1BBQ0UiKTsKICAgICAg
ICBleGl0KC0xKTsKICAgIH0KICAgIGF1YnVmX3NpemU9YWJpbmZvLmZyYWdzdG90YWwgKiBhYmlu
Zm8uZnJhZ3NpemU7CgogICAgcHJpbnRmKCJmcmFncz0lZCBmcmFnX3NpemU9JWQgdG90YWxfYnVm
X3NpemU9JWQgIGJ1Zl9sYXRlbmN5PSVmIG1zXG4iLAogICAgICAgICAgIGFiaW5mby5mcmFnc3Rv
dGFsLCBhYmluZm8uZnJhZ3NpemUsIGF1YnVmX3NpemUsIGF1YnVmX3NpemUvMTc2LjQpOwojZW5k
aWYKCgogICAgd2hpbGUoMSkKICAgIHsKICAgICAgICBpZiAoYXVkaW9fZmQgIT0gLTEpCiAgICAg
ICAgewogICAgICAgICAgICBsZW4gPSByZWFkKGF1ZGlvX2ZkLCB0eF9idWZmZXIsIFBBQ0tFVF9T
SVpFKTsgCiAgICAgICAgICAgIGlmIChsZW4gPiAwKQogICAgICAgICAgICB7CiAgICAgICAgICAg
ICAgICB3cml0ZShhdWRpb19mZCwgdHhfYnVmZmVyLCBsZW4pOyAKICAgICAgICAgICAgfQoKICAg
ICAgICB9CiAgICB9CgogICAgaWYgKGF1ZGlvX2ZkICE9IC0xKQogICAgICAgIGNsb3NlKGF1ZGlv
X2ZkKTsKfQo=

------_=_NextPart_001_01C4994C.A6F28E16--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
