From: Trent Piepho <xyzzy@speakeasy.org>
Subject: [PATCH] ad1848 ac loop
Date: Tue, 18 Sep 2007 22:22:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709181930050.27377@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="289736052-2121362787-1190179362=:27377"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail7.sea5.speakeasy.net (mail7.sea5.speakeasy.net
	[69.17.117.9]) by alsa0.perex.cz (Postfix) with ESMTP id B33C124585
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 07:22:45 +0200 (CEST)
Received: from shell4.sea5.speakeasy.net ([69.17.116.5])
	(envelope-sender <xyzzy@speakeasy.org>)
	by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted
	SMTP for <alsa-devel@alsa-project.org>; 19 Sep 2007 05:22:42 -0000
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
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--289736052-2121362787-1190179362=:27377
Content-Type: TEXT/PLAIN; charset=US-ASCII

New thread for the the final version of the patches for my fixes to the ad1848
auto-calibration loop.  I made a couple suggested changes.  These should be ok
to apply, and should be independent of the other as yet un-applied patches
that have been posted by Rene and Krzysztof.

I'm not an expert on this chip by any means, but from looking at the code I
think there are few things that could be fixed.

The reg_lock spinlock isn't acquired from the irq handler, as the handler
doesn't use any of the indirect registers.  I think this means that is isn't
necessary to use the irq disabling versions of the spin_lock functions with
reg_lock.

It does look like there is a different SMP race condition wrt the irq handler.
>From snd_ad1848_interrupt():
578         if ((chip->mode & AD1848_MODE_PLAY) && chip->playback_substream &&
579             (chip->mode & AD1848_MODE_RUNNING))
580                 snd_pcm_period_elapsed(chip->playback_substream);

Another CPU could close the substream between the check and the call to
snd_pcm_period_elapsed().  snd_pcm_period_elapsed() could be called with
either NULL or a stale substream pointer depending on how the code compiled.
I'd think creating an irq spinlock would be an easy way to fix this.  The irq
handler would grab it, and the same with the open() and close() functions
around the code that sets the substream pointers.  Alternatively, one could
disabled the irq handler during open and close.

I think there might also be problem with setting mixers controls during
auto-calibration .  While waiting for auto-calibration to finish, the chip
isn't locked.  If another thread tries to set the volume via the mixer
interface, it won't be blocked and will try to talk to the chip during AC.
The datasheet just says to wait for auto-calibration to finish, it doesn't say
what happens if you don't.  So maybe there isn't any problem here.
--289736052-2121362787-1190179362=:27377
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ad1848_swa.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0709182222420.27377@shell4.speakeasy.net>
Content-Description: 
Content-Disposition: attachment; filename="ad1848_swa.patch"

YWQxODQ4OiBGaXggbXNsZWVwIHdoaWxlIGF0b21pYw0KDQpTaW1wbGVzdCBm
aXguDQoNClNpZ25lZC1vZmYtYnk6IFRyZW50IFBpZXBobyA8eHl6enlAc3Bl
YWtlYXN5Lm9yZz4NCkFja2VkLWJ5OiBSZW5lIEhlcm1hbiA8cmVuZS5oZXJt
YW5AZ21haWwuY29tPg0KDQpkaWZmIC1yIDUwNTAyYzEzZDJjZiBpc2EvYWQx
ODQ4L2FkMTg0OF9saWIuYw0KLS0tIGEvaXNhL2FkMTg0OC9hZDE4NDhfbGli
LmMJTW9uIFNlcCAxNyAxOTowODozMiAyMDA3ICswMjAwDQorKysgYi9pc2Ev
YWQxODQ4L2FkMTg0OF9saWIuYwlNb24gU2VwIDE3IDE5OjE5OjUyIDIwMDcg
LTA3MDANCkBAIC0yMzYsNyArMjM2LDkgQEAgc3RhdGljIHZvaWQgc25kX2Fk
MTg0OF9tY2VfZG93bihzdHJ1Y3Qgcw0KIAkgKiBjYWxpYnJhdGlvbiBwcm9j
ZXNzIHRvIHN0YXJ0LiBOZWVkcyB1cHRvIDUgc2FtcGxlIHBlcmlvZHMgb24g
QUQxODQ4DQogCSAqIHdoaWNoIGF0IHRoZSBzbG93ZXN0IHBvc3NpYmxlIHJh
dGUgb2YgNS41MTI1IGtIeiBtZWFucyA5MDcgdXMuDQogCSAqLw0KKwlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZjaGlwLT5yZWdfbG9jaywgZmxhZ3MpOw0K
IAltc2xlZXAoMSk7DQorCXNwaW5fbG9ja19pcnFzYXZlKCZjaGlwLT5yZWdf
bG9jaywgZmxhZ3MpOw0KIA0KIAlzbmRfcHJpbnRkZCgiKDIpIGppZmZpZXMg
PSAlbHVcbiIsIGppZmZpZXMpOw0KIA0K

