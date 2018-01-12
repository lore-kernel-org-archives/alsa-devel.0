From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 00/38] ASoC: replace platform to component
Date: Fri, 12 Jan 2018 09:46:06 +0000
Message-ID: <1515750366.1844.416.camel@linux.intel.com>
References: <87vag7gb9o.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 72670267A5A
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 10:46:11 +0100 (CET)
In-Reply-To: <87vag7gb9o.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Fri, 2018-01-12 at 00:41 +0000, Kuninori Morimoto wrote:
> Hi Mark
> 
> codec/platform can be replaced to component now.
> These patches do it for platform.
> One none is that all platform should be based [01/38] patch.
> These are based on "asoc-v4.16" tag
> 
> Current existing "platform" related codes will be no longer
> needed by these patches.
> I can post it, but I don't know when is good timing
> 

This is good stuff ! 

Btw, did you manage to test build/run on most of the architectures ? I
remember this was one of the difficulties I had when doing the initial
multi-component support (before linux-next could build all the
architectures).

Thanks

Liam
