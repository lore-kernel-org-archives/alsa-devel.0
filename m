From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/6] ASoC: omap-pcm: Request the DMA
 channel by name when dma_name is set for the dai
Date: Thu, 11 Jul 2013 14:30:18 +0200
Message-ID: <51DEA55A.2060301@ti.com>
References: <1373537930-10467-1-git-send-email-peter.ujfalusi@ti.com>
 <1373537930-10467-3-git-send-email-peter.ujfalusi@ti.com>
 <51DE9369.7090703@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 242A82657CC
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 14:30:22 +0200 (CEST)
In-Reply-To: <51DE9369.7090703@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 07/11/2013 01:13 PM, Lars-Peter Clausen wrote:
> I'd prefer not having to have to add a field for a OMAP specific hack to =
the
> generic struct.

I thought that it might be usable for others later, but yeah. It is OMAP
specific right now.

> Two options which are  in my opinion better:
> =

> 1) Just use filter_data in both cases and check rtd->cpu_dai->dev.of_node=
 to
> see whether to use it as the name to dma_request_slave_channel or as
> filter_data for snd_dmaengine_pcm_open_request_chan.

I'll stick with this one since I do not want to create a header file just f=
or
the omap_pcm_filter_data...
I'll send the v2 in a couple of minutes (I have already tested it).

Thanks,
P=E9ter
