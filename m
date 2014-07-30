From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 4/4] ASoC: fsl_ssi: Add stream names for
	DPCM usage
Date: Wed, 30 Jul 2014 07:19:00 -0500
Message-ID: <53D8E2B4.6060009@tabi.org>
References: <cover.1406688048.git.nicoleotsuka@gmail.com>
 <891b9f4edbba81a03c2b8350abc5ccf923db9260.1406688049.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 482CA2608EA
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 14:19:07 +0200 (CEST)
In-Reply-To: <891b9f4edbba81a03c2b8350abc5ccf923db9260.1406688049.git.nicoleotsuka@gmail.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, b42378@freescale.com, b02247@freescale.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Nicolin Chen wrote:
> DPCM needs extra dapm routes in the machine driver to route audio
> between Front-End and Back-End. In order to differ the stream names
> in the route map from CODECs, we here add specific stream names to
> SSI driver so that we can implement ASRC via DPCM to it.
>
> Signed-off-by: Nicolin Chen<nicoleotsuka@gmail.com>

Acked-by: Timur Tabi <timur@tabi.org>
