From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] sound: codec: tlv320aic3x: remove mono
	controls
Date: Fri, 17 Jun 2011 16:04:01 +0300
Message-ID: <20110617160401.67de0010.jhnikula@gmail.com>
References: <1308310827-4312-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A8D7103813
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 15:02:31 +0200 (CEST)
Received: by bwz10 with SMTP id 10so434792bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2011 06:02:28 -0700 (PDT)
In-Reply-To: <1308310827-4312-1-git-send-email-j.weitzel@phytec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

[Cc'ing s/roonie/broonie/]

On Fri, 17 Jun 2011 13:40:27 +0200
Jan Weitzel <j.weitzel@phytec.de> wrote:

> if codec driver is used for AIC3X_MODEL_3007 the mono iout controls overwrite
> registers for class-d amplifier.
> classd amplifier controls are only used for AIC3X_MODEL_3007.
> 
> Removing all mono snd_kcontrol_new, snd_soc_dapm_widget, snd_soc_dapm_route
> and aic3x_init stuff from common code and call only for not AIC3X_MODEL_3007
> codecs.
> 
> Testet only with AIC3X_MODEL_3007
> 
> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> ---
>  sound/soc/codecs/tlv320aic3x.c |  106 ++++++++++++++++++++++++---------------
>  1 files changed, 65 insertions(+), 41 deletions(-)
> 
with aic34,

Tested-by: Jarkko Nikula <jhnikula@gmail.com>
