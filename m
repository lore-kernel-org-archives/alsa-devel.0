From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: OSS layer still doesn't ignore xruns.
Date: Thu, 17 Jul 2003 12:14:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307171209540.2108-200000@pnote.perex-int.cz>
References: <20030716224431.GA24371@alinoe.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811384-1191070445-1058436854=:2108"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030716224431.GA24371@alinoe.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlo Wood <carlo@alinoe.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811384-1191070445-1058436854=:2108
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 17 Jul 2003, Carlo Wood wrote:

> On Tue, Jul 15, 2003 at 08:31:50PM +0200, Jaroslav Kysela wrote:
> > I looked to the problem and it seems that the overrun state is handled 
> > differently in the OSS API than ALSA implemented. It seems that the stream 
> > is not stopped but rather the oldest period (fragment) is discarded.
> > 
> > The new code (plus some optimization) is in the ALSA CVS tree. The patch 
> > is attached to this e-mail.
> 
> This patch does not solve the problem.
> As soon as the buffers runs exactly full - which is now a coincidence,
> but happens reasonable quickly, the alsa layer detects an "overrun"
> and stops the stream.

Nope. Your test code is buggy. If you have 2 fragments per 4096 bytes and
you will read samples then the ring buffer goes filled bellow 4096 bytes,
then info.frags is zero, thus your loop goes very quickly to 10
iterations. I attached fixed code which adds additional wait - not 
very clean solution - poll() is prefered (plus commented code which 
sleeps 4 seconds to generate an overrun at the start).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

