From: Tim Goetze <tim@quitte.de>
Subject: Re: ice1712 ctl oops (current cvs)
Date: Wed, 6 Nov 2002 01:42:29 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0211060140170.709-200000@summer.quitte>
References: <Pine.LNX.4.21.0211051816460.475-200000@summer.quitte>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2065863525-1036543349=:709"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natsmtp01.webmailer.de [192.67.198.81])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA20337
	for <alsa-devel@alsa-project.org>; Wed, 6 Nov 2002 01:43:37 +0100
Received: from localhost (A4594.pppool.de [213.6.69.148])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id BAA11061
	for <alsa-devel@alsa-project.org>; Wed, 6 Nov 2002 01:43:24 +0100 (MET)
Received: from localhost ([127.0.0.1] ident=tim)
	by localhost with esmtp (Exim 3.35 #1 (Debian))
	id 189EH7-0000cS-00
	for <alsa-devel@alsa-project.org>; Wed, 06 Nov 2002 01:42:29 +0100
In-Reply-To: <Pine.LNX.4.21.0211051816460.475-200000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-2065863525-1036543349=:709
Content-Type: TEXT/PLAIN; charset=US-ASCII

me wrote:

>updated alsa-cvs this afternoon; alsactl produces an oops when
>treating the ice1712 (audiophile). same for envy24control.

attached patch fixes the problem.

tim

--8323328-2065863525-1036543349=:709
Content-Type: TEXT/plain; name="ak4524.c.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0211060142290.709@summer.quitte>
Content-Description: 
Content-Disposition: attachment; filename="ak4524.c.diff"

SW5kZXg6IGFsc2Eta2VybmVsL3BjaS9pY2UxNzEyL2FrNDUyNC5jDQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3QvYWxzYS9h
bHNhLWtlcm5lbC9wY2kvaWNlMTcxMi9hazQ1MjQuYyx2DQpyZXRyaWV2aW5n
IHJldmlzaW9uIDEuMw0KZGlmZiAtdSAtcjEuMyBhazQ1MjQuYw0KLS0tIGFs
c2Eta2VybmVsL3BjaS9pY2UxNzEyL2FrNDUyNC5jCTEgTm92IDIwMDIgMTI6
MDA6NDkgLTAwMDAJMS4zDQorKysgYWxzYS1rZXJuZWwvcGNpL2ljZTE3MTIv
YWs0NTI0LmMJNiBOb3YgMjAwMiAwMDo0MDo0MyAtMDAwMA0KQEAgLTM0OSw2
ICszNDksNyBAQA0KIAkJCWJyZWFrOw0KIAkJfQ0KIAkJfQ0KKwkJY3RsLnBy
aXZhdGVfZGF0YSA9IGljZTsNCiAJCWlmICgoZXJyID0gc25kX2N0bF9hZGQo
aWNlLT5jYXJkLCBzbmRfY3RsX25ldygmY3RsKSkpIDwgMCkNCiAJCQlyZXR1
cm4gZXJyOw0KIAl9DQo=
--8323328-2065863525-1036543349=:709--


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
