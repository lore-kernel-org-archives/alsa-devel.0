From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: How to activate DAI link to dummy codec?
Date: Fri, 10 Jul 2015 14:50:03 -0700
Message-ID: <CAOMFOmUeF_LbfYyGGaCZG690Wow7FdiZtVTFHo7FyXdRMsYpnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f45.google.com (mail-vn0-f45.google.com
 [209.85.216.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FC6F2604A1
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 23:50:06 +0200 (CEST)
Received: by vnbg129 with SMTP id g129so39573524vnb.3
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 14:50:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi

I have following hardware configuration

[SoC] <=> [RT5677] <=> [MAX98357A]

MAX98357A is a simple speaker amplifier with I2S data interface and no
I2C control. The chip automatically configures itself (rate/block
frequency) when I2S is started streaming to the chip. This chip does
not need a driver (there is nothing to configure) and we can use
"dummy-codec" for it.

There is a DAI link between RT5677 and MAX and it should be configured
from RT5677 side. RT5677 is master here and it need to set I2S bus
parameters. Configuration happens in rt5677 hw_params() function and
it is triggered by dai link activation.

My question is how to tell DAPM that I need to activate this link?

If MAX98357A was a real codec then it would have an OUTPUT widget that
I can activate, this would trigger dai link in between to be activated
as well. But dummy codec does not have any widgets, so how I suppose
to activate link to dummy codec?
