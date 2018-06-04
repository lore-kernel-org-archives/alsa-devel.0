From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: [alsa-devel][PATCH 0/3] ASoC: TSCS42xx: Control Improvements
Date: Mon, 4 Jun 2018 15:45:08 -0500
Message-ID: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Steven Eckhoff (3):
  Add mic bias boost control
  Remove Playback/Capture from control names
  Add headphone auto switching controls

 sound/soc/codecs/tscs42xx.c | 37 +++++++++++++++++++++++--------------
 sound/soc/codecs/tscs42xx.h |  8 ++++++++
 2 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.17.0
