From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: core: Add API for configuration of
 DAI FS
Date: Mon, 16 Sep 2013 11:28:29 +0100
Message-ID: <1379327309.3215.21.camel@loki>
References: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1379092188-7385-4-git-send-email-liam.r.girdwood@linux.intel.com>
 <20130913172604.GM29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E7F22608D3
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 12:28:48 +0200 (CEST)
In-Reply-To: <20130913172604.GM29403@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-09-13 at 18:26 +0100, Mark Brown wrote:
> On Fri, Sep 13, 2013 at 06:09:48PM +0100, Liam Girdwood wrote:
> > Some codec drivers when running in slave mode require that FS is explicitly
> > set by the machine driver as it may not be exactly BCLK/rate.
> > 
> > Extend the DAI API by adding :-
> > 
> > int snd_soc_dai_set_fs(struct snd_soc_dai *dai, unsigned int fs);
> 
> I'm struggling to think of a better name for this right now but the _fs
> name is making me think of the MCLK/SYSCLK rate rather than the BCLK
> rate - lots of clocks get specified as a multiple of the sample rate so
> it's not jumping out which clock.  The best I can come up with is
> _bclk_fs() but perhaps there are better ideas?  Or should we pass in a
> clock ID (and provide standard defines for things like BCLK) so it can
> apply to any clock?
> 

My initial thought was for set_fs(), but this collides with a global FS
macro :(

I'll change the naming so it's set_bclk() and the params to keep it in
line with snd_soc_dai_set_sysclk().

Liam
