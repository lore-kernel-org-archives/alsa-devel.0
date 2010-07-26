From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Compiling alsa-utils
Date: Mon, 26 Jul 2010 10:58:09 +0200
Message-ID: <4C4D4E21.5030705@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id B6297246E3
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 10:58:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id 9811BA1786A04
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 10:58:09 +0200 (CEST)
Received: from cable.insite.cz ([127.0.0.1])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bixsDRc9eL2x for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 10:58:09 +0200 (CEST)
Received: from [192.168.1.20] (sara.insite.cz [192.168.1.20])
	by cable.insite.cz (Postfix) with ESMTP id 66D7DA1786A02
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 10:58:09 +0200 (CEST)
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

Hi,

after clean git clone of  git://git.alsa-project.org/alsa-utils.git I
got the following error:

pavel@sara:~/install/alsa/alsa-utils$ autoheader
configure.in:268: error: `po/Makefile.in' is already registered with
AC_CONFIG_FILES.
../../lib/autoconf/status.m4:311: AC_CONFIG_FILES is expanded from...
configure.in:268: the top level
autom4te: /usr/bin/m4 failed with exit status: 1
autoheader: '/usr/bin/autom4te' failed with exit status: 1


After deleting po/Makefile.in from the list of AC_OUTPUT in
configure.in:268 the compilation proceeded fine.

Ubuntu 9.10.

Thanks,

Pavel Hofman.