---1463811384-1191070445-1058436854=:2108
Content-Type: TEXT/plain; name="a.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0307171214140.2108@pnote.perex-int.cz>
Content-Description: 
Content-Disposition: attachment; filename="a.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQoj
aW5jbHVkZSA8c3lzL3N0YXQuaD4NCiNpbmNsdWRlIDxmY250bC5oPg0KI2lu
Y2x1ZGUgPHN5cy9pb2N0bC5oPg0KI2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2lu
Y2x1ZGUgPHN5cy9zb3VuZGNhcmQuaD4NCiNpbmNsdWRlIDx0aW1lLmg+DQoN
CmludCBtYWluKHZvaWQpDQp7DQogIGludCBmZDsNCiAgaW50IHJlcyA9IDB4
MjAwMDk7DQogIGF1ZGlvX2J1Zl9pbmZvIGluZm87DQogIGludCBwcmV2X3Np
emUgPSAwOw0KICBkbw0KICB7DQogICAgKytyZXM7DQogICAgY2xvc2UoZmQp
Ow0KICAgIGZkID0gb3BlbigiL2Rldi9kc3AiLCBPX1JET05MWSk7DQogICAg
aWYgKGZkID09IC0xKSB7IHBlcnJvcigib3BlbiIpOyBleGl0KDEyNyk7IH0N
CiAgICBpZiAoaW9jdGwoZmQsIFNORENUTF9EU1BfU0VURlJBR01FTlQsICZy
ZXMpID09IC0xKSB7DQogICAgICBwZXJyb3IoImlvY3RsIik7IGV4aXQoMTI3
KTsgfQ0KICAgIGlmIChpb2N0bChmZCwgU05EQ1RMX0RTUF9HRVRJU1BBQ0Us
ICZpbmZvKSA9PSAtMSkgew0KICAgICAgcGVycm9yKCJyZWFkIik7IGV4aXQo
MTI3KTsgfQ0KICAgIHByaW50ZigiICAgIEFsbG9jYXRlZCAlZCBidWZmZXJz
IG9mICVkIGJ5dGVzLlxuIiwgaW5mby5mcmFnc3RvdGFsLCBpbmZvLmZyYWdz
aXplKTsNCiAgICBpZiAocHJldl9zaXplID09IGluZm8uZnJhZ3NpemUgKiBp
bmZvLmZyYWdzdG90YWwpDQogICAgew0KICAgICAgcHJpbnRmKCIgICAgSXQg
c2VlbXMgaW1wb3NzaWJsZSB0byBzZXQgYSByZWNvcmRpbmcgYnVmZmVyIHdp
dGggYVxuIg0KICAgICAgICAgICAgICIgICAgdG90YWwgc2l6ZSBvZiBhdCBs
ZWFzdCA4MTkyIGJ5dGVzLiAgVGhpcyBpcyBub3QgZ29pbmdcbiINCiAgICAg
ICAgICAgICAiICAgIHRvIHdvcmsgd2l0aCBWaWFWb2ljZS4gIFNvcnJ5Llxu
Iik7DQogICAgICBleGl0KDEyNik7DQogICAgfQ0KICAgIHByZXZfc2l6ZSA9
IGluZm8uZnJhZ3NpemUgKiBpbmZvLmZyYWdzdG90YWw7DQogIH0NCiAgd2hp
bGUgKHByZXZfc2l6ZSA8IDgxOTIpOw0KICBwcmludGYoIiAgICBTdWNjZXNz
ZnVsbHkgYWxsb2NhdGVkIGEgYnVmZmVyIHRoYXQgaXMgbGFyZ2UgZW5vdWdo
LlxuIik7DQogIHJlcyA9IEFGTVRfUzE2X0xFOw0KICBpZiAoaW9jdGwoZmQs
IFNORENUTF9EU1BfU0VURk1ULCAmcmVzKSA9PSAtMSkgew0KICAgIHBlcnJv
cigiaW9jdGwiKTsgZXhpdCgxMjcpOyB9DQogIHJlcyA9IDA7DQogIGlmIChp
b2N0bChmZCwgU05EQ1RMX0RTUF9TVEVSRU8sICZyZXMpID09IC0xKSB7DQog
ICAgcGVycm9yKCJpb2N0bCIpOyBleGl0KDEyNyk7IH0NCiAgcmVzID0gMjIw
NTA7DQogIGlmIChpb2N0bChmZCwgU09VTkRfUENNX1JFQURfUkFURSwgMHhi
ZmZmZGNmYykgPT0gLTEpIHsNCiAgICBwZXJyb3IoImlvY3RsIik7IGV4aXQo
MTI3KTsgfQ0KICBjaGFyIGJ1ZlsxMDI0XTsNCiAgaWYgKHJlYWQoZmQsIGJ1
Ziwgc2l6ZW9mKGJ1ZikpIDwgMCkgeyBwZXJyb3IoInJlYWQiKTsgZXhpdCgx
MjcpOyB9DQogIHN0YXRpYyBzdHJ1Y3QgdGltZXNwZWMgbmFwdGltZSA9IHsg
MCwgMTAwMDAwMDAwIH07DQojaWYgMQ0KICBkbyB7DQogICAgaWYgKGlvY3Rs
KGZkLCBTTkRDVExfRFNQX0dFVElTUEFDRSwgJmluZm8pID09IC0xKSB7DQog
ICAgICBwZXJyb3IoInJlYWQiKTsgZXhpdCgxMjcpOyB9DQogICAgcHJpbnRm
KCIgICAgQXZhaWxhYmxlIGJ5dGVzOiAlZFxuIiwgaW5mby5ieXRlcyk7DQog
ICAgbmFub3NsZWVwKCZuYXB0aW1lLCAwKTsNCiAgfSB3aGlsZShpbmZvLmJ5
dGVzIDwgaW5mby5mcmFnc2l6ZSAqIGluZm8uZnJhZ3N0b3RhbCk7DQojZWxz
ZQ0KICBzbGVlcCg0KTsNCiAgaWYgKGlvY3RsKGZkLCBTTkRDVExfRFNQX0dF
VElTUEFDRSwgJmluZm8pID09IC0xKSB7DQogICBwZXJyb3IoInJlYWQiKTsg
ZXhpdCgxMjcpOyB9DQojZW5kaWYNCiAgcHJpbnRmKCIgICAgU3VjY2Vzc2Z1
bGx5IGNhdXNlZCBhbiB4cnVuLlxuIik7DQogIHByaW50ZigiICAgIG5vbi1i
bG9ja2luZyBmcmFnbWVudHM6ICVkXG4iLCBpbmZvLmZyYWdtZW50cyk7DQog
IHByaW50ZigiICAgIG5vbi1ibG9ja2luZyBieXRlczogJWRcbiIsIGluZm8u
Ynl0ZXMpOw0KICBzc2l6ZV90IGJ1ZnNpemUgPSBpbmZvLmJ5dGVzOw0KICBp
ZiAoaW9jdGwoZmQsIFNORENUTF9EU1BfR0VUSVNQQUNFLCAmaW5mbykgPT0g
LTEpIHsNCiAgICBwZXJyb3IoInJlYWQiKTsgZXhpdCgxMjcpOyB9DQogIHNz
aXplX3QgdHJsZW4gPSAwOw0KICBpbnQgbmYgPSAwOw0KICBmb3IgKDs7KQ0K
ICB7DQogICAgcHJpbnRmKCIgICAgQXZhaWxhYmxlIGJ5dGVzIGluIGJ1ZmZl
cjogJWQgKGZyYWdzICVkKVxuIiwgaW5mby5ieXRlcywgaW5mby5mcmFnbWVu
dHMpOw0KICAgIGlmIChpbmZvLmZyYWdtZW50cyA+IDApIHsNCiAgICAgIHNz
aXplX3QgcmxlbjsNCiAgICAgIGlmICgocmxlbiA9IHJlYWQoZmQsIGJ1Ziwg
c2l6ZW9mKGJ1ZikpKSA8IDApDQogICAgICAgIHsgcGVycm9yKCJyZWFkIik7
IGV4aXQoMTI3KTsgfQ0KICAgICAgcHJpbnRmKCIgICAgQWRkaXRpb25hbGx5
IHJlYWQgJWQgYnl0ZXMuXG4iLCBybGVuKTsNCiAgICAgIHRybGVuICs9IHJs
ZW47DQogICAgICBpZiAodHJsZW4gPiBidWZzaXplKSB7DQogICAgICAgIHBy
aW50ZigiICAgIFJlYWQgJWQgYnl0ZXM6IHN0cmVhbSBzdWNjZXNzZnVsbHkg
cmVzdGFydGVkLlxuIiwgdHJsZW4pOw0KICAgICAgICBicmVhazsNCiAgICAg
IH0NCiAgICAgIG5mID0gMDsNCiAgICB9DQogICAgZWxzZSBpZiAoKytuZiA+
IDEwKSB7DQogICAgICBwcmludGYoIiAgICBTdHJlYW0gaXMgbm90IHJlc3Rh
cnRlZCBhZnRlciB4cnVuLlxuIik7DQogICAgICBleGl0KDEpOw0KICAgIH0g
ZWxzZSB7DQogICAgICB1c2xlZXAoMTAwMDAwKTsNCiAgICB9DQogICAgaWYg
KGlvY3RsKGZkLCBTTkRDVExfRFNQX0dFVElTUEFDRSwgJmluZm8pID09IC0x
KSB7DQogICAgICBwZXJyb3IoInJlYWQiKTsgZXhpdCgxMjcpOyB9DQogIH0N
CiAgY2xvc2UoZmQpOw0KICByZXR1cm4gMDsNCn0NCg0K
---1463811384-1191070445-1058436854=:2108--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
