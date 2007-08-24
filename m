From: Trent Piepho <xyzzy@speakeasy.org>
Subject: [patch] kernel-sync
Date: Thu, 23 Aug 2007 21:05:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0708232056220.21981@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="289736052-1799541243-1187928308=:21981"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail6.sea5.speakeasy.net (mail6.sea5.speakeasy.net
	[69.17.117.8]) by alsa0.perex.cz (Postfix) with ESMTP id 3F6D124408
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Aug 2007 06:05:11 +0200 (CEST)
Received: from shell4.sea5.speakeasy.net ([69.17.116.5])
	(envelope-sender <xyzzy@speakeasy.org>)
	by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted
	SMTP for <alsa-devel@alsa-project.org>; 24 Aug 2007 04:05:08 -0000
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--289736052-1799541243-1187928308=:21981
Content-Type: TEXT/PLAIN; charset=US-ASCII

Here's patch for alsa-kernel to sync bt87x.c with the git kernel, from
commit cf784d554fdb94f21671830135dba56b507126cf

Or maybe process is to wait for 2.6.23 to be released, and then sync to
that?

I have some more patch to bt87x, but I'm waiting for this to appear in
alsa-kernel so I can base them off it.

--289736052-1799541243-1187928308=:21981
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="kernel-sync.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0708232105080.21981@shell4.speakeasy.net>
Content-Description: 
Content-Disposition: attachment; filename="kernel-sync.patch"

IyBIRyBjaGFuZ2VzZXQgcGF0Y2gNCiMgVXNlciBUcmVudCBQaWVwaG8gPHh5
enp5QHNwZWFrZWFzeS5vcmc+DQojIERhdGUgMTE4NzkyNzcyNSAyNTIwMA0K
IyBOb2RlIElEIGQ1ZDE2NWY5MjgwMjA2Y2IzODE3ZWI3ZWIzZjkwMjc3NWZm
NzkwY2YNCiMgUGFyZW50ICA0MDlkMzZjZGYzYjJiYzVhN2JkOWU0ZmM5NTBj
NWIzZDMxMGQ2ZDVhDQprZXJuZWwtc3luYw0KDQpkaWZmIC1yIDQwOWQzNmNk
ZjNiMiAtciBkNWQxNjVmOTI4MDIgcGNpL2J0ODd4LmMNCi0tLSBhL3BjaS9i
dDg3eC5jCVdlZCBBdWcgMjIgMDk6NDU6MDMgMjAwNyArMDIwMA0KKysrIGIv
cGNpL2J0ODd4LmMJVGh1IEF1ZyAyMyAyMDo1NToyNSAyMDA3IC0wNzAwDQpA
QCAtNzU0LDYgKzc1NCw4IEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2RldmljZV9p
ZCBzbmRfYnQ4N3hfaWQNCiAJQlRfREVWSUNFKFBDSV9ERVZJQ0VfSURfQlJP
T0tUUkVFXzg3OSwgMHgwMDcwLCAweDEzZWIsIDMyMDAwKSwNCiAJLyogVmll
d2Nhc3QgT3NwcmV5IDIwMCAqLw0KIAlCVF9ERVZJQ0UoUENJX0RFVklDRV9J
RF9CUk9PS1RSRUVfODc4LCAweDAwNzAsIDB4ZmYwMSwgNDQxMDApLA0KKwkv
KiBWaWV3Y2FzdCBPc3ByZXkgNDQwIChyYXRlIGlzIGNvbmZpZ3VyYWJsZSB2
aWEgZ3BpbykgKi8NCisJQlRfREVWSUNFKFBDSV9ERVZJQ0VfSURfQlJPT0tU
UkVFXzg3OCwgMHgwMDcwLCAweGZmMDcsIDMyMDAwKSwNCiAJLyogQVRJIFRW
LVdvbmRlciAqLw0KIAlCVF9ERVZJQ0UoUENJX0RFVklDRV9JRF9CUk9PS1RS
RUVfODc4LCAweDEwMDIsIDB4MDAwMSwgMzIwMDApLA0KIAkvKiBMZWFkdGVr
IFdpbmZhc3QgdHYgMjAwMHhwIGRlbHV4ICovDQo=

--289736052-1799541243-1187928308=:21981
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--289736052-1799541243-1187928308=:21981--
