From: Rene Herman <rene.herman@keyaccess.nl>
Subject: snd-es1968 (+ snd-cs4236) trouble
Date: Sat, 10 Dec 2005 21:13:20 +0100
Message-ID: <439B36E0.3090709@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050006090300080703050301"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl [213.51.146.201])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8798C16F
	for <alsa-devel@alsa-project.org>; Sat, 10 Dec 2005 21:09:51 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050006090300080703050301
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

I have two soundcards in my machine; a snd-cs46xx card and a snd-cs4236 
card, which has always worked nicely. Today though I tried swapping the 
snd-cs46xx one for a snd-es1968 one, and this does not work.

The second I modprobe snd-es1968, snd-cs4236 stops working. If I'm 
listening to snd-cs4236 at the time I get the last second or so repeated 
over and over again. Killing the app that was playing via kill -9 works 
and stops the repeating sound but does not repair things: when I try to 
use snd-cs4236 again after that, it's still the same -- I only get the 
first second or so repeated over and over.

ALSA code is kernel 2.6.14.3 (1.0.10rc1). I just now tried checking 
standalone ALSA 1.0.10, but unfortunately its snd-cs4236 won't load at 
all. The machine oopses on "modprobe snd-cs4236" with the attached 
backtrace.

That last one seems a problem in snd-cs4236, but the earlier problem is 
likely in snd-es1968 -- as said, snd-cs4236 + snd-cs46xx work fine 
together. Moreover, I could swear earlier snd-cs46xx crashed in the same 
way as snd-cs4236 does when inserting snd-es1968, although I can't seem 
to reproduce this right now.

Thanks in advance for any probing...

Rene.




--------------050006090300080703050301
Content-Type: text/plain;
 name="cs4236-1.0.10.oops"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cs4236-1.0.10.oops"

