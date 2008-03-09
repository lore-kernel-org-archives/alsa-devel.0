From: "M G" <lists.mg@googlemail.com>
Subject: Re: snd-hda-intel: Fix volume-wheel and microphone on
	Fujitsu-Siemens Amilo M3438G
Date: Sun, 9 Mar 2008 11:37:09 +0100
Message-ID: <74d457500803090337x79863188rba196911588acbeb@mail.gmail.com>
References: <74d457500802060814j64532e95v8c689cbb491c6b46@mail.gmail.com>
	<s5hir12kpne.wl%tiwai@suse.de>
	<74d457500802061502m31d412dap15009aad087b1b75@mail.gmail.com>
	<s5h8x1vy87l.wl%tiwai@suse.de>
	<74d457500802101048t2b92cb98qe6290a0186a00585@mail.gmail.com>
	<s5h8x1rwqh7.wl%tiwai@suse.de>
	<74d457500803060915y682558fancca3691d5abd340d@mail.gmail.com>
	<s5hiqzy20nc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_10840_21465528.1205059029926"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A417243D6
	for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2008 11:37:11 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so2577090pyg.36
	for <alsa-devel@alsa-project.org>; Sun, 09 Mar 2008 03:37:10 -0700 (PDT)
In-Reply-To: <s5hiqzy20nc.wl%tiwai@suse.de>
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

------=_Part_10840_21465528.1205059029926
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, Mar 7, 2008 at 1:12 PM, Takashi Iwai <tiwai@suse.de> wrote:
>
>  Thanks for the patch.  Could you give your sign-off together with a
>  proper changelog to commit to the upstream?
>
>
>  Takashi
>
>



Here you go.

------=_Part_10840_21465528.1205059029926
Content-Type: text/x-diff; name=F1734-microphone.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fdlgyy4p0
Content-Disposition: attachment; filename=F1734-microphone.patch

aGRhLWludGVsIC0gRml4IG1pY3JvcGhvbmUgY2FwdHVyZSB3aXRoIEFMQzg4MCBGMTczNCBtb2Rl
bAoKVGhlIGRlZmF1bHQgY2FwdHVyZSBzb3VyY2Ugc2hvdWxkIGJlIHRoZSBtaWMgd2hpY2ggaXMg
MHgwMSBvbiB0aGlzIG1vZGVsLgpJbiBhZGRpdGlvbiB0byB0aGF0IHRoZSBjaGFuZ2UgdG8gVlJF
RjUwIGFsbG93cyBmb3IgaGlnaGVyIGNhcHR1cmUgdm9sdW1lLgoKU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBHcnViZXIgPGxpc3RzLm1nQGdvb2dsZW1haWwuY29tPgoKCgpkaWZmIC1yIDNmMDE5OTNm
YmMzZCBwY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwotLS0gYS9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YwlTYXQgTWFyIDA4IDExOjA4OjMyIDIwMDggKzAxMDAKKysrIGIvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMJU3VuIE1hciAwOSAxMDo1NjoxOCAyMDA4ICswMTAwCkBAIC0xOTI3LDYgKzE5MjcsNyBA
QCBzdGF0aWMgdm9pZCBhbGM4ODBfdW5pd2lsbF9wNTNfdW5zb2xfZXZlCiAgKiBIUCA9IDB4MTQs
IHNwZWFrZXItb3V0ID0gMHgxNSwgbWljID0gMHgxOAogICovCiBzdGF0aWMgc3RydWN0IGhkYV92
ZXJiIGFsYzg4MF9waW5fZjE3MzRfaW5pdF92ZXJic1tdID0geworCXsweDA3LCBBQ19WRVJCX1NF
VF9DT05ORUNUX1NFTCwgMHgwMX0sCiAJezB4MTAsIEFDX1ZFUkJfU0VUX0NPTk5FQ1RfU0VMLCAw
eDAyfSwKIAl7MHgxMSwgQUNfVkVSQl9TRVRfQ09OTkVDVF9TRUwsIDB4MDB9LAogCXsweDEyLCBB
Q19WRVJCX1NFVF9DT05ORUNUX1NFTCwgMHgwMX0sCkBAIC0xOTM5LDcgKzE5NDAsNyBAQCBzdGF0
aWMgc3RydWN0IGhkYV92ZXJiIGFsYzg4MF9waW5fZjE3MzRfCiAKIAl7MHgxOCwgQUNfVkVSQl9T
RVRfUElOX1dJREdFVF9DT05UUk9MLCBQSU5fVlJFRjgwfSwKIAl7MHgxOCwgQUNfVkVSQl9TRVRf
QU1QX0dBSU5fTVVURSwgQU1QX09VVF9NVVRFfSwKLQl7MHgxOSwgQUNfVkVSQl9TRVRfUElOX1dJ
REdFVF9DT05UUk9MLCBQSU5fVlJFRjgwfSwKKwl7MHgxOSwgQUNfVkVSQl9TRVRfUElOX1dJREdF
VF9DT05UUk9MLCBQSU5fVlJFRjUwfSwKIAl7MHgxOSwgQUNfVkVSQl9TRVRfQU1QX0dBSU5fTVVU
RSwgQU1QX09VVF9NVVRFfSwKIAl7MHgxYSwgQUNfVkVSQl9TRVRfUElOX1dJREdFVF9DT05UUk9M
LCBQSU5fT1VUfSwKIAl7MHgxYSwgQUNfVkVSQl9TRVRfQU1QX0dBSU5fTVVURSwgQU1QX09VVF9V
Tk1VVEV9LAo=
------=_Part_10840_21465528.1205059029926
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_10840_21465528.1205059029926--
