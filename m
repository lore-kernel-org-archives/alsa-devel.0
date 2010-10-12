From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: fsi: simultaneous
 playback/recorde support
Date: Tue, 12 Oct 2010 10:41:07 +0100
Message-ID: <1286876467.3267.30.camel@odin>
References: <w3pbp70rpoq.wl%kuninori.morimoto.gx@renesas.com>
	<w3paamkrpn6.wl%kuninori.morimoto.gx@renesas.com>
	<1286875157.3267.8.camel@odin>
	<w3pocazrc1b.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 20D081039A6
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 11:41:09 +0200 (CEST)
Received: by wyb32 with SMTP id 32so2631247wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2010 02:41:08 -0700 (PDT)
In-Reply-To: <w3pocazrc1b.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-10-12 at 18:33 +0900, Kuninori Morimoto wrote:
> Dear Liam
> 
> Thank you for your checking patch
> 
> > > +/* is */
> > > +#define IS_PLAY		1
> > > +#define IS_CAPTURE	0
> > 
> > Please use SNDRV_PCM_STREAM_PLAYBACK and SNDRV_PCM_STREAM_CAPTURE here.
> 
> understand but ...
> I think
> SNDRV_PCM_STREAM_PLAYBACK = 0
> SNDRV_PCM_STREAM_CAPTURE  = 1
> 
> But in fsi driver, IS_PLAY needs 1,  IS_CAPTURE needs 0 for now.
> should I modify all of these ?

Yes, we need to keep consistency with ALSA.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
