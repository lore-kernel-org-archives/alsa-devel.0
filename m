From: Carlo Marcelo Arenas Belon <carenas@chasqui.lared.net.pe>
Subject: [PATCH] configure.in on alsa-utils should abort if no [n]curses
 library is found
Date: Mon, 17 Mar 2003 03:05:04 -0500 (PET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303170256150.3091-200000@chasqui.LaRed.net.pe>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="633865674-775517796-1047888304=:3091"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--633865674-775517796-1047888304=:3091
Content-Type: TEXT/PLAIN; charset=US-ASCII

Greetings,

while building the latest (0.9.1) alsa-utils on a recently installed Red
Hat Linux 8.0 desktop, i was getting fatal errors because i had no
ncurses-devel package installed (with headers and static libraries for
ncurses)

configure.in tests for both ncurses and curses but fails to abort if they 
are not found.  attached patch fixes configure.in for that (tested 
rebuilding configure with autoconf 2.53.8)

hope you find it usefull

Carlo

--633865674-775517796-1047888304=:3091
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="configure-curses-0.9.1.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0303170305040.3091@chasqui.LaRed.net.pe>
Content-Description: 
Content-Disposition: attachment; filename="configure-curses-0.9.1.patch"

LS0tIGFsc2EtdXRpbHMtMC45LjEvY29uZmlndXJlLmluLmN1cnNlcwkyMDAz
LTAzLTExIDE2OjExOjA0LjAwMDAwMDAwMCAtMDUwMA0KKysrIGFsc2EtdXRp
bHMtMC45LjEvY29uZmlndXJlLmluCTIwMDMtMDMtMTcgMDI6MzQ6MTIuMDAw
MDAwMDAwIC0wNTAwDQpAQCAtMTUsNyArMTUsOCBAQA0KIEFDX0NIRUNLX0xJ
QihuY3Vyc2VzLCBpbml0c2NyLCANCiAgICAgICAgICAgICAgWyBDVVJTRVNJ
TkM9JzxuY3Vyc2VzLmg+JzsgQ1VSU0VTTElCPSctbG5jdXJzZXMnOyBdLCBb
IA0KIAlBQ19DSEVDS19MSUIoY3Vyc2VzLCBpbml0c2NyLCANCi0gICAgICAg
IAkgICAgIFsgQ1VSU0VTSU5DPSc8Y3Vyc2VzLmg+JzsgQ1VSU0VTTElCPSct
bGN1cnNlcyc7IF0pDQorICAgICAgICAJICAgICBbIENVUlNFU0lOQz0nPGN1
cnNlcy5oPic7IENVUlNFU0xJQj0nLWxjdXJzZXMnOyBdLA0KKyAgICAgICAg
ICAgICAgICAgICAgIEFDX01TR19FUlJPUih0aGlzIHBhY2thZ2VzIHJlcXVp
cmVzIGEgY3Vyc2VzIGxpYnJhcnkpKQ0KIF0pDQogDQogQUNfU1VCU1QoQ1VS
U0VTSU5DKQ0K
--633865674-775517796-1047888304=:3091--


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
