From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: compress: add num_sample_rates in
	snd_codec_desc
Date: Wed, 8 Jan 2014 09:46:16 +0530
Message-ID: <20140108041616.GD16227@intel.com>
References: <1389111942-20810-1-git-send-email-vinod.koul@intel.com>
 <20140107173510.GD31886@sirena.org.uk>
 <s5h8uurpu40.wl%tiwai@suse.de>
 <20140107174751.GG31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 646772616FF
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 06:17:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140107174751.GG31886@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 07, 2014 at 05:47:51PM +0000, Mark Brown wrote:
> On Tue, Jan 07, 2014 at 06:41:35PM +0100, Takashi Iwai wrote:
> 
> > The previous commit for sample_rates[] already broke it, so it doesn't
> > matter for this commit :)  I applied the update patches since
> > snd_codec_desc isn't used anywhere in the upstream code, and this is
> > the request from Vinod, so he must know well the ABI regression if it
> > really matters.
> 
> Yeah, it's not just Vinod though.  Like I say pushing to stable so
> anyone trying to build on top of it might be the best thing, can't
> remember if that happend with the previous change or not.
The changes to othere like 64bit ones were marked to stable. The descriptor ones
werent as we dont have users. But yes agree to your point that folks might be
still on LTS kernel. I will send commit ids to Greg after it gets merged to Linus
tree

-- 
~Vinod
