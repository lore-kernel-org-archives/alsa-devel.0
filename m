From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Need help fixing pop/click artifacts in an ASOC driver
Date: Tue, 6 Nov 2018 18:37:32 +0200
Message-ID: <ed34c70f-8d10-992e-1cf3-3a5f038c3664@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by alsa0.perex.cz (Postfix) with ESMTP id E14942678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 17:37:35 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id t15-v6so4884856wmt.0
 for <alsa-devel@alsa-project.org>; Tue, 06 Nov 2018 08:37:35 -0800 (PST)
Received: from [192.168.1.110] (ipa1.211.tellas.gr. [62.169.211.1])
 by smtp.gmail.com with ESMTPSA id o18-v6sm11170986wrp.31.2018.11.06.08.37.33
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Nov 2018 08:37:34 -0800 (PST)
Content-Language: en-US
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

A (commercial) DAC board, I use with a Raspberry Pi is plagued by clicks 
and pops and I'm trying to fix it at the driver level.  I have mostly 
fixed it, but I could use some guidance on the problem described below. 
I apologize in advance for the long read, but the situation is a bit 
convoluted (or my understanding of it is).

The board (a HifiBerry DAC+ Pro) uses a PCM5122 chip which is driven by 
the pcm512x codec driver, but the Pro version also includes a set of 
external clocks on the board (one each for 48Khz and 44.1Khz sample 
rates and multiples thereof).

There are two kinds of clicks and pops: on the one hand the board clicks 
when the device is opened/closed, mostly because the pcm512x codec 
driver doesn't support the digital_mute operation.  These are relatively 
mild clicks, which are an annoyance at most and I have a separate patch 
for the pcm512x, that addresses them, which I'm currently testing and 
will (hopefully) submit soon.

A separate case is a pop that's generated when the clock source is 
changed.  This pop is independent of the digital volume setting and very 
loud.  As far as I could determine, when the hw_params callback 
specified in the snd_soc_dai_link struct is called, it figures out what 
clock is needed for the giver sample rate and powers the appropriate 
clock through a GPIO on the PCM5122.  This essentially means that the 
external clock source fed into the 5122 is stopped and restarted at a 
different rate, potentially while the DAC chip is operating.  Later the 
hw_params callback defined in the pcm512x driver is called and it 
reconfigure the clock dividers for the new rate.  It is at this point 
that the pop seems to be generated, provided that the card is not 
powered down or muted.  If I comment out either the clock power-up/down 
in the dai_link hw_params, or the clock divider reconfiguration in the 
codec's hw_params, no pop is generated.

Now, the digital_mute patch described before, also happens to fix this 
loud pop.  I'm not sure whether that's a happy coincidence that might 
cease to be the case in the future though and was considering fixing the 
pop problem separately, at its source: the clock change.  One way to fix 
the problem is to switch the 5122 into standby before changing the clock 
source in the dai_link hw_params callback and switch it back into normal 
operation afterwards.  This seems to work regardless of whether 
digital_mute is implemented or not, but has the following problem: The 
register that's used to put the chip into/out of standby, is also used 
by the pcm512x driver, in the set_bias_level operation.  Since the 
hw_params operation is, as far as I can tell, not atomic, I'm concerned 
that race conditions may arise, causing the card to be left powered up, 
when it should be off and vice-versa.

Is there some way to synchronize the use of common chip registers in the 
DAI and codec drivers?  Is the digital_mute somehow guaranteed to fix 
the pop originating at the DAI/machine driver level (whatever the 
hw_params operation in the dai_link struct is supposed to be)? Am I 
perhaps missing something entirely?

Any help or guidance is welcome.

Thanks,
Dimitris
