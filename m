From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 09/20] ASoC: omap-hdmi: Bind the
 platform driver to the dai driver when loading
Date: Mon, 21 Apr 2014 14:54:41 +0200
Message-ID: <53551511.50104@metafoo.de>
References: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
 <1397652390-852-10-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-071.synserver.de (smtp-out-071.synserver.de
 [212.40.185.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 044C8261A40
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 14:54:41 +0200 (CEST)
In-Reply-To: <1397652390-852-10-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, notasas@gmail.com, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/16/2014 02:46 PM, Peter Ujfalusi wrote:
[...]
> +	return omap_pcm_platform_register(&pdev->dev);
> +}
>   }
There is a excess } here.
