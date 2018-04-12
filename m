From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/2] ASoC: tfa9879: switch to using
	.probe_new
Date: Thu, 12 Apr 2018 23:14:32 +0200
Message-ID: <20180412211437.21599-1-peda@axentia.se>
References: <20180412161601.GI9929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30107.outbound.protection.outlook.com [40.107.3.107])
 by alsa0.perex.cz (Postfix) with ESMTP id C81B3266F69
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 23:15:08 +0200 (CEST)
In-Reply-To: <20180412161601.GI9929@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

On 2018-04-12 18:16, Mark Brown wrote:
> On Wed, Apr 11, 2018 at 02:42:38PM +0200, Peter Rosin wrote:
> 
>> Use the new probe style for i2c drivers.
> This doesn't apply against current code, please check and resend.

That's not my fault. Somebody forgot to drop a note with the maintainer
so I was completely unaware of this change. It seems to have been a
cocci-script or something behind that change because the code looks
like shit afterwards.

For the record, I wish to be on Cc for changes to files I maintain.
That is one of the core functions of the MAINTAINERS file, right?

Anyway, I added a couple of fixups for that mess and I also did a SPDX
conversion while at it since I noticed it was needed. Finishing off with
the rebased patch.

Cheers,
Peter

Peter Rosin (5):
  ASoC: max9860: fix whitespace issues caused by mindless conversion
  ASoC: tfa9879: fix whitespace issues caused by mindless conversion
  ASoC: max9860: switch to SPDX license tag
  ASoC: tfa9879: switch to SPDX license tag
  ASoC: tfa9879: switch to using .probe_new

 sound/soc/codecs/max9860.c | 18 ++++++------------
 sound/soc/codecs/max9860.h | 10 +---------
 sound/soc/codecs/tfa9879.c | 37 ++++++++++++++++---------------------
 sound/soc/codecs/tfa9879.h |  7 +------
 4 files changed, 24 insertions(+), 48 deletions(-)

-- 
2.11.0
