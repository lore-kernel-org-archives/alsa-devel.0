From: jassi brar <jassisinghbrar@gmail.com>
Subject: [PATCHES_v1] ASoC: Towards dropping runtime field from
	snd_soc_dai
Date: Mon, 22 Feb 2010 15:55:59 +0900
Message-ID: <1b68c6791002212255j69faa9b7k13da803bf65c2177@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 682072439E
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 07:56:03 +0100 (CET)
Received: by vws13 with SMTP id 13so320022vws.38
	for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2010 22:56:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

<Due to some problem I am unable to send inline patches, please accept
the attached patches for this time>

The following three patches are aimed at discarding runtime field
from struct snd_soc_dai, which comes in the way of working towards
making it possible to share cpu_dai/codec_dai among two or more dai_links.

[PATCH 1/3] ASoC: PLATFORM: Pass dai_link as argument to suspend, resume
	Also a good idea to provide pointer to relevant dai_link to platform
	suspend/resume. It also makes easy traversing the ASOC links to reach
	the substream(when snd_soc_dai.runtime is dropped).

[PATCH 2/3] ASOC: ATMEL: Getting cpu_dai method change
[PATCH 3/3] ASOC: SND_SOC_DAI: Get rid of 'runtime' field

Regards.
