From: =?utf-8?B?56mN5Li55bC8?= Dan Jacobson <jidanni@jidanni.org>
Subject: speaker-test man page should mention the proper way to
	exit
Date: Thu, 10 Aug 2017 15:43:51 +0800
Message-ID: <87shgz27go.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a99.g.dreamhost.com (homie.mail.dreamhost.com
 [208.97.132.208])
 by alsa0.perex.cz (Postfix) with ESMTP id E3E23267471
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 09:43:56 +0200 (CEST)
Received: from homiemail-a99.g.dreamhost.com (localhost [127.0.0.1])
 by homiemail-a99.g.dreamhost.com (Postfix) with ESMTP id 28E4FD3E067
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 00:43:55 -0700 (PDT)
Received: from jidanni.org (114-26-46-122.dynamic-ip.hinet.net [114.26.46.122])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: jidanni@jidanni.org)
 by homiemail-a99.g.dreamhost.com (Postfix) with ESMTPSA id DC3DED3E064
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 00:43:54 -0700 (PDT)
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

The speaker-test man page should mention the proper way to exit
speaker-test.

^C gives

Write error: -4,Interrupted system call
xrun_recovery failed: -4,Interrupted system call
Transfer failed: Interrupted system call

except when run with -c 2.

See also https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=802935
