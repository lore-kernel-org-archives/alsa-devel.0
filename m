From: Tom Prado <tprado@charter.net>
Subject: [PATCH] configure prob with MDK82 kernel
Date: Wed, 24 Apr 2002 14:35:44 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0204241426320.17011-200000@volamar.theswamp.priv>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811542-922903337-1019673153=:17011"
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

---1463811542-922903337-1019673153=:17011
Content-Type: TEXT/PLAIN; charset=US-ASCII

I had a problem running configure against the Linux Mandrake 8.2 UP 
kernel.  It would fail when trying to determine the kernel version.  This 
patch for rc1 adds the needed includes so that linux/rhconfig.h can be 
found when configure checks for the kernel version.

Tom


---1463811542-922903337-1019673153=:17011
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="alsa-driver-0.9.0rc1.fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0204241432330.17011@volamar.theswamp.priv>
Content-Description: 
Content-Disposition: attachment; filename="alsa-driver-0.9.0rc1.fix.patch"

LS0tIGFsc2EtZHJpdmVyLTAuOS4wcmMxL2NvbmZpZ3VyZS5pbglXZWQgQXBy
IDI0IDExOjI5OjU1IDIwMDINCisrKyBhbHNhLWRyaXZlci0wLjkuMHJjMS50
b20vY29uZmlndXJlLmluCVdlZCBBcHIgMjQgMTQ6MTY6MzEgMjAwMg0KQEAg
LTgyLDYgKzgyLDcgQEAgRU9GDQogICBleGl0IDENCiBmaQ0KIEFDX0NBQ0hF
X1ZBTChrYXZlcnNpb24sDQorQ0ZMQUdTPSIkQ0ZMQUdTIC1JJENPTkZJR19T
TkRfS0VSTkVMRElSL2luY2x1ZGUiDQogW0FDX1RSWV9SVU4oWw0KICNpbmNs
dWRlIDxzdGRpby5oPg0KICNpbmNsdWRlIDxjdHlwZS5oPg0K
---1463811542-922903337-1019673153=:17011--
