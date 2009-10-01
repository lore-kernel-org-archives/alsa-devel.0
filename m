From: Dan Chen <crimsunkg@yahoo.com>
Subject: Re: Patches for alsactl init db
Date: Thu, 1 Oct 2009 16:01:47 -0700 (PDT)
Message-ID: <90618.15893.qm@web31810.mail.mud.yahoo.com>
References: <937485.7802.qm@web31808.mail.mud.yahoo.com>
	<s5heippotjp.wl%tiwai@suse.de>
	<604760770909302132g40c5deb4qdbf96ec6e6ad40b7@mail.gmail.com>
	<s5hr5tnk6rr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1218006799-1254438107=:15893"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web31810.mail.mud.yahoo.com (web31810.mail.mud.yahoo.com
	[68.142.207.73]) by alsa0.perex.cz (Postfix) with SMTP id 023311037F8
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 01:01:49 +0200 (CEST)
In-Reply-To: <s5hr5tnk6rr.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0-1218006799-1254438107=:15893
Content-Type: text/plain; charset=us-ascii

I'm attaching another patch (against current sound-2.6 HEAD) for another
VAIO model also confirmed to need the same quirk.



      
--0-1218006799-1254438107=:15893
Content-Type: application/octet-stream; name="0002-ALSA-intel8x0-Mute-External-Amplifier-by-default-for.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0002-ALSA-intel8x0-Mute-External-Amplifier-by-default-for.patch"

RnJvbSBmYTM0OTk0NmRlZjU2Mjk3NzUyMWE5YjczMzdlODMxOWQwYjgyN2Y1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVu
IDxjcmltc3VuQHVidW50dS5jb20+CkRhdGU6IFRodSwgMSBPY3QgMjAwOSAx
ODo1NjozMCAtMDQwMApTdWJqZWN0OiBBTFNBOiBpbnRlbDh4MCAtIE11dGUg
RXh0ZXJuYWwgQW1wbGlmaWVyIGJ5IGRlZmF1bHQgZm9yIFNvbnkgVkFJTyBW
R04tQjFWUAoKQnVnTGluazogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQv
YnVncy80MTA5MzMKClRoaXMgU29ueSBWQUlPIG1vZGVsIGFsc28gbmVlZHMg
RXh0ZXJuYWwgQW1wbGlmaWVyIHVubXV0ZWQgZm9yIGF1ZGlibGUKcGxheWJh
Y2ssIHNvIG1ha2Ugc3VyZSB3ZSBzZXQgdGhlIGludl9lYXBkIHF1aXJrLgoK
U2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUu
Y29tPgotLS0KIHNvdW5kL3BjaS9pbnRlbDh4MC5jIHwgICAgNiArKysrKysK
IDEgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9pbnRlbDh4MC5jIGIvc291
bmQvcGNpL2ludGVsOHgwLmMKaW5kZXggODZlOWEyZC4uNzU0ODY3ZSAxMDA2
NDQKLS0tIGEvc291bmQvcGNpL2ludGVsOHgwLmMKKysrIGIvc291bmQvcGNp
L2ludGVsOHgwLmMKQEAgLTE5NjAsNiArMTk2MCwxMiBAQCBzdGF0aWMgc3Ry
dWN0IGFjOTdfcXVpcmsgYWM5N19xdWlya3NbXSBfX2RldmluaXRkYXRhID0g
ewogCQkubmFtZSA9ICJTb255IFZBSU8gVkdOLVQzNTBQIiwgLypBRDE5ODFC
Ki8KIAkJLnR5cGUgPSBBQzk3X1RVTkVfSU5WX0VBUEQKIAl9LAorCXsKKwkJ
LnN1YnZlbmRvciA9IDB4MTA0ZCwKKwkJLnN1YmRldmljZSA9IDB4ODFjNSwK
KwkJLm5hbWUgPSAiU29ueSBWQUlPIFZHTi1CMVZQIiwgLypBRDE5ODFCKi8K
KwkJLnR5cGUgPSBBQzk3X1RVTkVfSU5WX0VBUEQKKwl9LAogIAl7CiAJCS5z
dWJ2ZW5kb3IgPSAweDEwNDMsCiAJCS5zdWJkZXZpY2UgPSAweDgwZjMsCi0t
IAoxLjYuMy4zCgo=

--0-1218006799-1254438107=:15893
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-1218006799-1254438107=:15893--
