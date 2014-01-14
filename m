From: Arun Shamanna Lakshmi <aruns@nvidia.com>
Subject: [PATCH] Change the prototype of soc_widget_read
Date: Tue, 14 Jan 2014 15:31:53 -0800
Message-ID: <1389742314-20125-1-git-send-email-aruns@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arun Shamanna Lakshmi <aruns@nvidia.com>
List-Id: alsa-devel@alsa-project.org

soc_widget_read API returns the register data and it is possible
that a register can contain 0xffffffff at any point of time.
In such cases snd_soc_widget_write is not called after the read
operation inside snd_soc_update_bits_locked API. Thus, change
the prototype of soc_widget_read to return only the error code
and pass the register data through the pointer argument.

Arun Shamanna Lakshmi (1):
  ASoC: dapm: Change prototype of soc_widget_read

 sound/soc/soc-dapm.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

-- 
1.7.9.5
