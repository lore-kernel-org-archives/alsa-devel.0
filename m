From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [MINUTES] Linux Plumbers Audio Mini Conference -
 Santa Fe 2016
Date: Fri, 04 Nov 2016 13:59:26 +0000
Message-ID: <1478267966.27988.8.camel@loki>
References: <1478213478.21597.13.camel@loki>
 <e7fc9e49-6d6a-c224-d045-ef80308e11e0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D3A89266499
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 14:59:39 +0100 (CET)
In-Reply-To: <e7fc9e49-6d6a-c224-d045-ef80308e11e0@ti.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin" <mengdong.lin@linux.intel.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Lai,
 Patrick" <plai@quicinc.com>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>, Eric Laurent <elaurent@google.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2016-11-04 at 10:54 +0200, Peter Ujfalusi wrote:
> Liam,
> 
> On 11/04/2016 12:51 AM, Liam Girdwood wrote:
> > Minutes below. Comments, corrections and omissions welcomed.
> > 
> > We are missing some links to some of the slides presented. Please reply with a link 
> > if you have one.
> 
> Were there any discussion related to 'Move of ASoC clocking into the
> clock API'? Any conclusions, plans?
> 

Sorry, yes this was discussed. Mark had pointed out there was a locking
issue in the clk API preventing it being used in codecs (iirc, in I2C
devices). I think Mark has now discussed with the clock maintainers.

The plan was to use the API after the locking issue was resolved.

Thanks

Liam