--289736052-2121362787-1190179362=:27377
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ad1848.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0709182222421.27377@shell4.speakeasy.net>
Content-Description: 
Content-Disposition: attachment; filename="ad1848.patch"

YWQxODQ4OiBzaW1wbGlmeSBNQ0UgZG93biBjb2RlDQoNClRoZSBwb2xsaW5n
IGxvb3AgdG8gY2hlY2sgZm9yIEFDSSB0byBnbyBkb3duIHdhcyBtb3JlIGNv
bnZvbHV0ZWQgdGhhbiBpdA0KbmVlZGVkIHRvIGJlLiAgTmV3IGxvb3Agc2hv
dWxkIGJlIG1vcmUgZWZmaWNpZW50IGFuZCBpdCBpcyBhIGxvdCBzaW1wbGVy
LiAgVGhlDQpvbGQgbG9vcCBjaGVja2VkIGZvciBhIHRpbWVvdXQgYmVmb3Jl
IGNoZWNraW5nIGZvciBBQ0kgZG93biwgd2hpY2ggY291bGQNCnJlc3VsdCBp
biBhbiBlcnJvbmVvdXMgdGltZW91dC4gIEl0J3Mgb25seSBhIGZhaWx1cmUg
aWYgdGhlIHRpbWVvdXQgZXhwaXJlcw0KX2FuZF8gQUNJIGlzIHN0aWxsIGhp
Z2guICBUaGVyZSBpcyBub3RoaW5nIHdyb25nIHdpdGggdGhlIHRpbWVvdXQg
ZXhwaXJpbmcNCndoaWxlIHRoZSB0YXNrIGlzIHNsZWVwaW5nIGlmIEFDSSB3
ZW50IGxvdy4NCg0KQSBwb2xsaW5nIGxvb3AgdG8gY2hlY2sgZm9yIHRoZSBk
ZXZpY2UgdG8gbGVhdmluZyBJTklUIG1vZGUgaXMgcmVtb3ZlZC4gIFRoZQ0K
ZGV2aWNlIG11c3QgaGF2ZSBhbHJlYWR5IGxlZnQgaW5pdCBmb3IgdGhlIHBy
ZXZpb3VzIEFDSSBsb29wIHRvIGhhdmUgZmluaXNoZWQuDQoNClNpZ25lZC1v
ZmYtYnk6IFRyZW50IFBpZXBobyA8eHl6enlAc3BlYWtlYXN5Lm9yZz4NCkFj
a2VkLWJ5OiBSZW5lIEhlcm1hbiA8cmVuZS5oZXJtYW5AZ21haWwuY29tPg0K
DQpkaWZmIC1yIGVjOTYyODNhMjczZiBpc2EvYWQxODQ4L2FkMTg0OF9saWIu
Yw0KLS0tIGEvaXNhL2FkMTg0OC9hZDE4NDhfbGliLmMJTW9uIFNlcCAxNyAx
OToyMDo0OCAyMDA3IC0wNzAwDQorKysgYi9pc2EvYWQxODQ4L2FkMTg0OF9s
aWIuYwlUdWUgU2VwIDE4IDE5OjI2OjQyIDIwMDcgLTA3MDANCkBAIC0yMDMs
OSArMjAzLDggQEAgc3RhdGljIHZvaWQgc25kX2FkMTg0OF9tY2VfdXAoc3Ry
dWN0IHNuZA0KIA0KIHN0YXRpYyB2b2lkIHNuZF9hZDE4NDhfbWNlX2Rvd24o
c3RydWN0IHNuZF9hZDE4NDggKmNoaXApDQogew0KLQl1bnNpZ25lZCBsb25n
IGZsYWdzOw0KLQlpbnQgdGltZW91dDsNCi0JdW5zaWduZWQgbG9uZyBlbmRf
dGltZTsNCisJdW5zaWduZWQgbG9uZyBmbGFncywgdGltZW91dDsNCisJaW50
IHJlZzsNCiANCiAJc3Bpbl9sb2NrX2lycXNhdmUoJmNoaXAtPnJlZ19sb2Nr
LCBmbGFncyk7DQogCWZvciAodGltZW91dCA9IDU7IHRpbWVvdXQgPiAwOyB0
aW1lb3V0LS0pDQpAQCAtMjIyLDUwICsyMjEsMzYgQEAgc3RhdGljIHZvaWQg
c25kX2FkMTg0OF9tY2VfZG93bihzdHJ1Y3Qgcw0KICNlbmRpZg0KIA0KIAlj
aGlwLT5tY2VfYml0ICY9IH5BRDE4NDhfTUNFOw0KLQl0aW1lb3V0ID0gaW5i
KEFEMTg0OFAoY2hpcCwgUkVHU0VMKSk7DQotCW91dGIoY2hpcC0+bWNlX2Jp
dCB8ICh0aW1lb3V0ICYgMHgxZiksIEFEMTg0OFAoY2hpcCwgUkVHU0VMKSk7
DQotCWlmICh0aW1lb3V0ID09IDB4ODApDQorCXJlZyA9IGluYihBRDE4NDhQ
KGNoaXAsIFJFR1NFTCkpOw0KKwlvdXRiKGNoaXAtPm1jZV9iaXQgfCAocmVn
ICYgMHgxZiksIEFEMTg0OFAoY2hpcCwgUkVHU0VMKSk7DQorCWlmIChyZWcg
PT0gMHg4MCkNCiAJCXNuZF9wcmludGsoS0VSTl9XQVJOSU5HICJtY2VfZG93
biBbMHglbHhdOiBzZXJpb3VzIGluaXQgcHJvYmxlbSAtIGNvZGVjIHN0aWxs
IGJ1c3lcbiIsIGNoaXAtPnBvcnQpOw0KLQlpZiAoKHRpbWVvdXQgJiBBRDE4
NDhfTUNFKSA9PSAwKSB7DQorCWlmICgocmVnICYgQUQxODQ4X01DRSkgPT0g
MCkgew0KIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY2hpcC0+cmVnX2xv
Y2ssIGZsYWdzKTsNCiAJCXJldHVybjsNCiAJfQ0KIA0KIAkvKg0KLQkgKiBX
YWl0IGZvciAocG9zc2libGUgLS0gZHVyaW5nIGluaXQgYXV0by1jYWxpYnJh
dGlvbiBtYXkgbm90IGJlIHNldCkNCi0JICogY2FsaWJyYXRpb24gcHJvY2Vz
cyB0byBzdGFydC4gTmVlZHMgdXB0byA1IHNhbXBsZSBwZXJpb2RzIG9uIEFE
MTg0OA0KLQkgKiB3aGljaCBhdCB0aGUgc2xvd2VzdCBwb3NzaWJsZSByYXRl
IG9mIDUuNTEyNSBrSHogbWVhbnMgOTA3IHVzLg0KKwkgKiBXYWl0IGZvciBh
dXRvLWNhbGlicmF0aW9uIChBQykgcHJvY2VzcyB0byBmaW5pc2gsIGkuZS4g
QUNJIHRvIGdvIGxvdy4NCisJICogSXQgbWF5IHRha2UgdXAgdG8gNSBzYW1w
bGUgcGVyaW9kcyAoYXQgbW9zdCA5MDcgdXMgQCA1LjUxMjUga0h6KSBmb3IN
CisJICogdGhlIHByb2Nlc3MgdG8gX3N0YXJ0Xywgc28gaXQgaXMgaW1wb3J0
YW50IHRvIHdhaXQgYXQgbGVhc3QgdGhhdCBsb25nDQorCSAqIGJlZm9yZSBj
aGVja2luZy4gIE90aGVyd2lzZSB3ZSBtaWdodCB0aGluayBBQyBoYXMgZmlu
aXNoZWQgd2hlbiBpdA0KKwkgKiBoYXMgaW4gZmFjdCBub3QgYmVndW4uICBJ
dCBjb3VsZCB0YWtlIDEyOCAobm8gQUMpIG9yIDM4NCAoQUMpIGN5Y2xlcw0K
KwkgKiBmb3IgQUNJIHRvIGRyb3AuICBUaGlzIGdpdmVzIGEgd2FpdCBvZiBh
dCBtb3N0IDcwIG1zIHdpdGggYSBtb3JlDQorCSAqIHR5cGljYWwgdmFsdWUg
b2YgMy05IG1zLg0KIAkgKi8NCi0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
Y2hpcC0+cmVnX2xvY2ssIGZsYWdzKTsNCi0JbXNsZWVwKDEpOw0KLQlzcGlu
X2xvY2tfaXJxc2F2ZSgmY2hpcC0+cmVnX2xvY2ssIGZsYWdzKTsNCi0NCi0J
c25kX3ByaW50ZGQoIigyKSBqaWZmaWVzID0gJWx1XG4iLCBqaWZmaWVzKTsN
Ci0NCi0JZW5kX3RpbWUgPSBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcygy
NTApOw0KLQl3aGlsZSAoc25kX2FkMTg0OF9pbihjaGlwLCBBRDE4NDhfVEVT
VF9JTklUKSAmIEFEMTg0OF9DQUxJQl9JTl9QUk9HUkVTUykgew0KKwl0aW1l
b3V0ID0gamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMjUwKTsNCisJZG8g
ew0KIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY2hpcC0+cmVnX2xvY2ss
IGZsYWdzKTsNCi0JCWlmICh0aW1lX2FmdGVyKGppZmZpZXMsIGVuZF90aW1l
KSkgew0KLQkJCXNuZF9wcmludGsoS0VSTl9FUlIgIm1jZV9kb3duIC0gYXV0
byBjYWxpYnJhdGlvbiB0aW1lIG91dCAoMilcbiIpOw0KLQkJCXJldHVybjsN
Ci0JCX0NCiAJCW1zbGVlcCgxKTsNCiAJCXNwaW5fbG9ja19pcnFzYXZlKCZj
aGlwLT5yZWdfbG9jaywgZmxhZ3MpOw0KLQl9DQotDQotCXNuZF9wcmludGRk
KCIoMykgamlmZmllcyA9ICVsdVxuIiwgamlmZmllcyk7DQotDQotCWVuZF90
aW1lID0gamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAwKTsNCi0Jd2hp
bGUgKGluYihBRDE4NDhQKGNoaXAsIFJFR1NFTCkpICYgQUQxODQ4X0lOSVQp
IHsNCi0JCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNoaXAtPnJlZ19sb2Nr
LCBmbGFncyk7DQotCQlpZiAodGltZV9hZnRlcihqaWZmaWVzLCBlbmRfdGlt
ZSkpIHsNCi0JCQlzbmRfcHJpbnRrKEtFUk5fRVJSICJtY2VfZG93biAtIGF1
dG8gY2FsaWJyYXRpb24gdGltZSBvdXQgKDMpXG4iKTsNCi0JCQlyZXR1cm47
DQotCQl9DQotCQltc2xlZXAoMSk7DQotCQlzcGluX2xvY2tfaXJxc2F2ZSgm
Y2hpcC0+cmVnX2xvY2ssIGZsYWdzKTsNCi0JfQ0KLQlzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZjaGlwLT5yZWdfbG9jaywgZmxhZ3MpOw0KKwkJcmVnID0g
c25kX2FkMTg0OF9pbihjaGlwLCBBRDE4NDhfVEVTVF9JTklUKSAmDQorCQkg
ICAgICBBRDE4NDhfQ0FMSUJfSU5fUFJPR1JFU1M7DQorCX0gd2hpbGUgKHJl
ZyAmJiB0aW1lX2JlZm9yZShqaWZmaWVzLCB0aW1lb3V0KSk7DQorCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmNoaXAtPnJlZ19sb2NrLCBmbGFncyk7DQor
CWlmIChyZWcpDQorCQlzbmRfcHJpbnRrKEtFUk5fRVJSDQorCQkJICAgIm1j
ZV9kb3duIC0gYXV0byBjYWxpYnJhdGlvbiB0aW1lIG91dCAoMilcbiIpOw0K
IA0KIAlzbmRfcHJpbnRkZCgiKDQpIGppZmZpZXMgPSAlbHVcbiIsIGppZmZp
ZXMpOw0KIAlzbmRfcHJpbnRkKCJtY2VfZG93biAtIGV4aXQgPSAweCV4XG4i
LCBpbmIoQUQxODQ4UChjaGlwLCBSRUdTRUwpKSk7DQo=

--289736052-2121362787-1190179362=:27377
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--289736052-2121362787-1190179362=:27377--
