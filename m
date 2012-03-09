From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcbsp: fix
	snd_pcm_hw_rule_add arguments
Date: Fri, 09 Mar 2012 14:02:00 +0200
Message-ID: <4F59F138.30909@ti.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
	<1331248757-3408-2-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009amx259.postini.com (na3sys009aog130.obsmtp.com
	[74.125.149.143])
	by alsa0.perex.cz (Postfix) with ESMTP id B010410BA33
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:02:04 +0100 (CET)
Received: by mail-lpp01m010-f54.google.com with SMTP id v3so1949003lag.41
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 04:02:03 -0800 (PST)
In-Reply-To: <1331248757-3408-2-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 03/09/2012 01:19 AM, Grazvydas Ignotas wrote:
> We are setting SNDRV_PCM_HW_PARAM_BUFFER_SIZE based on
> SNDRV_PCM_HW_PARAM_CHANNELS, not vice versa. This bug didn't
> have much impact because the rules are evaluated multiple times
> by the core, and intended value got set eventually.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
