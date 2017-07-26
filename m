From: "N, Harshapriya" <harshapriya.n@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Fix Kabylake machine driver
 for pops and clicks
Date: Wed, 26 Jul 2017 20:47:31 +0000
Message-ID: <6030C7A2BCC49F4EBE16F6749B0C7F1A06D828D5@ORSMSX102.amr.corp.intel.com>
References: <1501021659-8597-1-git-send-email-harshapriya.n@intel.com>
 <20170726114943.dr4wktsn25vifcvb@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 82A00266B1C
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 22:47:36 +0200 (CEST)
In-Reply-To: <20170726114943.dr4wktsn25vifcvb@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, July 26, 2017 4:50 AM
> To: N, Harshapriya <harshapriya.n@intel.com>
> Cc: tiwai@suse.de; Koul, Vinod <vinod.koul@intel.com>; alsa-devel@alsa-
> project.org
> Subject: Re: [PATCH] ASoC: Intel: Fix Kabylake machine driver for pops and
> clicks
> 
> On Tue, Jul 25, 2017 at 03:27:39PM -0700, Harsha Priya wrote:
> > This patch adds fixes for the following issues in Kabylake machine
> > driver
> >
> > 1. crackling noise in rt5663 headset codec 2. enabling 4 slot IV
> > feedback for max98927 speaker amp codec 3. pop noise while recording
> > from rt5514 dmic codec
> 
> This is three different fixes so I'd expect to see three different patches and
> the changelog doesn't describe what the fixes actually do so it's much harder
> to review.
I am sending a patch series with 3 patches in it each fixing one issue. I have tried
explaining in detail the fix in the commit message as well. 
