From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH][RFC][alsa-utils 0/9] alsactl: monitor mode
	friendly for
Date: Fri,  5 Oct 2018 23:47:20 +0900
Message-ID: <20181005144729.21388-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id B4039267924
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 16:47:38 +0200 (CEST)
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so6968952plb.10
 for <alsa-devel@alsa-project.org>; Fri, 05 Oct 2018 07:47:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, thomas@coldfix.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

A command of 'alsactl' has 'monitor' mode to print events emitted by
observed control nodes. This mode is not friendly for plug-and-play
devices.

A bug is reported that the mode consumes 100% of CPU time when
detecting disconnection of observed sound card[1]. A process of
alsactl doesn't release ALSA control character device at disconnection.
This is quite bad in a view of system.

Furthermore, this mode cannot handle control nodes for newly-detected
sound card.

This patchset is my attempt to improve the mode to handle
disconnection of observed sound card and new detection of sound card.

A rough summary of this patchset:
 - maintains observed control nodes by link-list
 - uses epoll(7) instead of poll(2) to avoid following the list every time
   of poll loop, 
 - control node for disconnected sound card is not observed anymore and
   dropped from the list.
 - the list is rescan and observation is updated when detecting new
   sound card. Linux-specific inotify(7) is used for this purpose.

I'm happy if receiving test reports and indication of new bugs.

[1] [alsa-devel] alsactl monitor spins at 100% cpu after unplugging USB headphones
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-September/140580.html

Takashi Sakamoto (9):
  alsactl: install signal handler
  alsactl: split event loop code to a function
  alsactl: add an iterator of registered instances of sound card
  alsactl: use epoll(7) instead of poll(2)
  alsactl: use link list to maintain source of events
  alsactl: use a list of source for event dispatcher instead of an array
    of source
  alsactl: obsolete array for maintenance of handlers
  alsactl: handle disconnection of sound card
  alsactl: handle detection of new sound card

 alsactl/monitor.c | 403 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 356 insertions(+), 47 deletions(-)

-- 
2.19.0
