From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: Understanding Atmel SSC SND_SOC_DAIFMT_CBS_CFS mode
Date: Sat, 18 Apr 2015 12:58:59 +0200
Message-ID: <CA+TH9V=-YrtF8GoE2NQh1T+OMUm9uujDmV3aEGMdHSrxmAZiKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com
 [209.85.220.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B38E2615F7
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 12:59:40 +0200 (CEST)
Received: by qku63 with SMTP id 63so167348682qku.3
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 03:59:39 -0700 (PDT)
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

Hi List,

I'm looking for a way to understand how to correctly configure the
Atmel SSC dai on a SAMA5D3 to work in master mode with an I2S codec.

>From this comment:

 /*
 * I2S format, SSC provides BCLK and LRC clocks.
 *
 * The SSC transmit and receive clocks are generated
 * from the MCK divider, and the BCLK signal
 * is output on the SSC TK line.
 */

My question is: should be MCK divider configured manually? If yes how?

Actually I'm trying to poke around in atmel_ssc_dai and found a way to
generate a stable bit clock, but frame clock is not working as
expected.

Have you any advice on how to set correctly SSC parameters to generate
a stable bit clock and frame clock?

Any advice?

Thank you!

-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
