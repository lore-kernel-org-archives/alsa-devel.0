From: Rui Sousa <rui.sousa@laposte.net>
Subject: [PATCH] via82xx
Date: Sun, 8 Sep 2002 17:16:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209081709320.1191-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1064160933-1031498204=:1191"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1064160933-1031498204=:1191
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

The attached patch is needed for the correct detection of VIA8233 
southbridges. Playback is still broken though (VIA8233, revision 0x30 in 
my case ), the card generates no interrupts and the playback buffer just 
gets filled up... Bellow is the (partial) output of my test application.

Rui Sousa

...

(SNDCTL_DSP_GETODELAY)
pending: 24512 ret: 0

(write)
count: 4096 ret: 1024

(SNDCTL_DSP_GETOPTR)
bytes: 64 blocks: 99 ptr: 64 ret: 0

(SNDCTL_DSP_GETOSPACE)
fragments: 0 fragstotal: 100 fragsize: 256 bytes: 64 ret: 0

(SNDCTL_DSP_GETODELAY)
pending: 25536 ret: 0

audio write: Input/output error
(write)
count: 4096 ret: -1

(SNDCTL_DSP_GETOPTR)
bytes: 64 blocks: 99 ptr: 64 ret: 0

(SNDCTL_DSP_GETOSPACE)
fragments: 0 fragstotal: 100 fragsize: 256 bytes: 64 ret: 0

(SNDCTL_DSP_GETODELAY)
pending: 25536 ret: 0

...

--8323328-1064160933-1031498204=:1191
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="via82xx.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0209081716440.1191@localhost.localdomain>
Content-Description: via82xx patch
Content-Disposition: attachment; filename="via82xx.patch"

PyB2aWE4Mnh4LnBhdGNoDQo/IGFsc2Etb3NzL2NvbmZkZWZzLmgNCkluZGV4
OiBhbHNhLWtlcm5lbC9wY2kvdmlhODJ4eC5jDQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3QvYWxzYS9hbHNhLWtlcm5lbC9w
Y2kvdmlhODJ4eC5jLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4xDQpkaWZm
IC11IC1yMS4xIHZpYTgyeHguYw0KLS0tIGFsc2Eta2VybmVsL3BjaS92aWE4
Mnh4LmMJNCBTZXAgMjAwMiAxNDoxNzo0NyAtMDAwMAkxLjENCisrKyBhbHNh
LWtlcm5lbC9wY2kvdmlhODJ4eC5jCTggU2VwIDIwMDIgMTU6MDk6NDQgLTAw
MDANCkBAIC0yOTUsOCArMjk1LDggQEANCiB9Ow0KIA0KIHN0YXRpYyBzdHJ1
Y3QgcGNpX2RldmljZV9pZCBzbmRfdmlhODJ4eF9pZHNbXSBfX2RldmluaXRk
YXRhID0gew0KLQl7IDB4MTEwNiwgMHgzMDU4LCBQQ0lfQU5ZX0lELCBQQ0lf
QU5ZX0lELCAwLCAwLCAwLCB9LAkvKiA2ODZBICovDQotCXsgMHgxMTA2LCAw
eDMwNTksIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIDAsIH0sCS8q
IFZUODIzMyAqLw0KKwl7IDB4MTEwNiwgMHgzMDU4LCBQQ0lfQU5ZX0lELCBQ
Q0lfQU5ZX0lELCAwLCAwLCBUWVBFX1ZJQTY4NiwgfSwJLyogNjg2QSAqLw0K
Kwl7IDB4MTEwNiwgMHgzMDU5LCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAw
LCAwLCBUWVBFX1ZJQTgyMzMsIH0sCS8qIFZUODIzMyAqLw0KIAl7IDAsIH0N
CiB9Ow0KIA0K
--8323328-1064160933-1031498204=:1191--


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
