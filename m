From: Ryan Pavlik <rpav@nwlink.com>
Subject: [PATCH]: Bug: ALSA Sequencer or MTPAV - easy to
 reproduce
Date: Wed, 12 Feb 2003 14:35:29 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030212143529.6ab5ca42.rpav@nwlink.com>
References: <20030212123025.12b1c582.rpav@nwlink.com>
	<Pine.LNX.4.44.0302122136400.30420-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__12_Feb_2003_14:35:29_-0800_0832bb00"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302122136400.30420-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart_Wed__12_Feb_2003_14:35:29_-0800_0832bb00
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2003 21:41:50 +0100 (CET)
Jaroslav Kysela <perex@suse.cz> wrote:

<snip> 
> It seems that mtpav don't remeber the old status byte for each
> channels. If it's true, then we need to take care about the expansion
> in the mtpav driver, because the sequencer MIDI driver removes
> duplicated status bytes to opmitize throughput.
<snip>

OK, I've attached a patch that emulated running status in the mtpav
driver, so there shouldn't be any need to change stuff elsewhere.

Thanks for your pointer, I've been wanting to fix this problem for a
very long time. :-)

-- 
Ryan Pavlik <rpav@users.sf.net>

"I distinctly remember dancing on your grave." - 8BT

--Multipart_Wed__12_Feb_2003_14:35:29_-0800_0832bb00
Content-Type: application/octet-stream;
 name="mtpav.patch"
Content-Disposition: attachment;
 filename="mtpav.patch"
Content-Transfer-Encoding: base64

LS0tIG10cGF2LmMJMjAwMy0wMi0xMiAxNDoyNDo0OC4wMDAwMDAwMDAgLTA4MDAKKysrIG10cGF2
LXJwYXYuYwkyMDAzLTAyLTEyIDE0OjI5OjQ1LjAwMDAwMDAwMCAtMDgwMApAQCAtMTM1LDYgKzEz
NSw3IEBACiAJdTggbnVtYmVyOwogCXU4IGh3cG9ydDsKIAl1OCBtb2RlOworCXU4IHJ1bm5pbmdf
c3RhdHVzOwogCXNuZF9yYXdtaWRpX3N1YnN0cmVhbV90ICppbnB1dDsKIAlzbmRfcmF3bWlkaV9z
dWJzdHJlYW1fdCAqb3V0cHV0OwogfSBtdHBhdl9wb3J0X3Q7CkBAIC0zMDAsNiArMzAxLDExIEBA
CiAJCQkJCXNuZF9yYXdtaWRpX3N1YnN0cmVhbV90ICpzdWJzdHJlYW0pCiB7CiAJdTggb3V0Ynl0
ZTsKKwlpbnQgYnl0ZXNfY29waWVkOworCisJLy8gR2V0IHRoZSBvdXRieWUgZmlyc3QsIHNvIHdl
IGNhbiBlbXVsYXRlIHJ1bm5pbmcgc3RhdHVzIGlmCisJLy8gbmVjZXNzYXJ5CisJYnl0ZXNfY29w
aWVkID0gc25kX3Jhd21pZGlfdHJhbnNtaXQoc3Vic3RyZWFtLCAmb3V0Ynl0ZSwgMSk7CiAKIAkv
LyBzZW5kIHBvcnQgY2hhbmdlIGNvbW1hbmQgaWYgbmVjZXNzYXJ5CiAKQEAgLTMxMCwxMiArMzE2
LDE5IEBACiAJCXNuZF9tdHBhdl9zZW5kX2J5dGUobXRwX2NhcmQsIHBvcnQtPmh3cG9ydCk7CiAJ
CS8vc25kX3ByaW50aygibmV3IG91dHBvcnQ6IDB4JXhcbiIsICh1bnNpZ25lZCBpbnQpIHBvcnQt
Pmh3cG9ydCk7CiAKKwkJaWYgKGJ5dGVzX2NvcGllZCA9PSAxICYmICEob3V0Ynl0ZSAmIDB4ODAp
KQorCQkJc25kX210cGF2X3NlbmRfYnl0ZShtdHBfY2FyZCwgcG9ydC0+cnVubmluZ19zdGF0dXMp
OwogCX0KIAogCS8vIHNlbmQgZGF0YQogCi0Jd2hpbGUgKHNuZF9yYXdtaWRpX3RyYW5zbWl0KHN1
YnN0cmVhbSwgJm91dGJ5dGUsIDEpID09IDEpCisJd2hpbGUgKGJ5dGVzX2NvcGllZCA9PSAxKSB7
CisJCWlmKG91dGJ5dGUgJiAweDgwKQorCQkJcG9ydC0+cnVubmluZ19zdGF0dXMgPSBvdXRieXRl
OworCQkKIAkJc25kX210cGF2X3NlbmRfYnl0ZShtdHBfY2FyZCwgb3V0Ynl0ZSk7CisJCWJ5dGVz
X2NvcGllZCA9IHNuZF9yYXdtaWRpX3RyYW5zbWl0KHN1YnN0cmVhbSwgJm91dGJ5dGUsIDEpOwor
CX0KIH0KIAogc3RhdGljIHZvaWQgc25kX210cGF2X291dHB1dF93cml0ZShzbmRfcmF3bWlkaV9z
dWJzdHJlYW1fdCAqIHN1YnN0cmVhbSkK

--Multipart_Wed__12_Feb_2003_14:35:29_-0800_0832bb00--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