cG5wOiB0aGUgZHJpdmVyICdjczQyM3gnIGhhcyBiZWVuIHJlZ2lzdGVyZWQKcG5wOiBtYXRj
aCBmb3VuZCB3aXRoIHRoZSBQblAgZGV2aWNlICcwMTowMS4wMCcgYW5kIHRoZSBkcml2ZXIg
J2NzNDIzeCcKcG5wOiBtYXRjaCBmb3VuZCB3aXRoIHRoZSBQblAgZGV2aWNlICcwMTowMS4w
MicgYW5kIHRoZSBkcml2ZXIgJ2NzNDIzeCcKcG5wOiBtYXRjaCBmb3VuZCB3aXRoIHRoZSBQ
blAgZGV2aWNlICcwMTowMS4wMycgYW5kIHRoZSBkcml2ZXIgJ2NzNDIzeCcKcG5wOiBEZXZp
Y2UgMDE6MDEuMDAgYWN0aXZhdGVkLgpwbnA6IERldmljZSAwMTowMS4wMiBhY3RpdmF0ZWQu
CnBucDogRGV2aWNlIDAxOjAxLjAzIGFjdGl2YXRlZC4KVW5hYmxlIHRvIGhhbmRsZSBrZXJu
ZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAw
MAogcHJpbnRpbmcgZWlwOgowMDAwMDAwMAoqcGRlID0gMDAwMDAwMDAKT29wczogMDAwMCBb
IzFdClBSRUVNUFQgCk1vZHVsZXMgbGlua2VkIGluOiBzbmRfY3M0MjM2IHNuZF9vcGwzX2xp
YiBzbmRfaHdkZXAgc25kX2NzNDIzNl9saWIgc25kX21wdTQwMV91YXJ0IHNuZF9yYXdtaWRp
IHNuZF9zZXFfZGV2aWNlIHNuZF9jczQyMzFfbGliIHNuZF9wY20gc25kX3RpbWVyIHNuZCBz
b3VuZGNvcmUgc25kX3BhZ2VfYWxsb2MgbmZzZCBleHBvcnRmcyBsb2NrZCBzdW5ycGMgbmxz
X2lzbzg4NTlfMSBubHNfY3A0MzcgdmZhdCBmYXQgbmxzX2Jhc2UKQ1BVOiAgICAwCkVJUDog
ICAgMDA2MDpbPDAwMDAwMDAwPl0gICAgTm90IHRhaW50ZWQgVkxJCkVGTEFHUzogMDAwMTAy
ODYgICAoMi42LjE0LjMtbG9jYWwtd2MpIApFSVAgaXMgYXQgMHgwCmVheDogZWYyZGFhMTQg
ICBlYng6IGVmMmRhYTFjICAgZWN4OiAwMDAwMDAwOCAgIGVkeDogZjA5NGE0OTQKZXNpOiAw
MDAwMDAwMCAgIGVkaTogZjA5NGE0OTQgICBlYnA6IGMwMWIzMGU4ICAgZXNwOiBlZThjMmUz
YwpkczogMDA3YiAgIGVzOiAwMDdiICAgc3M6IDAwNjgKUHJvY2VzcyBtb2Rwcm9iZSAocGlk
OiAxNTE2LCB0aHJlYWRpbmZvPWVlOGMyMDAwIHRhc2s9ZWYxMTNhOTApClN0YWNrOiBmMDkz
ZjAwYyBjMDFiMzA5NyBlZThjMmU1NCAwMDAwMDAwMCBlZjJkYWExYyBjMDFiMmE3NSBjMDI5
OTQ1OCBjMDI5OTQ1OCAKICAgICAgIGYwOTRhNGVjIGMwMTZkNjc2IGVmMmRhYTFjIGVmMmRh
YTFjIGMwMjk5MzYwIDAwMDAwMDAwIGMwMWIzMTI3IGMwMWIzMGU4IAogICAgICAgZWYyZGFh
ODQgYzAxYjJiNzcgZWYyZGFhODQgZWYyZGFhMWMgZWYyZGFhYzYgMDAwMDAwMDAgYzAxYjIw
MjIgYzAyOTkyNDAgCkNhbGwgVHJhY2U6CiBbPGYwOTNmMDBjPl0gc25kX3BsYXRmb3JtX2Ry
aXZlcl9wcm9iZSsweGMvMHhkIFtzbmRdCiBbPGMwMWIzMDk3Pl0gZHJpdmVyX3Byb2JlX2Rl
dmljZSsweDMxLzB4ODIKIFs8YzAxYjJhNzU+XSBidXNfZm9yX2VhY2hfZHJ2KzB4MzUvMHg1
OQogWzxjMDE2ZDY3Nj5dIGNyZWF0ZV9maWxlcysweDI3LzB4NTEKIFs8YzAxYjMxMjc+XSBk
ZXZpY2VfYXR0YWNoKzB4M2EvMHg0ZAogWzxjMDFiMzBlOD5dIF9fZGV2aWNlX2F0dGFjaCsw
eDAvMHg1CiBbPGMwMWIyYjc3Pl0gYnVzX2FkZF9kZXZpY2UrMHgyMC8weDZmCiBbPGMwMWIy
MDIyPl0gZGV2aWNlX2FkZCsweDk3LzB4ZjgKIFs8YzAxYjQxZDk+XSBwbGF0Zm9ybV9kZXZp
Y2VfcmVnaXN0ZXIrMHhiNS8weDEwMwogWzxmMDhmNzk5NT5dIHNuZF9jczQyMzFfcG1fc3Vz
cGVuZCsweDAvMHgxNSBbc25kX2NzNDIzMV9saWJdCiBbPGYwOTQwNGIyPl0gc25kX2dlbmVy
aWNfZGV2aWNlX3JlZ2lzdGVyKzB4NjQvMHg4MSBbc25kXQogWzxmMDhmNzlhYT5dIHNuZF9j
czQyMzFfcG1fcmVzdW1lKzB4MC8weDE1IFtzbmRfY3M0MjMxX2xpYl0KIFs8ZjA5NDA2ODI+
XSBzbmRfY2FyZF9zZXRfZ2VuZXJpY19wbV9jYWxsYmFjaysweDEzLzB4MmYgW3NuZF0KIFs8
ZjA4ZjdlNjM+XSBzbmRfY3M0MjMxX2NyZWF0ZSsweDI4YS8weDI5ZSBbc25kX2NzNDIzMV9s
aWJdCiBbPGYwOTU5M2EyPl0gc25kX2NzNDIzNl9jcmVhdGUrMHg3MC8weDJiMSBbc25kX2Nz
NDIzNl9saWJdCiBbPGYwOTc4NGU2Pl0gc25kX2NhcmRfY3M0MjN4X3Byb2JlKzB4MTRjLzB4
MzBjIFtzbmRfY3M0MjM2XQogWzxmMDk3ODZkMD5dIHNuZF9jczQyM3hfcG5wX2RldGVjdCsw
eDJhLzB4NGMgW3NuZF9jczQyMzZdCiBbPGMwMTkyZTM5Pl0gY2FyZF9wcm9iZSsweDNiLzB4
ODUKIFs8YzAxOTMzZjA+XSBwbnBfcmVnaXN0ZXJfY2FyZF9kcml2ZXIrMHg3YS8weDg2CiBb
PGYwOGUxMDNkPl0gYWxzYV9jYXJkX2NzNDIzeF9pbml0KzB4M2QvMHg2MiBbc25kX2NzNDIz
Nl0KIFs8YzAxMjZlNTk+XSBzeXNfaW5pdF9tb2R1bGUrMHhhZS8weDFhNQogWzxjMDEwMjRk
MT5dIHN5c2NhbGxfY2FsbCsweDcvMHhiCkNvZGU6ICBCYWQgRUlQIHZhbHVlLgo=
--------------050006090300080703050301--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
