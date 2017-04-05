From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v3 1/2] ASoC: fsl_ssi: Remove
	FSLSSI_I2S_RATES definition
Date: Wed, 5 Apr 2017 14:51:32 -0500
Message-ID: <cb60cac1-fc9d-68b4-ee23-3637240c53b1@tabi.org>
References: <1491421446-13799-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id EB608266943
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 21:51:35 +0200 (CEST)
In-Reply-To: <1491421446-13799-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/05/2017 02:44 PM, Fabio Estevam wrote:
> 
> The comment for the FSLSSI_I2S_RATES definition states that the
> driver currently only supports I2S slave mode, which is no longer
> correct.
> 
> As FSLSSI_I2S_RATES is the same as the standard SNDRV_PCM_RATE_CONTINUOUS,
> just remove its definition and its comments to make the code simpler.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

ACK
