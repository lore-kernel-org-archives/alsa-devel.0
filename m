From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use vostro model quirk for Dell
 Vostro 1014 [Was: Re: Please add PCI quirk for Vostro 1014 (1028:0401)]
Date: Sat, 8 Jan 2011 18:31:30 -0500
Message-ID: <AANLkTin+3OAqFhveJ8tkhghWzS2m0DEAWcB1MsVqQE76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30025aa470304904995e22d5
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id DA2472414F
	for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2011 00:31:33 +0100 (CET)
Received: by wyi11 with SMTP id 11so18535781wyi.38
	for <alsa-devel@alsa-project.org>; Sat, 08 Jan 2011 15:31:33 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Fernando Lemos <fernandotcl@gmail.com>
List-Id: alsa-devel@alsa-project.org

--20cf30025aa470304904995e22d5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fernando, Takashi,

Attached is a patch against current master HEAD resolving Fernando's sympto=
m.

Thanks,
-Dan

On Sat, Jan 8, 2011 at 11:37 AM, Fernando Lemos <fernandotcl@gmail.com> wro=
te:
> Hi,
>
> Following the advice received here[1] (thanks, Raymond), I'm asking
> for someone to add the following entry to the list of PCI quirks
> cxt5066_cfg_tbl if possible:
>
> =C2=A0SND_PCI_QUIRK(0x1028, 0x02f5, "Dell", CXT5066_DELL_LAPTOP),
> +SND_PCI_QUIRK(0x1028, 0x0401, "Dell Vostro 1014", CXT5066_DELL_VOSTRO),
> =C2=A0SND_PCI_QUIRK(0x1028, 0x0402, "Dell Vostro", CXT5066_DELL_VOSTRO),
> =C2=A0SND_PCI_QUIRK(0x1028, 0x0408, "Dell Inspiron One 19T", CXT5066_IDEA=
PAD),
>
> Codec: Conexant CX20583 (Pebble HSF)
> Address: 0
> Function Id: 0x2
> Vendor Id: 0x14f15067
> Subsystem Id: 0x10280401
> Revision Id: 0x100300
>
> I can confirm that forcing model=3Dvostro works perfectly for this
> specific laptop model (tested speakers and headphones). If there's any
> test you want me to do, please let me know. There are more details
> about the issue in the aforementioned bug report[1].
>
> By the way, I also got a chance to test on 2.6.37 recently and the
> problem persists. In fact, in 2.6.37 I don't even get any sound in my
> headphones. But it all works flawlessly with model=3Dvostro.
>
> I apologize if you receive another e-mail from me with similar
> contents in the future. I've sent this e-mail to the list last year,
> but I wasn't subscribed so I'd been waiting for moderator approval
> since then. Now I'm subscribed to the list, let's see if this e-mail
> gets through.
>
> [1] https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D5184
>
> Thanks in advance,
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

--20cf30025aa470304904995e22d5
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Use-vostro-model-quirk-for-Dell-Vostro-1014.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-vostro-model-quirk-for-Dell-Vostro-1014.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gip5e5i00

RnJvbSBiZjFhZWYyOWM3NDU2MmYwMTJkMzYyOGYyOGZhYWVlYzJiZDk2Yjc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFNhdCwgOCBKYW4gMjAxMSAxODoyNToyNyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYTogVXNlIHZvc3RybyBtb2RlbCBxdWlyayBmb3IgRGVsbCBWb3N0cm8gMTAxNAoKQnVnTGlu
azogaHR0cHM6Ly9idWd0cmFjay5hbHNhLXByb2plY3Qub3JnL2Fsc2EtYnVnL3ZpZXcucGhwP2lk
PTUxODQKCkEgdXNlciByZXBvcnRlZCBvbiB0aGUgYWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QgdGhh
dCBoZSBuZWVkcyB0byB1c2UKdGhlIHZvc3RybyBtb2RlbCBxdWlyayB0byBoYXZlIGF1ZGlibGUg
cGxheWJhY2ssIHNvIGFwcGx5IGl0IGZvciBoaXMKUENJIFNTSUQuCgpSZXBvcnRlZC1hbmQtdGVz
dGVkLWJ5OiBGZXJuYW5kbyBMZW1vcyA8ZmVybmFuZG90Y2xAZ21haWwuY29tPgpDYzogPHN0YWJs
ZUBrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50
dS5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jIHwgICAgMSArCiAxIGZp
bGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9zb3VuZC9wY2kvaGRhL3BhdGNoX2NvbmV4YW50LmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2Nv
bmV4YW50LmMKaW5kZXggNzQyOTFmNy4uYzViMjdiYSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hk
YS9wYXRjaF9jb25leGFudC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYwpA
QCAtMzA5OCw2ICszMDk4LDcgQEAgc3RhdGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIGN4dDUwNjZf
Y2ZnX3RibFtdID0gewogCVNORF9QQ0lfUVVJUktfTUFTSygweDEwMjUsIDB4ZmYwMCwgMHgwNDAw
LCAiQWNlciIsIENYVDUwNjZfSURFQVBBRCksCiAJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDJk
OCwgIkRlbGwgVm9zdHJvIiwgQ1hUNTA2Nl9ERUxMX1ZPU1RSTyksCiAJU05EX1BDSV9RVUlSSygw
eDEwMjgsIDB4MDJmNSwgIkRlbGwgVm9zdHJvIDMyMCIsIENYVDUwNjZfSURFQVBBRCksCisJU05E
X1BDSV9RVUlSSygweDEwMjgsIDB4MDQwMSwgIkRlbGwgVm9zdHJvIDEwMTQiLCBDWFQ1MDY2X0RF
TExfVk9TVFJPKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwNDAyLCAiRGVsbCBWb3N0cm8i
LCBDWFQ1MDY2X0RFTExfVk9TVFJPKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwNDA4LCAi
RGVsbCBJbnNwaXJvbiBPbmUgMTlUIiwgQ1hUNTA2Nl9JREVBUEFEKSwKIAlTTkRfUENJX1FVSVJL
KDB4MTAzYywgMHgzNjBiLCAiSFAgRzYwIiwgQ1hUNTA2Nl9IUF9MQVBUT1ApLAotLSAKMS43LjEK
Cg==
--20cf30025aa470304904995e22d5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--20cf30025aa470304904995e22d5--
