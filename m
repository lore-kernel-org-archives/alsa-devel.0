From: Kenneth Crudup <kenny@panix.com>
Subject: Patch for Sony Vaio VGN-A790 laptop for Intel HDA on Realtek Codec
Date: Thu, 27 Apr 2006 21:32:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604272128100.15826@vaio.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463761026-2113583506-1146198722=:15826"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail3.panix.com (mail3.panix.com [166.84.1.74])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0149138
	for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2006 06:32:20 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: kailang@realtek.com.tw, pshou@realtek.com.tw, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463761026-2113583506-1146198722=:15826
Content-Type: TEXT/PLAIN; charset=US-ASCII


Please apply to the current kernel tree at your earliest convienience.

Thank you,

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Los Angeles
H: 3630 S. Sepulveda Blvd. #138, L.A., CA 90034-6809      (888) 454-8181
---1463761026-2113583506-1146198722=:15826
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=hda-sound-patch
Content-Transfer-Encoding: BASE64
Content-Description: realtek.c patch
Content-Disposition: attachment; filename=hda-sound-patch

LS0tIGxpbnV4LTIuNi4xNi4yL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRl
ay5jLm9yaWcJMjAwNi0wNC0wNyAwOTo1Njo0Ny4wMDAwMDAwMDAgLTA3MDAN
CisrKyBsaW51eC0yLjYuMTYuMi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0
ZWsuYwkyMDA2LTA0LTA5IDE5OjM1OjMwLjAwMDAwMDAwMCAtMDcwMA0KQEAg
LTI5NDgsNiArMjk0OCw4IEBADQogCXsgLm1vZGVsbmFtZSA9ICJiYXNpYyIs
IC5jb25maWcgPSBBTEMyNjBfQkFTSUMgfSwNCiAJeyAucGNpX3N1YnZlbmRv
ciA9IDB4MTA0ZCwgLnBjaV9zdWJkZXZpY2UgPSAweDgxYmIsDQogCSAgLmNv
bmZpZyA9IEFMQzI2MF9CQVNJQyB9LCAvKiBTb255IFZBSU8gKi8NCisJeyAu
cGNpX3N1YnZlbmRvciA9IDB4MTA0ZCwgLnBjaV9zdWJkZXZpY2UgPSAweDgx
Y2QsDQorCSAgLmNvbmZpZyA9IEFMQzI2MF9CQVNJQyB9LCAvKiBTb255IFZB
SU8gKi8NCiAJeyAucGNpX3N1YnZlbmRvciA9IDB4MTUyZCwgLnBjaV9zdWJk
ZXZpY2UgPSAweDA3MjksDQogCSAgLmNvbmZpZyA9IEFMQzI2MF9CQVNJQyB9
LCAvKiBDVEwgVHJhdmVsIE1hc3RlciBVNTUzVyAqLw0KIAl7IC5tb2RlbG5h
bWUgPSAiaHAiLCAuY29uZmlnID0gQUxDMjYwX0hQIH0sDQo=

---1463761026-2113583506-1146198722=:15826--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
