From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: imx-wm8962: Use a single private
	structure
Date: Mon, 26 Feb 2018 10:59:20 -0800
Message-ID: <20180226185920.GA24671@Asurada-Nvidia>
References: <1519670997-15274-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f178.google.com (mail-pf0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id C974D266F68
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 19:59:13 +0100 (CET)
Received: by mail-pf0-f178.google.com with SMTP id a16so1065449pfn.9
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 10:59:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1519670997-15274-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, shengjiu.wang@nxp.com, broonie@kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, leonard.crestez@nxp.com, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 26, 2018 at 03:49:57PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Commit 8f7206d69ab8c ("ASoC: imx-wm8962: Remove global variables")
> ended up by assigning the same value for two different structs:
> 
> struct imx_priv *priv = snd_soc_card_get_drvdata(card);
> struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
> 
> Fix it by consolidating all the private data into a single structure.
 
Instead of having this fix to this driver, I would consider about
removing it as I don't see any reason of having it any more since
fsl-asoc-card does the same job. Agree?
