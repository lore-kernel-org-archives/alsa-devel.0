From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: current cvs compile error
Date: 06 Feb 2003 15:38:01 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1044574681.5056.98.camel@cmn37.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA13124
	for <alsa-devel@alsa-project.org>; Fri, 7 Feb 2003 00:38:36 +0100
Received: from cmn37.stanford.edu (cmn37.stanford.edu [171.64.197.186])
	by cm-mail.stanford.edu (8.11.6/8.11.6) with ESMTP id h16Nc1C02132
	for <alsa-devel@alsa-project.org>; Thu, 6 Feb 2003 15:38:01 -0800
Received: from localhost (localhost [127.0.0.1])
	by cmn37.stanford.edu (8.11.6/8.11.6) with ESMTP id h16Nc1E12993
	for <alsa-devel@alsa-project.org>; Thu, 6 Feb 2003 15:38:01 -0800
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

I _think_ this is the fix, please check (the error is "undeclared
variable ctl")...

--- alsa-kernel/core/timer.c~	2003-02-06 11:21:11.000000000 -0800
+++ alsa-kernel/core/timer.c	2003-02-06 15:19:26.000000000 -0800
@@ -953,7 +953,7 @@
 	}
 	spin_unlock(&tu->qlock);
 	if (_wake) {
-		kill_fasync(&ctl->fasync, SIGIO, POLL_IN);
+		kill_fasync(&tu->fasync, SIGIO, POLL_IN);
 		wake_up(&tu->qchange_sleep);
 	}
 }

-- Fernando




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
