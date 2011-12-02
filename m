From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/6] Random WM8903 updates
Date: Fri, 2 Dec 2011 19:07:10 +0000
Message-ID: <20111202190710.GB27227@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70D6624602
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 20:07:14 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Stephen Warren <srwarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This is a random collection of WM8903 updates that I started coding
because I was looking at the driver and spotted a few style issues but
haven't actually tested yet.  I'm pushing them out now mostly because
Stephen is also working on the driver and I want to avoid collisions.
There's also a patch to convert to devm_kzalloc() that I posted earlier
but that's trivial enough.

It's pretty nice that even though I added a readable register function
for regmap listing every register in the chip the overall diffstat is
neutral, mostly as a result of the more efficient cache specification
format that regmap has.

Mark Brown (6):
      ASoC: Use table based control init for WM8903
      ASoC: WM8903 only supports I2C so don't ifdef it
      ASoC: Use a normal cache sync for WM8903
      ASoC: Don't resync WM8903 register cache on reset
      ASoC: Convert WM8903 to direct regmap API usage
      ASoC: Move initial WM8903 identification and reset to I2C probe

 sound/soc/codecs/wm8903.c |  449 +++++++++++++++++++++++----------------------
 1 files changed, 225 insertions(+), 224 deletions(-)
