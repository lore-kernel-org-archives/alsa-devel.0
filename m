From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [PATCH] cs46xx, just a merge miss in current CVS
Date: Wed, 28 Aug 2002 08:30:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D6C6E06.4020006@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090105030806020607050506"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA31595
	for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2002 08:29:29 +0200
Received: from cucumelo.org (cactus [194.236.61.89])
	by cucumelo.org (Postfix) with ESMTP id 2FF5D2EE05
	for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2002 08:30:31 +0200 (CEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090105030806020607050506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I've just found a miss in current CVS, I guess happened with prev. merge.

This patch is short and includes:
-  Added missed init_MUTEX( ... ) in cs46xx_lib.c

/Benny


--------------090105030806020607050506
Content-Type: application/x-java-vm;
 name="cs46xx_patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cs46xx_patch"

ZGlmZiAtTmF1ciAtLWV4Y2x1ZGU9RW50cmllcyAtLWV4Y2x1ZGU9TWFrZWZpbGUgLi4vY3Zz
X3JlZi9hbHNhLWtlcm5lbC9wY2kvY3M0Nnh4L2NzNDZ4eF9saWIuYyBhbHNhLWtlcm5lbC9w
Y2kvY3M0Nnh4L2NzNDZ4eF9saWIuYwotLS0gLi4vY3ZzX3JlZi9hbHNhLWtlcm5lbC9wY2kv
Y3M0Nnh4L2NzNDZ4eF9saWIuYwlUdWUgQXVnIDI3IDIxOjA1OjE0IDIwMDIKKysrIGFsc2Et
a2VybmVsL3BjaS9jczQ2eHgvY3M0Nnh4X2xpYi5jCVdlZCBBdWcgMjggMDg6MjM6MDAgMjAw
MgpAQCAtMzIzOSw2ICszMjM5LDkgQEAKIAlpZiAoY2hpcCA9PSBOVUxMKQogCQlyZXR1cm4g
LUVOT01FTTsKIAlzcGluX2xvY2tfaW5pdCgmY2hpcC0+cmVnX2xvY2spOworI2lmZGVmIENP
TkZJR19TTkRfQ1M0NlhYX05FV19EU1AKKyAgICBpbml0X01VVEVYKCZjaGlwLT5zcG9zX211
dGV4KTsKKyNlbmRpZgogCWNoaXAtPmNhcmQgPSBjYXJkOwogCWNoaXAtPnBjaSA9IHBjaTsK
IAljaGlwLT5jYXB0Lmh3X3NpemUgPSBQQUdFX1NJWkU7Cg==
--------------090105030806020607050506--



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
