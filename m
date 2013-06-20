From: Michael Lathion <m.lathion@gmail.com>
Subject: WM8741 DAC with AT91SAM9G20
Date: Thu, 20 Jun 2013 23:40:16 +0200
Message-ID: <CA+WMtaNJYNO81zKVWYYQ2SkPwd+2tvn0KEBNv879mNANTLYU9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f67.google.com (mail-oa0-f67.google.com
 [209.85.219.67])
 by alsa0.perex.cz (Postfix) with ESMTP id BD4E426535A
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2013 23:40:17 +0200 (CEST)
Received: by mail-oa0-f67.google.com with SMTP id l10so3651900oag.2
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2013 14:40:16 -0700 (PDT)
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

Hi all,

I'm trying to use a WM8742 dac instead of WM8731 on a custom board based on
AT91SAM9G20EK (developpment board from Atmel for AT91SAM9G20 soc) with
Linux Kernel 2.6.38.

I have the driver working in alsa (driver compiled, mixer up in alsa, ...)
but I can't have the ssc interface working. When trying to play sound with
aplay I get only the masterclock and  bitclock but no frame clock (LRCLK),
see output below.

What I've done is modifying the /sound/soc/atmel/sam9g20_wm8731.c file  but
it seems something is not configured as it should (probably related to
WM8742 being slave and the WM8731 used on original dev board was master for
clock distribution).

My modified sam9g20_wm8741.c is enclosed to this mail, i suspect something
is wrongly setup in CPU DAI configuration but can't find what.

I'm trying to set this up from some weeks now but can't find the right
config so if someone have any idea on what can has to be done it could be
great!

Thanks for help

Regards
Michael

Linux kernel 2.6.38
AT91SAM9G20 processor
WM8741 DAC

Kernel boot output :

ASoC: Mclk set to 22579200
wm8741-codec 0-001b: Successful registration
FOX_Board_wm8741 : PB1003A: wm8741__init() called
wm8741-codec 0-001b: wm8741_set_dai_sysclk info: freq=22579200
asoc: wm8741 <-> atmel-ssc-dai.0 mapping ok
ALSA device list:
  #0: DAISY16

When trying play sound  kernel driver print:

wm8741-codec 0-001b: wm8741_set_dai_fmt:    Format=0, Clock Inv=0
wm8741-codec 0-001b: wm8741_hw_params:    bit size param = 2
