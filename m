From: Diego Viola <diego.viola@gmail.com>
Subject: Re: alsa-lib: commit
	ce2095c41f2891c51f5dbd28e0317200314c5a75 breaks
	speaker-test/pulseaudio
Date: Wed, 19 Dec 2018 02:00:08 -0200
Message-ID: <CA+ToGPFKN5winyLZRDcGyp_CrcuBRRzgxPsXNFSkgtTdA9GYsQ@mail.gmail.com>
References: <CA+ToGPG3zHSY7bNRtLyigTGZtaVpb7tnfuHuPOVDRtw9U9weGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-f67.google.com (mail-yw1-f67.google.com
 [209.85.161.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FFCD26793C
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 05:00:20 +0100 (CET)
Received: by mail-yw1-f67.google.com with SMTP id x2so7613066ywc.9
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 20:00:20 -0800 (PST)
In-Reply-To: <CA+ToGPG3zHSY7bNRtLyigTGZtaVpb7tnfuHuPOVDRtw9U9weGg@mail.gmail.com>
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

On Wed, Dec 19, 2018 at 12:29 AM Diego Viola <diego.viola@gmail.com> wrote:
>
> Hello Takashi,
>
> I currently have an issue with speaker-test and pulseaudio, and the
> root of the problem seems to be a regression in alsa-lib.
>
> The issue occurs when I run speaker-test, it creates endless output
> with no sound, and the output does not stop until I hit ctrl-c.
>
> I've been investigating about this issue and concluded (through a git
> bisect) that this is a regression in alsa-lib, and this is the bad
> commit that introduces the bug:
>
> commit ce2095c41f2891c51f5dbd28e0317200314c5a75
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Thu Mar 29 09:51:46 2018 +0200
>
>     pcm: ioplug: Implement proper drain behavior
>
>     This patch fixes the draining behavior of ioplug in the following
>     ways:
>
>     - When no draining ioplug callback is defined, implement the draining
>       loop using snd_pcm_wait*() and sync with the drain finishes.
>       This is equivalent with the implementation in the kernel write().
>       Similarly as in kernel code, for non-blocking mode, it returns
>       immediately after setting DRAINING state.
>
>     - The hw_ptr update function checks the PCM state and stops the stream
>       if the draining finishes.
>
>     - When draining ioplug callback is defined, leave the whole draining
>       operation to it.  The callback is supposed to return -EAGAIN for
>       non-blocking case, too.
>
>     - When an error happens during draining, it drops the stream, for a
>       safety reason.
>
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>
> I've sanity checked and can confirm that going back to the previous
> commit fixes the issue.
>
> My original bug report on the pulseaudio bug tracker:
> https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/593
>
> Thanks, and please let me know if you need more information.
>
> Regards,
> Diego

Steps for reproducing the issue:

$ speaker-test -c 2 -t wav

Please be aware that in order to reproduce the issue you should not
have any other streams playing in pulseaudio at the same time. You
should notice endless output and no audio after reproducing the issue
successfully.

My system details:

Distro: Arch Linux
Kernel: Linux thinkpad 4.19.9-arch1-1-ARCH #1 SMP PREEMPT Fri Dec 14
00:58:26 UTC 2018 x86_64 GNU/Linux
Hardware: ThinkPad T450
pulseaudio 12.2-2
alsa-utils 1.1.7-1
alsa-lib 1.1.7-2

Here is the log of my git bisect:

git bisect start
# bad: [ee64b4b83afc0b1bdf99e1ccf7e6ea4602ef613f] pcm: extplug: Keep
format and channels the same if requested
git bisect bad ee64b4b83afc0b1bdf99e1ccf7e6ea4602ef613f
# good: [2bacd7042b785e99591671b6464a3c88e4ed5b4b] Release v1.1.5
git bisect good 2bacd7042b785e99591671b6464a3c88e4ed5b4b
# skip: [8ebb40c96970c913719a75deb2fe82ba2e257386] conf/ucm: Add a UCM
profile for Dell WD15 Dock USB-audio
git bisect skip 8ebb40c96970c913719a75deb2fe82ba2e257386
# bad: [44f499bb22f3923f966e11a234455e3d06936b8b] configure: Fix
forgotten ucm entry
git bisect bad 44f499bb22f3923f966e11a234455e3d06936b8b
# good: [9c2fb31d0ec13692eeefe1013b1f031da0e71395] pcm: Do not access
lock_enabled if thread safe API
git bisect good 9c2fb31d0ec13692eeefe1013b1f031da0e71395
# bad: [17bc74d3a25f0d4b1ca25d2d92fcad9c2a9d7f79] configure: remove
src/conf/alsa.conf.d/Makefile
git bisect bad 17bc74d3a25f0d4b1ca25d2d92fcad9c2a9d7f79
# good: [345843fc24b3d162383dfa6ea4b323199ccfe8c0] modules:
smixer_python - add support for python3
git bisect good 345843fc24b3d162383dfa6ea4b323199ccfe8c0
# bad: [a39f33a151f66ae2e576f0f08be30267ca01dd84] conf: USB-Audio: Add
second S/PDIF device on Phiree U2SX
git bisect bad a39f33a151f66ae2e576f0f08be30267ca01dd84
# good: [d3d42f60a6ba9e2684fe82ee311ef41e58e15921] pcm: Skip avail_min
check during draining
git bisect good d3d42f60a6ba9e2684fe82ee311ef41e58e15921
# bad: [ce2095c41f2891c51f5dbd28e0317200314c5a75] pcm: ioplug:
Implement proper drain behavior
git bisect bad ce2095c41f2891c51f5dbd28e0317200314c5a75
# first bad commit: [ce2095c41f2891c51f5dbd28e0317200314c5a75] pcm:
ioplug: Implement proper drain behavior

Thanks,
Diego
