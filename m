From: Max Kellermann <max@duempel.org>
Subject: dmix, snd_pcm_drain(), SND_PCM_NONBLOCK - bug?
Date: Thu, 16 Mar 2017 13:23:36 +0100
Message-ID: <20170316122336.GA7038@swift.blarg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swift.blarg.de (swift.blarg.de [78.47.110.205])
 by alsa0.perex.cz (Postfix) with ESMTP id E579B266829
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 13:23:37 +0100 (CET)
Content-Disposition: inline
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

I have received a bug report for the Music Player Daemon which
complains about a freezing MPD process, after I switched MPD's ALSA
output to non-blocking mode:

 https://bugs.musicpd.org/view.php?id=4662

This happens when snd_pcm_drain() is used on a dmix PCM which is in
SND_PCM_NONBLOCK mode.  snd_pcm_drain() will be called repeatedly,
because ALSA's file descriptor is always ready.

According to my research, the bug is in __snd_pcm_dmix_drain().  This
function always returns -EAGAIN when SND_PCM_NONBLOCK is set:

  if (pcm->mode & SND_PCM_NONBLOCK)
        return -EAGAIN;

This comes very early in the function, before any other relevant
checks.  It can never finish that way, and calling it again at any
time will never do anything.  Thus, snd_pcm_drain() appears to be
broken in non-blocking mode.

Or am I misunderstanding how snd_pcm_drain() is supposed to be used in
non-blocking mode?

Max
