From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-io: Only force use regmap if the
 codec have it implemented
Date: Wed, 1 Aug 2012 14:24:20 +0100
Message-ID: <20120801132419.GT11892@opensource.wolfsonmicro.com>
References: <1343822505-6331-1-git-send-email-peter.ujfalusi@ti.com>
 <20120801121630.GP11892@opensource.wolfsonmicro.com>
 <50191F0D.6090807@ti.com>
 <20120801124021.GQ11892@opensource.wolfsonmicro.com>
 <50192A8A.3080204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2A25A265209
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 15:24:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50192A8A.3080204@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 01, 2012 at 04:09:30PM +0300, Peter Ujfalusi wrote:
> On 08/01/2012 03:40 PM, Mark Brown wrote:

> > You're changing the function setting up register I/O to ignore what's
> > being set.  This is silly - the soc-io code is doing exactly the right
> > thing here.

> Well, it overrides the codec->read/write/bulk_write_raw callbacks, sets the
> codec->using_regmap to true regardless if the codec have regmap or not.
> It should only do all of these if the regmap is there IMHO.

That's exactly what it's being asked to do!

> The soc-core calls snd_soc_codec_set_cache_io() if codec->control_data is NULL
> at the moment.

Right, so perhaps that's the decision which needs revisiting?
