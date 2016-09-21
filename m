From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 01/11] ASoC: topology: Able to create BE
 DAIs
Date: Wed, 21 Sep 2016 08:09:55 +0100
Message-ID: <1474441795.15879.6.camel@loki>
References: <cover.1473420558.git.mengdong.lin@linux.intel.com>
 <084b7ba7ba3f0d4a97641b43fab26aee2dc20c5d.1473420558.git.mengdong.lin@linux.intel.com>
 <20160916145651.GD27974@sirena.org.uk>
 <17DC8B7179E3514D90E3A456B23B91EA1A0B0F50@BGSMSX104.gar.corp.intel.com>
 <57E21E2B.8020502@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 14B79266F4E
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 09:10:45 +0200 (CEST)
In-Reply-To: <57E21E2B.8020502@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Shah, Hardik T" <hardik.t.shah@intel.com>, "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2016-09-21 at 13:44 +0800, Mengdong Lin wrote:
> Thanks for your comments, Hardik! So we'll no longer let topology to 
> create BE DAIs.
> 
> And how about the BE DAI links?
> They are also physical hardware things. Could we also let topology 
> configure those that can be changed by SW on the BE link, instead of 
> letting topology create the BE links?
> 

Yes, the topology should be able to configure the physical link SW
params as the link may be used for multiple use cases on multiple
different devices with the same FW binary. Each use case or device will
possibly require a different BE DAi link configuration.

Liam
