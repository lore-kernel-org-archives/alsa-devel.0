From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] ASoC: fix hw_params/hw_free validity checks
Date: Mon, 29 Apr 2019 11:47:48 +0200
Message-ID: <20190429094750.1857-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

While working on a codec, I have found an odd situation. The hw_params
callback which was provided by the codec dai was not called as expected.
However, the hw_free callback was called, even if hw_params was skipped.

After debugging, I found out that the dai was considered invalid because
it did not specify any rates, only rate_min and rate_max. That's a first
problem.

If a codec dai is considered invalid, hw_free should probably not be
called either, that's a 2nd issue.

This patchset is meant to solve both issues.

Jerome Brunet (2):
  ASoC: fix valid stream condition
  ASoC: skip hw_free on codec dai for which the stream is invalid

 sound/soc/soc-pcm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.20.1
