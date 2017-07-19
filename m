From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] sound: fsl_dma: remove dma_object path
	member
Date: Tue, 18 Jul 2017 22:12:17 -0500
Message-ID: <2f0aec70-6f29-9472-4137-fe7257186a12@tabi.org>
References: <20170718214339.7774-59-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 3441F266A09
 for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2017 05:12:25 +0200 (CEST)
In-Reply-To: <20170718214339.7774-59-robh@kernel.org>
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
To: Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 7/18/17 4:43 PM, Rob Herring wrote:
> -		dev_err(&pdev->dev, "could not determine resources for %s\n",
> -			ssi_np->full_name);
> +		dev_err(&pdev->dev, "could not determine resources for %pOF\n",
> +			ssi_np);

I think you meant to include this in the other patch.
