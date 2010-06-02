From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2 1/3]AsoC/nuc900: patch for
 SUBSTREAM_TYPE', 'PCM_TX' and 'PCM_RX' removal
Date: Wed, 02 Jun 2010 10:43:07 +0100
Message-ID: <1275471787.3037.28.camel@odin>
References: <4C05F211.7070308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5356F245F4
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 11:43:12 +0200 (CEST)
Received: by wwf26 with SMTP id 26so2251274wwf.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2010 02:43:11 -0700 (PDT)
In-Reply-To: <4C05F211.7070308@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-06-02 at 13:54 +0800, Wan ZongShun wrote:
> This patch is to remove the 'SUBSTREAM_TYPE','PCM_TX' and 'PCM_RX' definition.
> 
> There is no need to redefine SNDRV_PCM_STREAM_PLAYBACK as PCM_TX,
> the SUBSTREAM_TYPE(substream) can be deleted too, the playback or record can be
> judged by 'if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)' directly rather
> than 'if (PCM_TX == stype)', which makes the codes easy to read.
> 
> Signed-off-by: Wan ZongShun<mcuos.com@gmail.com>

All 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
