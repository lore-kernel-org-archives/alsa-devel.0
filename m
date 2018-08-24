From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 0/1] Fix ADI axi-i2s + Xilinx AXI-DMA capture
Date: Fri, 24 Aug 2018 18:04:29 +0200
Message-ID: <20180824160430.10222-1-luca@lucaceresoli.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

here is a fix for a nasty audio capture problem when the axi-i2s
output stream is fed to a Xilinx AXI-DMA.

The commit is simple and hopefully well described, but I am not 100%
sure the solution is the correct one. If it is not, I'll be glad to
know which one is the best. It solved my problem anyway.

Luca


Luca Ceresoli (1):
  axi-i2s: set period size register

 sound/soc/adi/axi-i2s.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.17.1
