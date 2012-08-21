From: George Stefan <stefan.george87@gmail.com>
Subject: SAIF configuration on imx28
Date: Tue, 21 Aug 2012 14:24:32 +0300
Message-ID: <CAACwSTK-fzSy+HG+u5H0aNU_wfSa7gvAsH2fVMdczssnYtpJXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 52D49265325
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 13:24:31 +0200 (CEST)
Received: by eaa13 with SMTP id 13so1804597eaa.38
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 04:24:32 -0700 (PDT)
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

Hello,
I am using a custom board based on imx28 (running 2.6.35) with the SAIF
interface connected to the PCM output of a modem.
I have developed a dummy codec for the modem and customized mxs-devb.c to
use that codec instead of sgtl5000.
Clock master, fixed at 256kHz,
Frame sync master, fixed 125us frame duration (8kHz): 32 bits of total
data; first 16 bits are valid (while FS is high), following 16 are "don't
care" (while FS low)
16-bit linear samples, sent MSB first
"Long Frame" sync:  transmit and receive occur simultaneously while the
common FS line is active (high).
TX data with 0-bit delay; start at the rising edge of the clock, while FS
is high.
RX data with 0-bit delay; sample at the falling edge of the clock, while FS
is high.
This configuration is fixed so the only setup needed for SAIF is

dai_format = SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_IB_NF |
                     SND_SOC_DAIFMT_CBM_CFM;
/* set cpu DAI configuration */
 ret = snd_soc_dai_set_fmt(cpu_dai, dai_format);
       if (ret < 0)
             return ret;

My problem is, although i am receiving dma irqs when i record ( arecord -f
S16_LE -r 8000 -c 1 <file>.wav), when i play the resulting file its just
silence.

[ 5295.890000] dump @ mxs_saif_trigger
[ 5295.890000] scr 101  , 107
[ 5295.890000] stat 80010041    , 80010071
[ 5295.890000] data 0   , ffffffff
[ 5295.890000] version 1010000  , 1010000
This  is a dump for arecord!

Do you have any ideeas?
Thanks,
George.
