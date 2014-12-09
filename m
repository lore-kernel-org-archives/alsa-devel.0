From: Clemens Lang <clemens.lang@bmw-carit.de>
Subject: Possible GPL-licensed header included in alsa-lib
Date: Tue, 9 Dec 2014 18:49:17 +0100
Message-ID: <20141209174917.GC22300@ulm-bmuc496424.bmw-carit.de>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bmw-carit.de (mail.bmw-carit.de [62.245.222.98])
 by alsa0.perex.cz (Postfix) with ESMTP id 964F9261549
 for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2014 18:49:20 +0100 (CET)
Received: from exchange2010.bmw-carit.intra ([192.168.100.28]:15445
 helo=mail.bmw-carit.de)
 by mail.bmw-carit.de with esmtps (TLSv1:AES256-SHA:256) (Exim 4.76)
 (envelope-from <Clemens.Lang@bmw-carit.de>) id 1XyOuU-0003Gl-0U
 for alsa-devel@alsa-project.org; Tue, 09 Dec 2014 18:49:18 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I recently reviewed the alsa-lib 1.0.27.2 source code from a licensing
perspective to ensure compliant usage and distribution. It seems the
intention is for the libraries to be covered by LGPL.

I had a look at include/list.h, which seems to be licensed under
GPL-2.0. It does not have a license header or any other copyright
information, but it states it was taken from Linux 2.4.0:

include/list.h, line 5:
| This code was taken from the Linux 2.4.0 kernel. [jaroslav]

I'm not sure one could argue that the header was trivial, especially
since it does not only contain constants, structures and interface
definitions, but also implementations of inline functions.

I found one previous inquiry about a similar issue[1], but it does not
cover the include/list.h header.


Two questions:
 1. Have the copyright holders of the code in question agreed to
    re-license under a different, LGPL-preserving license and, if yes,
	is there some documentation about that?
 2. If the header is indeed covered by GPL-2.0, would you accept patches
    to replace it with a different implementation, e.g. Rusty Russell's
	MIT-licensed list from ccan[2]?


[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2011-March/038267.=
html
[2] http://ccodearchive.net/info/list.html


Thank you for your time,
Clemens Lang
-- =

BMW Car IT GmbH
Clemens Lang
Spezialist Entwicklung
Lise-Meitner-Stra=DFe 14
89081 Ulm

Mail: clemens.lang@bmw-carit.de
Web: http://www.bmw-carit.de
--------------------------------------------------------------------
BMW Car IT GmbH
Gesch=E4ftsf=FChrer: Michael W=FCrtenberger und Reinhard Stolle
Sitz und Registergericht: M=FCnchen HRB 134810
--------------------------------------------------------------------
