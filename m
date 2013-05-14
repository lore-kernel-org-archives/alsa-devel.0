From: Daniel Drake <dsd@laptop.org>
Subject: Handling HDA FIFO error
Date: Tue, 14 May 2013 11:00:49 -0600
Message-ID: <CAMLZHHT8Q4iV5Ug8s6XyA1-LNWUe+WH3a0jEqHTbXYC-ihzy7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f44.google.com (mail-qe0-f44.google.com
 [209.85.128.44])
 by alsa0.perex.cz (Postfix) with ESMTP id F02D72650CE
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 19:00:50 +0200 (CEST)
Received: by mail-qe0-f44.google.com with SMTP id s14so620605qeb.3
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 10:00:50 -0700 (PDT)
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

On the OLPC XO-1.5 (VIA VX855 SoC with HDA) we sometimes see a problem
where audio playback fails. Easy to reproduce by playing a short wav
file in a loop, it will fail after a minute or two.

The playback app gets confused here: snd_pcm_wait() returns success,
but snd_pcm_writei() returns EAGAIN.

Digging into the HDA code, I can see that normally, when the stream
gets started, we get interrupts with SD_STS as 0x24. In the failure
case, as soon as we start the stream, we get a flood of interrupts
with SD_STS 0x8 - which indicates FIFO error.

Disabling interrupt generation upon FIFO error does not help much - it
avoids the flood of interrupts, but doesn't change the fact that audio
playing apps hang or loop infinitely.

I have tried the various position_fix options with no luck.

Are there any things I could check that would explain why a FIFO error
might be occurring? After a quick read of the HDA spec I don't really
understand what this FIFO actually is and what it does, how does it
relate to the BDL, CORB and RIRB?

Failing that... any suggestions for how to improve the hda_intel
driver to handle FIFO error gracefully? Right now there is no code to
handle that.

Thanks
Daniel
