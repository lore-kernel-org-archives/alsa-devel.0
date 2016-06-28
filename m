From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [RFC 06/11] ASoC: dapm: Create API to add a single
	route element
Date: Tue, 28 Jun 2016 10:52:45 +0530
Message-ID: <20160628052244.GJ14022@subhransu-desktop>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
 <1466999284-14782-7-git-send-email-subhransu.s.prusty@intel.com>
 <20160627180206.GG17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 74B532651E3
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 07:26:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160627180206.GG17217@sirena.org.uk>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 27, 2016 at 07:02:06PM +0100, Mark Brown wrote:
> On Mon, Jun 27, 2016 at 09:17:59AM +0530, Subhransu S. Prusty wrote:
> 
> >  int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
> >  			    const struct snd_soc_dapm_route *route, int num);
> > +int snd_soc_dapm_add_route_single(struct snd_soc_dapm_context *dapm,
> > +			    const struct snd_soc_dapm_route *route);
> 
> Just snd_soc_dapm_add_route() and rename the existing internal function.

Sure.

Thanks
Subhransu



-- 
