From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 0/5][RFC] ASoC: remove Codec/Platform code
Date: Mon, 09 Apr 2018 08:37:19 +0100
Message-ID: <1523259439.6457.22.camel@linux.intel.com>
References: <87muydf7t2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id C3537266C1C
 for <alsa-devel@alsa-project.org>; Mon,  9 Apr 2018 09:37:24 +0200 (CEST)
In-Reply-To: <87muydf7t2.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2018-04-09 at 02:14 +0000, Kuninori Morimoto wrote:
> Hi Mark
> 
> Now, all Codec/Platform are replaced to Component.
> Codec/Platform related code are no longer needed,
> these patches remove these.
> 
> But I added [RFC] on these patches because,
>  1) people want to check/test
>  2) Media related added new driver is using Codec/Platform style
> 
> I'm posting replace patch for 2) to Media / ASoC ML,
> but not yet accepted.
> (= I think it needs Mark's Acked-by ? I don't know)
> I think this Codec/Platform remove patch should based on it,
> otherwise, compile error happen.
> I'm happy to re-post this remove patch if Media side replace was accepted.
> 
> 

All 

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
