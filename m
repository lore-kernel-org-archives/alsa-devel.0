From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/2] ASoC: More AC'97 cleanups
Date: Mon,  3 Nov 2014 19:33:01 +0100
Message-ID: <1415039583-4858-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-249.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 52CAA2604D3
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 19:33:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

More AC'97 cleanups in preparation for the conversion to regmap.

* The mioa701_wm9713 directly accesses the read/write callback of the CODEC
  driver which will break when converting the driver to regmap.
* Re-worked version of the wm9712/wm9713 virtual register removal, this time
  using custom put/get handlers to keep the control names.

- Lars

Lars-Peter Clausen (2):
  ASoC: mioa701_wm9713: Don't opencode CODEC register access
  ASoC: wm9712/wm9713: Replace virtual registers with custom put/get
    callbacks

 sound/soc/codecs/wm9712.c      | 163 ++++++++++++++++++++++++++---------------
 sound/soc/codecs/wm9713.c      | 153 ++++++++++++++++++++++----------------
 sound/soc/pxa/mioa701_wm9713.c |   7 +-
 3 files changed, 196 insertions(+), 127 deletions(-)

-- 
1.8.0
