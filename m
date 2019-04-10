From: Cameron Kellough <cameron@paloaltoinnovation.com>
Subject: ASoC fsl_sai? Output stuck high causes loud pop
Date: Wed, 10 Apr 2019 12:57:20 -0700
Message-ID: <CAHWfWznwBTvwPFz_Q4C7y82jQCKqTnoR4zEgjcY+6bLJV=BTuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E79BF89616
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 21:57:31 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id y7so4350017wrn.11
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 12:57:31 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi ASoC developers,

I'm working with kernel 4.9.88 on an NXP IMX6ULL based PicoSOM from
Technexion. We have developed our own integration of this CPU with an audio
codec and a DSP.  I'm hearing a loud pop at the end of playback for sounds
and after a lot of tracing, I think there may be a problem in or near the
fsl_sai driver.  I suspect that the SAI transmitter is not being disabled
at the end of playback as the bus appears to be driven with all ones after
the end of playback.

Briefly, we have the IMX6ULL configured as an I2S slave to a DSP chip.  In
this case, the DSP is continuously providing BCLK and LRCLK to the IMX6ULL
and the connected codec.  When no sound is playing and I examine the output
of the Serial Data Out line from the IMX6ULL with an o-scope, the values on
it encode all high bits instead of all low bits.  The popping noise we hear
seems to be the bus going from a relatively low value at the end of a
played sound to an infinite length set of samples of maximum volume.  Based
on having set the pad control registers to no pullup, one would expect the
I2S bus to be low when no sound is being transmitted.

While the exact problem above involves a custom setup, a popping can be
observed using the Technexion IMX6ULL on the PI baseboard and playing a
sound with aplay.    Some evidence on the NXP forum suggests the problem
also exists using the IMX6.

I'm sorry this isn't a lot to go on.  I'm happy to provide more information
if anyone is interested in this issue.

--Cameron Kellough
