From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC: Add snd_soc_component_{get,
	set}_drvdata()
Date: Thu, 4 Sep 2014 12:03:52 +0530
Message-ID: <20140904063352.GC1610@intel.com>
References: <1408532929-26978-1-git-send-email-lars@metafoo.de>
 <1408532929-26978-2-git-send-email-lars@metafoo.de>
 <20140903122258.GB1610@intel.com> <540766C9.2060206@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AF592616CB
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 08:54:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <540766C9.2060206@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 03, 2014 at 09:06:49PM +0200, Lars-Peter Clausen wrote:
> On 09/03/2014 02:22 PM, Vinod Koul wrote:
> >On Wed, Aug 20, 2014 at 01:08:46PM +0200, Lars-Peter Clausen wrote:
> >>Add Add snd_soc_component_{get,set}_drvdata() similar to
> >>snd_soc_codec_{get,set}_drvdata() and snd_soc_platform_{get,set}_drvdata().
> >>Also update them to use the new functions internally.
> >>
> >>Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> >Reviewed-by: Vinod Koul <vinod.koul@intel.com>
> 
> Is this for the first patch or for the whole series?
Patch only. The HSW driver changes, I think Liam should ack

-- 
~Vinod
