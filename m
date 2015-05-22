From: Armin Ranjbar <zoup@zoup.org>
Subject: Sennheiser HDVD 800 Support
Date: Fri, 22 May 2015 21:37:33 +0430
Message-ID: <CAOvx4-2g3V+Sdju3YGRBeaUFPK+1TMSQ=KXSmCrm1jV4VWE7Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D09F26041D
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 19:07:54 +0200 (CEST)
Received: by wicmc15 with SMTP id mc15so45791646wic.1
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 10:07:54 -0700 (PDT)
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

Dear everyone,

i have noticed that alas doesn't support HDVD-800 USB DAC, i can not hear
anything.
note that this device requires it's own driver under windows/mac.

this is my alsa-info output:
http://www.alsa-project.org/db/?f=fe56e65add73248baf5307a04b6b9deb2b236004

output of pasuspender -- aplay -Dplughw:2  some_file.wav:
ALSA lib pcm_hw.c:1667:(_snd_pcm_hw_open) Invalid value for card
main:722: audio open error: No such file or directory

output of aplay -v -fdat --dump-hw-params -d1 -Dhw:S20 /dev/zero:
http://pastebin.com/p2Daxza6

speaker-test -c2 -twav -Dplughw:S20 starts OK, but i can't hear anything/

product page:
http://en-us.sennheiser.com/headphone-audio-amplification-hdvd-800-acoustic


I'm open to help if you need anything to be done.
---
Armin ranjbar
