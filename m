From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] conf.c: parsing floating point numbers
Date: Tue, 02 Jul 2002 10:52:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2169B3.FA0D9F45@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA22164
	for <alsa-devel@alsa-project.org>; Tue, 2 Jul 2002 10:52:10 +0200
Received: from mserv1.urz.uni-halle.de ([141.48.3.145] helo=mserv1)
	  by mailgate.uni-halle.de with esmtp (EXIM Version 3.35)
	  for <alsa-devel@alsa-project.org>
	  id 17PJOK-00000b-00; Tue, 02 Jul 2002 10:52:08 +0200
Received: from conversion-daemon.mail.uni-halle.de by mail.uni-halle.de
 (iPlanet Messaging Server 5.2 (built Feb 21 2002))
 id <0GYM00C015M1LH@mail.uni-halle.de> for alsa-devel@alsa-project.org; Tue,
 02 Jul 2002 10:52:07 +0200 (MEST)
Received: from studcom.urz.uni-halle.de
 (studcom.urz.Uni-Halle.DE [141.48.3.19]) by mail.uni-halle.de
 (iPlanet Messaging Server 5.2 (built Feb 21 2002))
 with ESMTP id <0GYM006E75YVD9@mail.uni-halle.de> for
 alsa-devel@alsa-project.org; Tue, 02 Jul 2002 10:52:07 +0200 (MEST)
Received: from ladisch.de (ifiu23.informatik.Uni-Halle.DE [141.48.14.23])
	by studcom.urz.uni-halle.de (8.9.3 (PHNE_22672)/8.9.3)
 with ESMTP id KAA20444	for <alsa-devel@alsa-project.org>; Tue,
 02 Jul 2002 10:52:07 +0200 (METDST)
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

When parse_value finds something looking like a number, it first calls
safe_strtoll to test whether the value's type is integer.
Unfortunately, safe_strtoll simply grabs anything which may be an
integer, and doesn't check for any following characters (e.g. the
decimal point of a floating point number).

This means that all floating point numbers are parsed as integers.

The patch adds a check for the end of the string, similar to
safe_strtol and safe_strtod.


--- alsa-lib/src/conf.c.org     Tue Jul  2 00:39:34 2002
+++ alsa-lib/src/conf.c Tue Jul  2 00:52:22 2002
@@ -463,11 +463,14 @@
 int safe_strtoll(const char *str, long long *val)
 {
        long long v;
+       int endidx;
        if (!*str)
                return -EINVAL;
        errno = 0;
-       if (sscanf(str, "%Ld", &v) != 1)
+       if (sscanf(str, "%Ld%n", &v, &endidx) < 1)
                return -EINVAL;
+       if (str[endidx])
+               return -EINVAL;
        *val = v;
        return 0;
 }


Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
