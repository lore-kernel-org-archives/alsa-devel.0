From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] ASoC: da7213: Adjustments for two function
 implementations
Date: Thu, 23 Nov 2017 18:30:58 +0100
Message-ID: <babe2503-46f1-2e1e-b482-62cd3e89f246@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, support.opensource@diasemi.com, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 18:28:38 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in da7213_fw_to_pdata()
  Improve a size determination in da7213_i2c_probe()

 sound/soc/codecs/da7213.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.15.0

