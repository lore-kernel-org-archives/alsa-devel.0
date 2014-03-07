From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: compress: dpcm_path_get called in wrong place
Date: Fri, 07 Mar 2014 18:28:59 +0000
Message-ID: <1394216939.2419.37.camel@loki>
References: <CAES_P+9RrhOGip61Lyb-fq2JgrHZGhifLtoY=LY6_jwbEoJnAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 12A6726524F
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 19:29:36 +0100 (CET)
In-Reply-To: <CAES_P+9RrhOGip61Lyb-fq2JgrHZGhifLtoY=LY6_jwbEoJnAA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: noman pouigt <variksla@gmail.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2014-03-06 at 23:52 -0800, noman pouigt wrote:
> Shouldn't  dpcm_path_get be called earlier ? I think it should be
> called earlier as happens in soc-pcm file.
> 
> static int soc_compr_open_fe(struct snd_compr_stream *cstream)
> {
> 
> if (dpcm_path_get(fe, stream, &list) <= 0) {
> dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
> fe->dai_link->name, stream ? "capture" : "playback");
> 
> In current code we open platform driver and then machine startup function
> gets called. After this we check for valid path which i think should happen
> earlier i.e. in the beginning of soc_compr_open_fe function.
> 
> If you agree, then i will send a patch.

I don't think it's making any difference atm, but for consistency with
dpcm_fe_dai_open() we could re-order. Fwiw, the open functions don't use
any data from the path check yet, but I suppose they could in the
future. Please submit a patch and also CC Mark Brown with your patch.

Thanks

Liam
