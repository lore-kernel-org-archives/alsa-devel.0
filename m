From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/3] ASoC: fsl: add imx-es8328 machine
	driver
Date: Tue, 17 Jun 2014 08:26:26 +0200
Message-ID: <539FDF92.8070401@metafoo.de>
References: <1402982189-28598-1-git-send-email-xobs@kosagi.com>
 <1402982189-28598-4-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-086.synserver.de (smtp-out-088.synserver.de
 [212.40.185.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 61BF2265530
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 08:26:37 +0200 (CEST)
In-Reply-To: <1402982189-28598-4-git-send-email-xobs@kosagi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sean Cross <xobs@kosagi.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 06/17/2014 07:16 AM, Sean Cross wrote:
[...]
> +- codec-supply : Power regulator for audio codec chip

If this is the supply for the CODEC it should be part of the CODEC's 
bindings and probably be handled by the CODEC driver.
