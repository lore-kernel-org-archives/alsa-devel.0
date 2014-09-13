From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 0/9] Misc fixes related to rewinds
Date: Sun, 14 Sep 2014 00:30:12 +0600
Message-ID: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 2219E261AC3
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 20:30:50 +0200 (CEST)
Received: by mail-lb0-f170.google.com with SMTP id c11so2605887lbj.29
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 11:30:49 -0700 (PDT)
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
Cc: tiwai@suse.de, clemens@ladisch.de, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

The idea of the series is to fix the two issues that I found [1] for the
hw plugin. snd_pcm_rewindable() sometimes returned negative values that
are actually negative amounts of samples and not error codes. Also, it
bases its calculations on stale hardware position pointer, which is not
what PulseAudio wants (alternatively, we can document the need to call
snd_pcm_avail() before snd_pcm_rewindable(), but I don't like it).

Also, similar issues in other plugins are fixed, except for "share" and
"shm" plugins that I could not really test due to unrelated crashes. I also
fixed miscelanneous cosmetic issues and bugs that I found along the way.

Note: this series touches pcm_dmix.c, but does not make it rewindable. In
other words, a variant of the test in [2] now produces a tone instead of
failing due to snd_pcm_rewind() returning 0. But it should ideally produce
silence. Obviously, there is some bug left that I have not pinpointed yet.

Same for dshare: the test produces a tone, and I don't yet know why.

[1] http://permalink.gmane.org/gmane.linux.alsa.devel/122843 and
    http://permalink.gmane.org/gmane.linux.alsa.devel/122848 (modify the
    test program to set the stop threshold larger than the buffer size)
[2] http://permalink.gmane.org/gmane.linux.alsa.devel/122179

Alexander E. Patrakov (9):
  dmix: actually rewind when running or being drained
  pcm: express the rewind size limitation logic better
  pcm: handle negative values from snd_pcm_mmap_hw_avail
  pcm, rate: use the snd_pcm_mmap_hw_avail function
  pcm, null: use the snd_pcm_mmap_avail function
  rate: handle negative values from snd_pcm_mmap_playback_hw_avail
  dsnoop: rewindable and forwardable logic was swapped
  pcm: rewindable, forwardable: don't return stale data
  pcm, file: don't recurse in the rewindable and forwardable callbacks

 src/pcm/pcm_dmix.c   | 20 ++++++++++++++------
 src/pcm/pcm_dshare.c | 16 +++++++++-------
 src/pcm/pcm_dsnoop.c | 18 ++++++++++--------
 src/pcm/pcm_file.c   |  4 ++--
 src/pcm/pcm_hw.c     |  8 +++++++-
 src/pcm/pcm_ioplug.c |  4 +++-
 src/pcm/pcm_local.h  | 18 ++++++++++++++++++
 src/pcm/pcm_null.c   |  5 +----
 src/pcm/pcm_plugin.c | 12 +++++++++---
 src/pcm/pcm_rate.c   |  9 +++------
 10 files changed, 76 insertions(+), 38 deletions(-)

-- 
2.1.0
