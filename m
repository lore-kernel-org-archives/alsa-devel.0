From: Ondrej Zary <linux@rainbow-software.org>
Subject: [RFC PATCH 0/2] tea575x: Move from sound to media
Date: Thu, 13 Jun 2013 23:42:27 +0200
Message-ID: <201306132342.28143.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
TEA575x is neither a sound device nor an i2c device. Let's finally move it 
from sound/i2c/other to drivers/media/radio.

Tested with snd-es1968, snd-fm801 and radio-sf16fmr2.

I guess the Kconfig dependencies are not correct.

-- 
Ondrej Zary
