From: Anton Khirnov <anton@khirnov.net>
Subject: a52: update to new libavcodec API
Date: Sun, 11 Nov 2012 11:30:00 +0100
Message-ID: <1352629804-19880-1-git-send-email-anton@khirnov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lain.khirnov.net (lain.khirnov.net [176.97.15.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BC8C2615B9
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 11:30:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by lain.khirnov.net (Postfix) with ESMTP id 6D48FC16D2
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 11:30:13 +0100 (CET)
Received: from lain.khirnov.net ([127.0.0.1])
 by localhost (mail.khirnov.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vV0iRmJ028vJ for <alsa-devel@alsa-project.org>;
 Sun, 11 Nov 2012 11:30:10 +0100 (CET)
Received: from daenerys.khirnov.net (daenerys.khirnov.net
 [IPv6:2002:b061:f0a:2:bc67:f85b:493c:acab])
 by lain.khirnov.net (Postfix) with ESMTP id 8D63CC1587
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 11:30:10 +0100 (CET)
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
this patchset updates the a52 plugin to work with the upcoming Libav 9
release. In doing that, it drops support for pre-0.8 libavcodec
versions. I think it is not unreasonable to demand at least a year old
libavcodec to compile latest git of alsa-plugins and keeping
compatibility with the old audio encoding API would result in ugly
#ifdefery mess.

The plugin compiles and appears to work, but as I have no SPDIF
receiver, I cannot properly test it. I would very much appreciate it if
someone else could do that.

Please comment.

-- 
Anton Khirnov
