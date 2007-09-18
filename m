From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Mon, 17 Sep 2007 19:32:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709171757500.27377@shell4.speakeasy.net>
References: <46E58D01.9080809@gmail.com>
	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
	<46EF18FF.7070906@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="289736052-1254161711-1190082731=:27377"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail7.sea5.speakeasy.net (mail7.sea5.speakeasy.net
	[69.17.117.9]) by alsa0.perex.cz (Postfix) with ESMTP id 0E6002442C
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 04:32:12 +0200 (CEST)
In-Reply-To: <46EF18FF.7070906@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--289736052-1254161711-1190082731=:27377
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 18 Sep 2007, Rene Herman wrote:
> > Second, schedule_timeout() returns immediately unless you have set the
> > task state to TASK_UNINTERRUPTIBLE or TASK_INTERRUPTIBLE.  I don't see
> > anywhere where this is done, so the 250ms delay is in fact a busy loop.
> > The call to schedule_timeout() appears to be quite pointless.
>
> That mce_down code was changed over the last week by Krzysztof, myself and
> Takashi so not sure what version you've been looking at, but the (original)

I originally wrote that email in response to the email I replied to, and
with respect to the code that was in it:
http://article.gmane.org/gmane.linux.alsa.devel/48528

There were more patches before I actually sent the email, so I based my
patch on what was in ALSA Hg at the time.

> version that the quoted patch was against didn't use schedule_timeout, but a
> timeout based sleeping loop for cs4231 and schedule_timeout_interruptible()
> for ad1848 which sets the state itself.

You can see the version in Hg after your patch was applied, and it
uses schedule_timeout()
http://hg.alsa-project.org/alsa-kernel/file/f3f37d068eae/isa/ad1848/ad1848_lib.c

It wasn't until changeset 3675ae62becf, 7 days later (and after I wrote that
email), that it was changed.

> > Here is a patch to fix all these problems and simplify the code in the
> > process.
>
> I looked at it, but am not sure what version it is against. It seems to

Current Hg.

> msleep(3) still under lock. As you said, the minimal fix right now is to

I seem to have deleted the necessary unlock call before I sent the patch.  One
of the tests is inverted too.  Here is a new version which fixes all that.  The
other problem you pointed at out in the current code about mistaken timeouts is
fixed as well.
--289736052-1254161711-1190082731=:27377
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ad1848_swa.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0709171932110.27377@shell4.speakeasy.net>
Content-Description: 
Content-Disposition: attachment; filename="ad1848_swa.patch"

YWQxODQ4OiBGaXggbXNsZWVwIHdoaWxlIGF0b21pYw0NCg0NClNpbXBsZXN0
IGZpeC4NDQoNDQpTaWduZWQtb2ZmLWJ5OiBUcmVudCBQaWVwaG8gPHh5enp5
QHNwZWFrZWFzeS5vcmc+DQoNCmRpZmYgLXIgNTA1MDJjMTNkMmNmIGlzYS9h
ZDE4NDgvYWQxODQ4X2xpYi5jDQotLS0gYS9pc2EvYWQxODQ4L2FkMTg0OF9s
aWIuYwlNb24gU2VwIDE3IDE5OjA4OjMyIDIwMDcgKzAyMDANCisrKyBiL2lz
YS9hZDE4NDgvYWQxODQ4X2xpYi5jCU1vbiBTZXAgMTcgMTk6MTk6NTIgMjAw
NyAtMDcwMA0KQEAgLTIzNiw3ICsyMzYsOSBAQCBzdGF0aWMgdm9pZCBzbmRf
YWQxODQ4X21jZV9kb3duKHN0cnVjdCBzDQogCSAqIGNhbGlicmF0aW9uIHBy
b2Nlc3MgdG8gc3RhcnQuIE5lZWRzIHVwdG8gNSBzYW1wbGUgcGVyaW9kcyBv
biBBRDE4NDgNCiAJICogd2hpY2ggYXQgdGhlIHNsb3dlc3QgcG9zc2libGUg
cmF0ZSBvZiA1LjUxMjUga0h6IG1lYW5zIDkwNyB1cy4NCiAJICovDQorCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmNoaXAtPnJlZ19sb2NrLCBmbGFncyk7
DQogCW1zbGVlcCgxKTsNCisJc3Bpbl9sb2NrX2lycXNhdmUoJmNoaXAtPnJl
Z19sb2NrLCBmbGFncyk7DQogDQogCXNuZF9wcmludGRkKCIoMikgamlmZmll
cyA9ICVsdVxuIiwgamlmZmllcyk7DQogDQo=

