From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: dmaengine: Correct Makefile when
 sound is built as module
Date: Tue, 09 Oct 2012 11:07:11 +0200
Message-ID: <5073E93F.7090507@ti.com>
References: <1349083766-17076-1-git-send-email-peter.ujfalusi@ti.com>
 <20121009065836.GT8237@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
 [74.125.149.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 7692226262A
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 11:05:44 +0200 (CEST)
Received: by mail-ob0-f179.google.com with SMTP id lz20so4312626obb.38
 for <alsa-devel@alsa-project.org>; Tue, 09 Oct 2012 02:05:43 -0700 (PDT)
In-Reply-To: <20121009065836.GT8237@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 10/09/2012 08:58 AM, Mark Brown wrote:
> On Mon, Oct 01, 2012 at 12:29:26PM +0300, Peter Ujfalusi wrote:
> =

>> soc-dmaengine-pcm library need to be part of the snd-soc-core in order to
>> be able to compile ASoC as modules when dmaengine is enabled on the plat=
form.
> =

> I also meant to ask...  what's the actual issue here?

When we build sound as modules for OMAP which has been converted to dmaengi=
ne:

ERROR: "snd_hwparams_to_dma_slave_config" [sound/soc/omap/snd-soc-omap.ko]
undefined!
ERROR: "snd_dmaengine_pcm_pointer" [sound/soc/omap/snd-soc-omap.ko] undefin=
ed!
ERROR: "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_close" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_get_chan" [sound/soc/omap/snd-soc-omap.ko] undefi=
ned!
ERROR: "snd_dmaengine_pcm_trigger" [sound/soc/omap/snd-soc-omap.ko] undefin=
ed!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2


-- =

P=E9ter
