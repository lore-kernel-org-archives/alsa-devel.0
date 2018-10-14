From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-utils][PATCH 0/9] alsactl: friendly to pluggable
	devices
Date: Sun, 14 Oct 2018 23:36:25 +0900
Message-ID: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 64D1B2677D8
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 16:36:43 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id g2-v6so7924643pgu.11
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 07:36:43 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

A bug was reported that monitor mode of alsactl consumes much CPU time
after disconnection of any sound card[1].

This patchset improves the mode to handle connection/disconnection of
sound card. Observed control nodes are maintained by list structure
instead of array. Linux specific epoll(7) is used to dispatch events.
Linux specific inotify(7) is used to detect connection of new sound
card. Linux specific signalfd(2) is used to catch Unix signals for
termination.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-September/140580.html

Takashi Sakamoto (9):
  alsactl: split event loop code to a function
  alsactl: add an iterator of registered instances of sound card
  alsactl: use epoll(7) instead of poll(2)
  alsactl: use link list to maintain source of events
  alsactl: use a list of source for event dispatcher instead of an array
    of source
  alsactl: obsolete array for maintenance of handlers
  alsactl: handle disconnection of sound card
  alsactl: handle detection of new sound card
  alsactl: use signalfd to catch UNIX signal

 alsactl/monitor.c | 422 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 375 insertions(+), 47 deletions(-)

-- 
2.19.1
