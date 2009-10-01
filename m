From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: Patches for alsactl init db
Date: Thu, 1 Oct 2009 00:32:31 -0400
Message-ID: <604760770909302132g40c5deb4qdbf96ec6e6ad40b7@mail.gmail.com>
References: <937485.7802.qm@web31808.mail.mud.yahoo.com>
	<s5heippotjp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd1e174be3fba0474d822bf
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id AE42E24410
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 06:32:32 +0200 (CEST)
Received: by fxm8 with SMTP id 8so5013314fxm.45
	for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2009 21:32:31 -0700 (PDT)
In-Reply-To: <s5heippotjp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Dan Chen <crimsunkg@yahoo.com>
List-Id: alsa-devel@alsa-project.org

--000e0cd1e174be3fba0474d822bf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2009 at 2:06 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Thanks. =C2=A0But, basically it means that a quirk in the driver is
> needed to revert the EAPD switch.
> Could you check whether ac97_quirk=3Dinv_eapd module option for
> snd-intel8x0 works?

I've received confirmation from the bug reporter that using the quirk
makes analog sound audible by default. Attached is a patch against
current sound-2.6 HEAD making this change.

-Dan

--000e0cd1e174be3fba0474d822bf
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Mute-External-Amplifier-by-default-for-Sony-VAIO-VGN.patch"
Content-Disposition: attachment;
	filename="0001-Mute-External-Amplifier-by-default-for-Sony-VAIO-VGN.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g090faqw0

RnJvbSA5YzY0ZDFjMTk5NTRmMWVkOTFjYjE3MDg1NTgyOTkwM2ZjZjNiN2UzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFRodSwgMSBPY3QgMjAwOSAwMDoyODoxNiAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIE11dGUg
RXh0ZXJuYWwgQW1wbGlmaWVyIGJ5IGRlZmF1bHQgZm9yIFNvbnkgVkFJTyBWR04tVDM1MFAKCkJ1
Z0xpbms6IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L2J1Z3MvNDEwOTMzCgpUaGlzIFNvbnkg
VkFJTyBtb2RlbCBuZWVkcyBFeHRlcm5hbCBBbXBsaWZpZXIgdW5tdXRlZCBmb3IgYXVkaWJsZQpw
bGF5YmFjaywgc28gbWFrZSBzdXJlIHdlIHNldCB0aGUgaW52X2VhcGQgcXVpcmsuCgpTaWduZWQt
b2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291bmQvcGNp
L2ludGVsOHgwLmMgfCAgICA2ICsrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2ludGVsOHgwLmMgYi9z
b3VuZC9wY2kvaW50ZWw4eDAuYwppbmRleCAxNzFhZGE1Li44NmU5YTJkIDEwMDY0NAotLS0gYS9z
b3VuZC9wY2kvaW50ZWw4eDAuYworKysgYi9zb3VuZC9wY2kvaW50ZWw4eDAuYwpAQCAtMTk1NCw2
ICsxOTU0LDEyIEBAIHN0YXRpYyBzdHJ1Y3QgYWM5N19xdWlyayBhYzk3X3F1aXJrc1tdIF9fZGV2
aW5pdGRhdGEgPSB7CiAJCS5uYW1lID0gIlNvbnkgUzFYUCIsCiAJCS50eXBlID0gQUM5N19UVU5F
X0lOVl9FQVBECiAJfSwKKwl7CisJCS5zdWJ2ZW5kb3IgPSAweDEwNGQsCisJCS5zdWJkZXZpY2Ug
PSAweDgxYzAsCisJCS5uYW1lID0gIlNvbnkgVkFJTyBWR04tVDM1MFAiLCAvKkFEMTk4MUIqLwor
CQkudHlwZSA9IEFDOTdfVFVORV9JTlZfRUFQRAorCX0sCiAgCXsKIAkJLnN1YnZlbmRvciA9IDB4
MTA0MywKIAkJLnN1YmRldmljZSA9IDB4ODBmMywKLS0gCjEuNi4zLjMKCg==
--000e0cd1e174be3fba0474d822bf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--000e0cd1e174be3fba0474d822bf--
