From: "Ivica Bukvic" <ico@fuse.net>
Subject: Another question/note regarding CVS compile process
Date: Wed, 15 May 2002 18:43:57 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c1fc61$fffe07b0$ac1f830a@ico>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mta02.fuse.net (mx2.fuse.net [216.68.1.120])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA22346
	for <alsa-devel@alsa-project.org>; Thu, 16 May 2002 00:43:36 +0200
Received: from ico ([216.196.131.8]) by mta02.fuse.net
          (InterMail vM.5.01.03.01 201-253-122-118-101-20010319) with ESMTP
          id <20020515224329.DJTO981.mta02.fuse.net@ico>
          for <alsa-devel@alsa-project.org>;
          Wed, 15 May 2002 18:43:29 -0400
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

One more thing I noticed about my build process:

When I do ./build prep

I get the following response:

aclocal: ../alsa-lib/utils/alsa.m4: 15: duplicated macro 'AM_PATH_ALSA'

And then it seems to stop the ./build prep process since when I do the
same steps by hand and try to configure afterwards, I get the following
errors:

./configure: line 543: syntax error near unexpected token
'AM_CONDITIONAL(INSTALL_M4,'
./configure: line 543: 'AM_CONDITIONAL(INSTALL_M4, test "x$(ACLOCAL)" =
"xaclocal")'

This does not happen when I do a simple cvscompile in the alsa-driver
folder.

I do already have an entry in the /usr/share/aclocal/alsa.m4 which I do
not know whether it has anything to do with this but it seems when I
rename it it makes no difference.

But, what I just discovered this very moment is that when I remove the
alsa.m4 (or its renamed incarnation) from the /usr/share/aclocal, I do
not get these errors. Maybe this should be done automatically since
otherwise build script fails.

Ico




_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
