From: Rob Nertney <rob@rob-otics.com>
Subject: Playback formats;
	does aplay pad S16_LE, or does the hardware?
Date: Sun, 2 Apr 2017 16:40:30 -0700
Message-ID: <CALAeOVNZWTOeAXB+4neM+xPb=63egoaSJiaZaZ5e3izi81ND8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A3682668F6
 for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2017 01:40:32 +0200 (CEST)
Received: by mail-lf0-f42.google.com with SMTP id z15so63770251lfd.1
 for <alsa-devel@alsa-project.org>; Sun, 02 Apr 2017 16:40:31 -0700 (PDT)
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

I can successfully play 32b@32KHz and 32b@16KHz to my I2S DAC.

I can also, with the same settings as 32b@16KHz, play 16b@32KHz, but I
don't think this is the way ALSA wants its data....

I've learned that hw_params is responsible for describing only what the
hardware is supposed to be capable of. Does this mean the hardware needs to
find a way to pad 0's on lower quality data for any given rate?

For example, when I play 32b @32 KHz, everything works. If I play 16b@32KHz,
I shouldn't change any output clocks, but will also present the data on a
32bit data bus as 16bits padded with 0? Or does it pack the data such that
the hardware needs to determine that it's in 16b mode, and pad the data
itself?

Thanks,
Rob
