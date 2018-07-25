From: Jamey Kirby <kirby.jamey@gmail.com>
Subject: Building alsa-utils, adding changes
Date: Wed, 25 Jul 2018 00:28:10 -0400
Message-ID: <CAJze_PuWQCa1wAOjHbVgn=s4wDt4ixtUAhvPR1i-6VWwvD+xKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 516522676D4
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 06:28:22 +0200 (CEST)
Received: by mail-lf1-f42.google.com with SMTP id n96-v6so4463274lfi.1
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 21:28:22 -0700 (PDT)
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

I have been working with alsa for a while. We use it to archive content
from our radio station. I am using arecord.

Build problem:

1) I cloned alsa-utils from github
2) Spent two hours on Google trying to figure out how to build the darn
thing.
3) I am running Ubuntu Server 18.0 with build-essentials installed.
4) I get errors that I do not know how to fix when I try to setup
./configure.
5) I just need to make a build. What do I need to do?

Feature:

I am adding a feature. In the loop for capture(), when a new file is
opened, I want to close the old file (when doing continuous recording). I
added a new CLI parameter -K. When this is set, the capture() loop will
close the old file before opening the new file.

This is an issue for me for two reasons:

1) When will i run out of file handles? I capture one hour files
continuously. After 10 hours, I see that all the capture files are still
open?
2) I need to be notified when the file is closed so that I can do
post-processing of rht capture. I've tried inotifywait in a script, and in
another script I tried lsof. lsof works great, but the files are open,.
See, the main issue is that I need to know when each file completes so that
I can post process.

Here is my post process script outline:

#!/bin/bash

for f in $HOME/vboxshare/jkirby/newarc/*.raw
  do
    filename=$(basename $f)
    open=$(lsof -t $f | wc -w)
    if [ $open -lt 1 ]
      then
        echo "$filename is closed"
        echo "Do post processing here"
      else
        echo "$filename is open by $open processe(s)"
    fi
  done

If I could close the file before or after the previous file is closed, I
can do my work. Otherwise, I have no way to know if the file is open and
being processed or not.

So, I've made the changes, I just need to build the darn thing.

Thanks for any advice or help.

-- 
Jamey Kirby
Disrupting the establishment since 1964

*This is a personal email account and as such, emails are not subject to
archiving. Nothing else really matters.*