--289736052-1254161711-1190082731=:27377
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ad1848.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0709171932111.27377@shell4.speakeasy.net>
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
ZmYtYnk6IFRyZW50IFBpZXBobyA8eHl6enlAc3BlYWtlYXN5Lm9yZz4NCg0K
ZGlmZiAtciBlYzk2MjgzYTI3M2YgaXNhL2FkMTg0OC9hZDE4NDhfbGliLmMN
Ci0tLSBhL2lzYS9hZDE4NDgvYWQxODQ4X2xpYi5jCU1vbiBTZXAgMTcgMTk6
MjA6NDggMjAwNyAtMDcwMA0KKysrIGIvaXNhL2FkMTg0OC9hZDE4NDhfbGli
LmMJTW9uIFNlcCAxNyAxOToyMjozNiAyMDA3IC0wNzAwDQpAQCAtMjAzLDkg
KzIwMyw4IEBAIHN0YXRpYyB2b2lkIHNuZF9hZDE4NDhfbWNlX3VwKHN0cnVj
dCBzbmQNCiANCiBzdGF0aWMgdm9pZCBzbmRfYWQxODQ4X21jZV9kb3duKHN0
cnVjdCBzbmRfYWQxODQ4ICpjaGlwKQ0KIHsNCi0JdW5zaWduZWQgbG9uZyBm
bGFnczsNCi0JaW50IHRpbWVvdXQ7DQotCXVuc2lnbmVkIGxvbmcgZW5kX3Rp
bWU7DQorCXVuc2lnbmVkIGxvbmcgZmxhZ3MsIHRpbWVvdXQ7DQorCWludCBy
ZWdzZWw7DQogDQogCXNwaW5fbG9ja19pcnFzYXZlKCZjaGlwLT5yZWdfbG9j
aywgZmxhZ3MpOw0KIAlmb3IgKHRpbWVvdXQgPSA1OyB0aW1lb3V0ID4gMDsg
dGltZW91dC0tKQ0KQEAgLTIyMiw1MCArMjIxLDM0IEBAIHN0YXRpYyB2b2lk
IHNuZF9hZDE4NDhfbWNlX2Rvd24oc3RydWN0IHMNCiAjZW5kaWYNCiANCiAJ
Y2hpcC0+bWNlX2JpdCAmPSB+QUQxODQ4X01DRTsNCi0JdGltZW91dCA9IGlu
YihBRDE4NDhQKGNoaXAsIFJFR1NFTCkpOw0KLQlvdXRiKGNoaXAtPm1jZV9i
aXQgfCAodGltZW91dCAmIDB4MWYpLCBBRDE4NDhQKGNoaXAsIFJFR1NFTCkp
Ow0KLQlpZiAodGltZW91dCA9PSAweDgwKQ0KKwlyZWdzZWwgPSBpbmIoQUQx
ODQ4UChjaGlwLCBSRUdTRUwpKTsNCisJb3V0YihjaGlwLT5tY2VfYml0IHwg
KHJlZ3NlbCAmIDB4MWYpLCBBRDE4NDhQKGNoaXAsIFJFR1NFTCkpOw0KKwlp
ZiAocmVnc2VsID09IDB4ODApDQogCQlzbmRfcHJpbnRrKEtFUk5fV0FSTklO
RyAibWNlX2Rvd24gWzB4JWx4XTogc2VyaW91cyBpbml0IHByb2JsZW0gLSBj
b2RlYyBzdGlsbCBidXN5XG4iLCBjaGlwLT5wb3J0KTsNCi0JaWYgKCh0aW1l
b3V0ICYgQUQxODQ4X01DRSkgPT0gMCkgew0KKwlpZiAoKHJlZ3NlbCAmIEFE
MTg0OF9NQ0UpID09IDApIHsNCiAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmNoaXAtPnJlZ19sb2NrLCBmbGFncyk7DQogCQlyZXR1cm47DQogCX0NCiAN
CiAJLyoNCi0JICogV2FpdCBmb3IgKHBvc3NpYmxlIC0tIGR1cmluZyBpbml0
IGF1dG8tY2FsaWJyYXRpb24gbWF5IG5vdCBiZSBzZXQpDQotCSAqIGNhbGli
cmF0aW9uIHByb2Nlc3MgdG8gc3RhcnQuIE5lZWRzIHVwdG8gNSBzYW1wbGUg
cGVyaW9kcyBvbiBBRDE4NDgNCi0JICogd2hpY2ggYXQgdGhlIHNsb3dlc3Qg
cG9zc2libGUgcmF0ZSBvZiA1LjUxMjUga0h6IG1lYW5zIDkwNyB1cy4NCisJ
ICogV2FpdCBmb3IgYXV0by1jYWxpYnJhdGlvbiAoQUMpIHByb2Nlc3MgdG8g
ZmluaXNoLCBpLmUuIEFDSSB0byBnbyBsb3cuDQorCSAqIEl0IG1heSB0YWtl
IHVwIHRvIDUgc2FtcGxlIHBlcmlvZHMgKGF0IG1vc3QgOTA3IHVzIEAgNS41
MTI1IGtIeikgZm9yDQorCSAqIHRoZSBwcm9jZXNzIHRvIF9zdGFydF8sIHNv
IGl0IGlzIGltcG9ydGFudCB0byB3YWl0IGF0IGxlYXN0IHRoYXQgbG9uZw0K
KwkgKiBiZWZvcmUgY2hlY2tpbmcuICBPdGhlcndpc2Ugd2UgbWlnaHQgdGhp
bmsgQUMgaGFzIGZpbmlzaGVkIHdoZW4gaXQNCisJICogaGFzIGluIGZhY3Qg
bm90IGJlZ3VuLiAgSXQgc2hvdWxkIHRha2UgMTI4IChubyBBQykgb3IgMzg0
IChBQykgY3ljbGVzDQorCSAqIGZvciBBQ0kgdG8gZHJvcC4gIFRoaXMgZ2l2
ZXMgYSB3YWl0IG9mIGF0IG1vc3QgNzAgbXMgd2l0aCBhIG1vcmUNCisJICog
dHlwaWNhbCB2YWx1ZSBvZiAzLTkgbXMuDQogCSAqLw0KLQlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZjaGlwLT5yZWdfbG9jaywgZmxhZ3MpOw0KLQltc2xl
ZXAoMSk7DQotCXNwaW5fbG9ja19pcnFzYXZlKCZjaGlwLT5yZWdfbG9jaywg
ZmxhZ3MpOw0KLQ0KLQlzbmRfcHJpbnRkZCgiKDIpIGppZmZpZXMgPSAlbHVc
biIsIGppZmZpZXMpOw0KLQ0KLQllbmRfdGltZSA9IGppZmZpZXMgKyBtc2Vj
c190b19qaWZmaWVzKDI1MCk7DQotCXdoaWxlIChzbmRfYWQxODQ4X2luKGNo
aXAsIEFEMTg0OF9URVNUX0lOSVQpICYgQUQxODQ4X0NBTElCX0lOX1BST0dS
RVNTKSB7DQorCXRpbWVvdXQgPSBqaWZmaWVzICsgbXNlY3NfdG9famlmZmll
cygyNTApOw0KKwlkbyB7DQogCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZj
aGlwLT5yZWdfbG9jaywgZmxhZ3MpOw0KLQkJaWYgKHRpbWVfYWZ0ZXIoamlm
ZmllcywgZW5kX3RpbWUpKSB7DQotCQkJc25kX3ByaW50ayhLRVJOX0VSUiAi
bWNlX2Rvd24gLSBhdXRvIGNhbGlicmF0aW9uIHRpbWUgb3V0ICgyKVxuIik7
DQotCQkJcmV0dXJuOw0KLQkJfQ0KIAkJbXNsZWVwKDEpOw0KIAkJc3Bpbl9s
b2NrX2lycXNhdmUoJmNoaXAtPnJlZ19sb2NrLCBmbGFncyk7DQotCX0NCi0N
Ci0Jc25kX3ByaW50ZGQoIigzKSBqaWZmaWVzID0gJWx1XG4iLCBqaWZmaWVz
KTsNCi0NCi0JZW5kX3RpbWUgPSBqaWZmaWVzICsgbXNlY3NfdG9famlmZmll
cygxMDApOw0KLQl3aGlsZSAoaW5iKEFEMTg0OFAoY2hpcCwgUkVHU0VMKSkg
JiBBRDE4NDhfSU5JVCkgew0KLQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
Y2hpcC0+cmVnX2xvY2ssIGZsYWdzKTsNCi0JCWlmICh0aW1lX2FmdGVyKGpp
ZmZpZXMsIGVuZF90aW1lKSkgew0KLQkJCXNuZF9wcmludGsoS0VSTl9FUlIg
Im1jZV9kb3duIC0gYXV0byBjYWxpYnJhdGlvbiB0aW1lIG91dCAoMylcbiIp
Ow0KLQkJCXJldHVybjsNCi0JCX0NCi0JCW1zbGVlcCgxKTsNCi0JCXNwaW5f
bG9ja19pcnFzYXZlKCZjaGlwLT5yZWdfbG9jaywgZmxhZ3MpOw0KLQl9DQot
CXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNoaXAtPnJlZ19sb2NrLCBmbGFn
cyk7DQorCQlyZWdzZWwgPSBzbmRfYWQxODQ4X2luKGNoaXAsIEFEMTg0OF9U
RVNUX0lOSVQpOw0KKwl9IHdoaWxlICgocmVnc2VsICYgQUQxODQ4X0NBTElC
X0lOX1BST0dSRVNTKSAmJiB0aW1lX2JlZm9yZShqaWZmaWVzLCB0aW1lb3V0
KSk7DQorCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNoaXAtPnJlZ19sb2Nr
LCBmbGFncyk7DQorCWlmIChyZWdzZWwgJiBBRDE4NDhfQ0FMSUJfSU5fUFJP
R1JFU1MpDQorCQlzbmRfcHJpbnRrKEtFUk5fRVJSICJtY2VfZG93biAtIGF1
dG8gY2FsaWJyYXRpb24gdGltZSBvdXQgKDIpXG4iKTsNCiANCiAJc25kX3By
aW50ZGQoIig0KSBqaWZmaWVzID0gJWx1XG4iLCBqaWZmaWVzKTsNCiAJc25k
X3ByaW50ZCgibWNlX2Rvd24gLSBleGl0ID0gMHgleFxuIiwgaW5iKEFEMTg0
OFAoY2hpcCwgUkVHU0VMKSkpOw0K

--289736052-1254161711-1190082731=:27377
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--289736052-1254161711-1190082731=:27377--
