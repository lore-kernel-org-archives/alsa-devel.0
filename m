From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: snd_pcm_delay, hw buffers and driver api (v2)
Date: Sat, 15 Aug 2009 02:27:56 +0300 (EEST)
Message-ID: <alpine.DEB.1.10.0908150102500.3417@ecabase.localdomain>
References: <alpine.DEB.1.10.0908140023240.3417@ecabase.localdomain>
	<4A8554CC.2060009@ladisch.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463811582-707853315-1250291550=:3417"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw02.mail.saunalahti.fi (gw02.mail.saunalahti.fi
	[195.197.172.116])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D0DC2448B
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Aug 2009 01:27:39 +0200 (CEST)
In-Reply-To: <4A8554CC.2060009@ladisch.de>
Content-ID: <alpine.DEB.1.10.0908150213590.3417@ecabase.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811582-707853315-1250291550=:3417
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <alpine.DEB.1.10.0908150213591.3417@ecabase.localdomain>

Hi,

On Fri, 14 Aug 2009, Clemens Ladisch wrote:

> snd_pcm_delay() returns the filled part of the buffer plus
> the additional delay imposed by the device.
[...]
> The additional delay can be set by the driver in
> pcm_substream->runtime->delay.  (Currently, only
> the USB audio driver bothers to set this.)

aa, now that's interesting, and I think that's just the missing piece I'm 
looking for. I was looking at the 2.6.30.4 kernel, and couldn't find any 
traces of 'runtime->delay', but oh yes, 2.6.31 tree indeed has
it - yay! :)

It would seem this was added by Takashi with commit "ALSA: Add extra delay 
count in PCM" on 2009-05-05, so no wonder not too many drivers set it yet.

Hmm, but isn't it so that this extra delay is added properly to 
snd_pcm_delay() result, when 'sync_ptr_ioctl==false' property is set for 
the pcm (i.e. use SYNC_PTR ioctl instead of mmap control structures). 
Attached is an alsa-lib patch attempting to fix this (as sufficient info 
is not available in the mmap control block, always go via IOCTL_DELAY).

But otherwise this does look good and is just what I was looking for. When 
using snd_pcm_status(), application can get all the information (avail, 
delay) in one go. Of course one limitation is that the runtime->delay 
updates are synced to driver events, not to application calling 
snd_pcm_delay (unlike query of hw_ptr status via pointer driver callback), 
but maybe this is not even needed in the end. Have to think about this 
some more...

Thanks Clemens, James and Mark for the quick replies!
---1463811582-707853315-1250291550=:3417
Content-Type: TEXT/X-DIFF; NAME=patch-alsalib-pcmhw-always-use-ioctl-delay.diff
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.1.10.0908150212300.3417@ecabase.localdomain>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=patch-alsalib-pcmhw-always-use-ioctl-delay.diff

Y29tbWl0IGZjOThlYzJlNjMxYTZhZmE4NWU3NTA1YmM1NTM4MjRkN2Y2ZjU2
Y2MNCkF1dGhvcjogS2FpIFZlaG1hbmVuIDxrdmVobWFuZW5AZWNhLmN4Pg0K
RGF0ZTogICBTYXQgQXVnIDE1IDAyOjA1OjAyIDIwMDkgKzAzMDANCg0KICAg
IHBjbV9odzogQWx3YXlzIHVzZSBTTkRSVl9QQ01fSU9DVExfREVMQVkNCiAg
ICANCiAgICBBcyB0aGUga2VybmVsIGRyaXZlcnMgbWF5IGFkanVzdCB0aGUg
ZGVsYXkgd2l0aCAncnVudGltZS0+ZGVsYXknLA0KICAgIHRoZSBTTkRSVl9Q
Q01fSU9DVExfREVMQVkgaW9jdGwgbXVzdCBiZSBhbHdheXMgdXNlZCB3aGVu
DQogICAgY2FsY3VsYXRpbmcgdGhlIHNuZF9wY21fZGVsYXkgcmVzdWx0Lg0K
DQpkaWZmIC0tZ2l0IGEvc3JjL3BjbS9wY21faHcuYyBiL3NyYy9wY20vcGNt
X2h3LmMNCmluZGV4IGM0NmQxNGYuLjQ0OTEwOTkgMTAwNjQ0DQotLS0gYS9z
cmMvcGNtL3BjbV9ody5jDQorKysgYi9zcmMvcGNtL3BjbV9ody5jDQpAQCAt
NTIzLDExICs1MjMsNiBAQCBzdGF0aWMgaW50IHNuZF9wY21faHdfZGVsYXko
c25kX3BjbV90ICpwY20sIHNuZF9wY21fc2ZyYW1lc190ICpkZWxheXApDQog
CQlkZWZhdWx0Og0KIAkJCXJldHVybiAtRUJBREZEOw0KIAkJfQ0KLQkJaWYg
KHBjbS0+c3RyZWFtID09IFNORF9QQ01fU1RSRUFNX1BMQVlCQUNLKQ0KLQkJ
CSpkZWxheXAgPSBzbmRfcGNtX21tYXBfcGxheWJhY2tfaHdfYXZhaWwocGNt
KTsNCi0JCWVsc2UNCi0JCQkqZGVsYXlwID0gc25kX3BjbV9tbWFwX2NhcHR1
cmVfYXZhaWwocGNtKTsNCi0JCXJldHVybiAwOw0KIAl9DQogCWlmIChpb2N0
bChmZCwgU05EUlZfUENNX0lPQ1RMX0RFTEFZLCBkZWxheXApIDwgMCkgew0K
IAkJZXJyID0gLWVycm5vOw0K

---1463811582-707853315-1250291550=:3417
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

---1463811582-707853315-1250291550=:3417--
