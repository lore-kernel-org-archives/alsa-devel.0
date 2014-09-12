From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: The best practice to tie platform DAPM widget and
	codec pin
Date: Thu, 11 Sep 2014 21:04:28 -0700
Message-ID: <CAOMFOmX5FCsxXpoboDLKpnZrBQ52v3jRZQHbJAk2st0gXYrVKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id D025926509D
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 06:04:29 +0200 (CEST)
Received: by mail-vc0-f176.google.com with SMTP id la4so154562vcb.35
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 21:04:28 -0700 (PDT)
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

Hi

I bringing up a board that has Realtek 5677 codec. The codec has 6
gpios and two of them are used by the board. pin3 is used to enable
headphones amplifier. pin2 is used to gate DMIC clock for 3 of 4 DMICs
- it allows to leave only one DMIC working in low-power mode.

Now I need to configure the codec that when "Headphones" audio path is
enabled then pin3 should go high. The same true for DMIC/pin2. I was
looking for existing similar solutions but cannot find one.

I need something similar to SND_SOC_DAPM_REGULATOR_SUPPLY that allows
to turn on/off part of the system. But instead of manipulating a
voltage regulator I just need to set/unset codec's gpio. What would be
the best way to achieve it?

The problem here is that codec does not know which of the outputs
(LOUT1, LOUT2, LOUT3) corresponds to headphones. It is configured as
audio path in *.dts file.
