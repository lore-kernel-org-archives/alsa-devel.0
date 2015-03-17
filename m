From: Xuebing Wang <xbing6@gmail.com>
Subject: Can iMX6SL supports different sampling rate for
 different SSIs?
Date: Tue, 17 Mar 2015 08:24:27 +0800
Message-ID: <5507743B.5040808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com
 [209.85.192.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 472BD2619FB
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 01:24:33 +0100 (CET)
Received: by qgfa8 with SMTP id a8so55943831qgf.0
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 17:24:32 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org
Cc: niranjan Patil <Niranjan.Patil@infocus.com>, Richard Jiang <Richard.Jiang@infocus.com>
List-Id: alsa-devel@alsa-project.org

Nicolin,

Thank you very much for your always help.

I am using 3 SSIs (as I2S master mode) on iMX6SL for 3 different codec.

1) If I read iMX6SL reference manual correctly, I am deriving SSI 
sys_clock from pll4.

-- pll4 = Fref * (DIV_SELECT + NUM/DENOM)
    ** I am using a value of 786.432000 MHz

-- pll4_main_clk = pll4 / (PLL_AUDIOn: POST_DIV_SELECT) / 
CCM_ANALOG_MISC2n: MSB:LSB
    ** I am using a value of 196.608 MHz

-- SSI1_CLK_ROOT = pll4_main_clk / (CS1CDR: ssi1_clk_pred) / CS1CDR: 
ssi1_clk_podf
    ** I am using a value of 3.072 MHz (for 48k sampling rate)


2) As pll4_main_clk is global for all 3 SSIs, I think that we can *not* 
use 8k for ssi1 and 44.1k for ssi2, right? Because 8k and 44.1k requires 
different pll4 clock, right?
     -- However, as 48k, 32k, 16k, 8k can use same pll4, thus different 
SSI can use different sampling rate in this subset (48k, 32k, 16k, 8k).
     -- Same principle applies for 44.1k, 22.050, 11.025 subset of 
sampling rates.

Is my understanding correct?


-- 
Xuebing
