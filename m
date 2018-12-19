From: Diego Viola <diego.viola@gmail.com>
Subject: alsa-lib: commit
	ce2095c41f2891c51f5dbd28e0317200314c5a75 breaks
	speaker-test/pulseaudio
Date: Wed, 19 Dec 2018 00:29:38 -0200
Message-ID: <CA+ToGPG3zHSY7bNRtLyigTGZtaVpb7tnfuHuPOVDRtw9U9weGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com
 [209.85.161.48])
 by alsa0.perex.cz (Postfix) with ESMTP id AC70A26782E
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 03:29:50 +0100 (CET)
Received: by mail-yw1-f48.google.com with SMTP id h32so7573371ywk.2
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 18:29:50 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

I currently have an issue with speaker-test and pulseaudio, and the
root of the problem seems to be a regression in alsa-lib.

The issue occurs when I run speaker-test, it creates endless output
with no sound, and the output does not stop until I hit ctrl-c.

I've been investigating about this issue and concluded (through a git
bisect) that this is a regression in alsa-lib, and this is the bad
commit that introduces the bug:

commit ce2095c41f2891c51f5dbd28e0317200314c5a75
Author: Takashi Iwai <tiwai@suse.de>
Date:   Thu Mar 29 09:51:46 2018 +0200

    pcm: ioplug: Implement proper drain behavior

    This patch fixes the draining behavior of ioplug in the following
    ways:

    - When no draining ioplug callback is defined, implement the draining
      loop using snd_pcm_wait*() and sync with the drain finishes.
      This is equivalent with the implementation in the kernel write().
      Similarly as in kernel code, for non-blocking mode, it returns
      immediately after setting DRAINING state.

    - The hw_ptr update function checks the PCM state and stops the stream
      if the draining finishes.

    - When draining ioplug callback is defined, leave the whole draining
      operation to it.  The callback is supposed to return -EAGAIN for
      non-blocking case, too.

    - When an error happens during draining, it drops the stream, for a
      safety reason.

    Signed-off-by: Takashi Iwai <tiwai@suse.de>

I've sanity checked and can confirm that going back to the previous
commit fixes the issue.

My original bug report on the pulseaudio bug tracker:
https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/593

Thanks, and please let me know if you need more information.

Regards,
Diego
