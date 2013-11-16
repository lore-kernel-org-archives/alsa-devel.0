From: Andrey Mazo <mazo@telum.ru>
Subject: alsa-lib changes in pcm file plugin
Date: Sun, 17 Nov 2013 01:11:53 +0400
Message-ID: <1384636316-26706-1-git-send-email-mazo@telum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.telum.ru (mail.telum.ru [62.141.76.179])
 by alsa0.perex.cz (Postfix) with ESMTP id AA1502610A1
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2013 22:12:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.telum.ru (Postfix) with ESMTP id 8F95F481154
 for <alsa-devel@alsa-project.org>; Sun, 17 Nov 2013 01:12:39 +0400 (MSK)
Received: from mail.telum.ru ([127.0.0.1])
 by localhost (mail.telum.ru [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 2vLdosXMGD5i for <alsa-devel@alsa-project.org>;
 Sun, 17 Nov 2013 01:12:38 +0400 (MSK)
Received: from hippo.telum.ru (hippo.telum.ru [192.168.0.14])
 by mail.telum.ru (Postfix) with ESMTPSA id 02BCE480185
 for <alsa-devel@alsa-project.org>; Sun, 17 Nov 2013 01:12:38 +0400 (MSK)
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

This short patch series contains three independent changes in pcm file plugin.
The first two of them are trivial fixes and should not cause any behavior changes and regressions.
The third one contains changes to make pcm_file.c access input/output files only when needed and thus to make its behavior more intuitive (from my point of view) (i.e., write to output file only on playback and read from input file only on capture).

The patches should apply cleanly against current HEAD (ae035b7fe5620fcaf4f5ea33ecabcf93b8e056cd).
