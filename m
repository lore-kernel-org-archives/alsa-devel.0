From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: compress: Correct handling of
	compressed ops
Date: Fri, 26 Jan 2018 10:03:51 +0000
Message-ID: <20180126100351.bygmlfndmwiqfsvp@localhost.localdomain>
References: <20180124135525.5633-1-ckeepax@opensource.cirrus.com>
 <87wp06lotn.wl%kuninori.morimoto.gx@renesas.com>
 <20180125094745.rxboofyab5ey5nux@localhost.localdomain>
 <87mv114fz4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B03F267628
 for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2018 11:03:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87mv114fz4.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 26, 2018 at 12:33:53AM +0000, Kuninori Morimoto wrote:
> In existing drivers, the component which have compr_ops *was* originally
> "platform" component only.
> The main purpose why we want to replace platform (and codec) to component is that
> CPU/Codec/Platform categorize is no longer best match for modern device.
> 
> Thus, if we can replace all CPU/Codec/Platform into component, every device
> can have every feature, with no categorize !
> In other words, we don't know how many device have it.
> 

Yeah I think there is quite a lot more work to get to that point
though, we need to understand how we will present this to
user-space.

> But anyway, we don't have such situation, and we don't know how to adjust to it
> at this point.
> Thus Yes !! I can 100% agree your opinion.
> Thank you for your help
> 
> One note is that "rtd->platform" itself will be removed if all platforms were replaced.
> Then, soc_compr_get_component() / soc_compr_get_ops() might be merged or adjusted.
> 

Yes that was my thinking as well, once you remove that you should
only need some minor refactoring to make the updates.

Thanks,
Charles
