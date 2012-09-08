From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Remove ignore_misc_bit
Date: Sat, 8 Sep 2012 09:10:14 +0800
Message-ID: <CAN8cciYZBU+LaaQFXrn9kPoFc=MdYahw0ucKNmAhrG=CT0+C5g@mail.gmail.com>
References: <1346995544-6754-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 7940F2616CC
 for <alsa-devel@alsa-project.org>; Sat,  8 Sep 2012 03:10:15 +0200 (CEST)
Received: by qadz3 with SMTP id z3so66377qad.17
 for <alsa-devel@alsa-project.org>; Fri, 07 Sep 2012 18:10:14 -0700 (PDT)
In-Reply-To: <1346995544-6754-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, 939161@bugs.launchpad.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

MjAxMi05LTcg5LiL5Y2IMToyNiDmlrwgIkRhdmlkIEhlbm5pbmdzc29uIiA8ZGF2aWQuaGVubmlu
Z3Nzb25AY2Fub25pY2FsLmNvbT4g5a+r6YGT77yaCj4KPiBUaGUgcHVycG9zZSBvZiB0aGlzIGZs
YWcgaXMgdW5jbGVhci4gSWYgdGhlIHByb2JsZW0gaXMgdGhhdCBzb21lIG1hY2hpbmVzCj4gaGF2
ZSBicm9rZW4gbWlzYy9OT19QUkVTRU5DRSBiaXRzLCB0aGV5IHNob3VsZCBiZSBmaXhlZCBieSBw
aW4gZml4dXBzLgo+Cj4gSW4gYWRkaXRpb24sIHRoaXMgY2F1c2VzIGphY2sgZGV0ZWN0aW9uIGZ1
bmN0aW9uYWxpdHkgdG8gYmUgZmxhd2VkIG9uCj4gdGhlIE0zMUVJLCB3aGVyZSB0aGVyZSBhcmUg
dHdvIGphY2tzIHdpdGhvdXQgamFjayBkZXRlY3Rpb24gKHdoaWNoIGlzCj4gcHJvcGVybHkgbWFy
a2VkIGFzIE5PX1BSRVNFTkNFKSwgYnV0IGR1ZSB0byBpZ25vcmVfbWlzY19iaXQsIHRoZXNlCj4g
amFja3MgYXJlIGluc3RlYWQgYmVpbmcgcmVwb3J0ZWQgYXMgYmVpbmcgcHJlc2VudCBidXQgYWx3
YXlzIHVucGx1Z2dlZC4KPgo+IEJ1Z0xpbms6IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L2J1
Z3MvOTM5MTYxCgpkbyB5b3UgbWVhbiB0aGUgY29tbWl0IGRvZXMgbm90IGZpeCB0aGUgYnVnPwoK
QUxTQTogaGRhIC0gYWRkIHN1cHBvcnQgZm9yIFVuaXdpbGwgRUNTIE0zMUVJIG5vdGVib29rCgpU
aGlzIGhhcmR3YXJlIHJlcXVpcmVzIHNhbWUgZml4dXAgZm9yIHRoZSBub2RlIDB4MGYgbGlrZSBB
c3VzIEE2UnAuCk1vcmUgaW5mb3JtYXRpb246IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9z
aG93X2J1Zy5jZ2k/aWQ9Nzg1NDE3CgpodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvP3A9bGludXgva2Vy
bmVsL2dpdC90aXdhaS9zb3VuZC5naXQ7YT1jb21taXQ7aD00MTY4NDZkMmIzMWZjNzQwZWQ5ZDVh
NWVjMTE2OTY0ZmI0M2M0MzU4Cgp0aGUgcmVhbCBjYXNlcyBhcmUgdGhvc2UgZGVza3RvcCB3aGlj
aCBkb2VzIG5vdCB1c2UgaGRhIGZyb250IGF1ZGlvIHBhbmVsICwKdGhleSBqdXN0IGxvc3MgdGhl
IGF1dG8gbXV0ZSBzaW5jZSB0aGVyZSBpcyBubyBqYWNrIGRldGVjdCBjaXJjdWl0IGJ1dCB0aGV5
CmNhbiBzdGlsbCBoZWFyIHNvdW5kIGZyb20gdGhlIGhlYWRwaG9uZSBhdCBhbnl0aW1lCgpkbyBw
dWxzZWF1ZGlvIG5lZWQgYSBwaGFudG9tIHBvcnQgZm9yIHRoZSBmcm9udCBwYW5lbCBoZWFkcGhv
bmUgYW5kIG1pYwp3aXRob3V0IGphY2sgZGV0ZWN0aW9uID8KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
