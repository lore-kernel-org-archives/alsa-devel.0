From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v3 03/11] ASoC: fsl_ssi: Refine all comments
Date: Fri, 15 Dec 2017 22:43:14 -0600
Message-ID: <aad404d3-fa61-3c49-6265-04fc3b256bc6@tabi.org>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
 <1513207108-30430-4-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id DAFA3266B0F
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 05:43:17 +0100 (CET)
In-Reply-To: <1513207108-30430-4-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, caleb@crome.org, mail@maciej.szmigiero.name, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 12/13/17 5:18 PM, Nicolin Chen wrote:
> -	 * We are running on a SoC which does not support online SSI
> -	 * reconfiguration, so we have to enable all necessary flags at once
> -	 * even if we do not use them later (capture and playback configuration)
> +	 * Online configuration is not supported
> +	 * Enable or Disable all necessary bits at once

This is an example of a bad change, IMHO.  The original was written in 
elegant prose.  The new version is just two short sentences.
