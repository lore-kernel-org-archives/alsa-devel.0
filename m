Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CC26726563B
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 07:58:19 +0200 (CEST)
Date: Thu, 14 Aug 2014 11:06:41 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20140814053637.GA6106@vinod.koul@linux.intel.com>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-3-git-send-email-subhransu.s.prusty@intel.com>
 <53EBC193.9070105@metafoo.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53EBC193.9070105@metafoo.de>
Subject: Re: [alsa-devel] [v4 02/12] ASoC: Intel: mrfld: set private data
 for cpu-dai
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-ID: <alsa-devel@alsa-project.org>

On Wed, Aug 13, 2014 at 09:50:43PM +0200, Lars-Peter Clausen wrote:
> [...]
> >+static int sst_media_dai_probe(struct snd_soc_dai *cpu_dai)
> >+{
> >+	struct sst_data *sst = dev_get_drvdata(cpu_dai->dev);
> >+
> >+	snd_soc_dai_set_drvdata(cpu_dai, sst);
> 
> snd_soc_dai_set_drvdata does dev_set_drvdata(dai->dev, data)
> internally, so this function does:
> 
> 	dev_set_drvdata(cpu_dai->dev, dev_get_drvdata(cpu_dai->dev));
> 
> That's pretty much a noop.
> 

Agree. Intention was to use snd_soc_dai_* API. Anyway will remove and use
dev_get_drvdata(dai->dev) directly.
-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
