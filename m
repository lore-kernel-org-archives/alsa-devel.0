From: Rene Rebe <rene.rebe@gmx.net>
Subject: [PATCH] alsa-oss
Date: Sun, 24 Mar 2002 02:25:20 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020324.022520.576041789.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Received: from drocklinux.dyndns.org (port-213-20-128-75.reverse.qdsl-home.de [213.20.128.75])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA02975
	for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2002 02:26:24 +0100
Received: from localhost ([127.0.0.1])
	by drocklinux.dyndns.org with esmtp (Exim 3.33 #1)
	id 16owla-0005LJ-00
	for alsa-devel@alsa-project.org; Sun, 24 Mar 2002 02:25:50 +0100
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

Hi. No real patch - only the desc to fix it ;-)

The alsa-oss package includes sym-links to install-sh, missing, and
mkinstalldirs. So the package is not buildable on automake-1.6 systems
- where this linkes needs to be replaces by new linkes or the content
of the files. So it would be nice if the next release includes real
files likes alsa-libs does ;-)

k33p h4ck1n6
  Ren=E9

--  =

Ren=E9 Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
