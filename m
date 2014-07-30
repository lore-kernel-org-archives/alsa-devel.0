From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: ASoC: TI codecs and their crazy variable length
	registers
Date: Wed, 30 Jul 2014 17:56:36 -0400
Message-ID: <CAKON4OyCqvjLq09+WymcSKRwfLJrSBoLMRWksNO2hKrtR3u3vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FA2E2608E8
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 23:56:37 +0200 (CEST)
Received: by mail-ie0-f169.google.com with SMTP id rd18so2494133iec.28
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 14:56:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

I'm working on a TI codec attached via I2C.  Just to make things
interesting the registers have varying byte lengths of - 1,4,8,12,20
bytes. What's the best strategy for using regmap with it?

My idea was to make five sparse regmaps, one for each of the five
lengths? Chip has about 75 registers.  The 20 byte ones are biquad
coefficients.

Also, does regmap restore MMIO registers after a suspend? Allwinner
has code in their drivers for drivers for saving/restoring the DAI
registers over a suspend.

Sven Brandau made a really nice driver for the sta350, I'm using it as
a guide. The chips are fairly similar. But no variable length
registers on that chip.

-- 
Jon Smirl
jonsmirl@gmail.com
