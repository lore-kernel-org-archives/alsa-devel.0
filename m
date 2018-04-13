From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v3 0/2] ASoC: max9860/tfa9879: switch to SPDX
	license tag
Date: Fri, 13 Apr 2018 13:47:49 +0200
Message-ID: <20180413114751.6464-1-peda@axentia.se>
References: <20180413111927.GC6854@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0117.outbound.protection.outlook.com [104.47.2.117])
 by alsa0.perex.cz (Postfix) with ESMTP id 48BF2266BBC
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 13:48:06 +0200 (CEST)
In-Reply-To: <20180413111927.GC6854@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

On 2018-04-13 13:19, Mark Brown wrote:
> On Thu, Apr 12, 2018 at 11:14:35PM +0200, Peter Rosin wrote:
> 
>> @@ -1,3 +1,4 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>  /*
>>   * Driver for the MAX9860 Mono Audio Voice Codec
>>   *
> 
> Please don't mix C and C++ comments like this - it looks unintentional
> and messy.  Just convert the entire comment block to C++ so it's
> consistent with itself.

Done.

Cheers,
Peter

Peter Rosin (2):
  ASoC: max9860: switch to SPDX license tag
  ASoC: tfa9879: switch to SPDX license tag

 sound/soc/codecs/max9860.c | 31 +++++++++++--------------------
 sound/soc/codecs/max9860.h | 10 +---------
 sound/soc/codecs/tfa9879.c | 18 ++++++------------
 sound/soc/codecs/tfa9879.h |  7 +------
 4 files changed, 19 insertions(+), 47 deletions(-)

-- 
2.11.0
