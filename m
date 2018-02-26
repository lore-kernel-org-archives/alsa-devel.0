From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: imx-wm8962: Use a single private
	structure
Date: Mon, 26 Feb 2018 16:06:29 -0300
Message-ID: <CAOMZO5Bo1CxMv7+Lt4KoZO9giRVTvBqvQKVU2v=+S8XwCBHpKg@mail.gmail.com>
References: <1519670997-15274-1-git-send-email-festevam@gmail.com>
 <20180226185920.GA24671@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f169.google.com (mail-ot0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 32F90267AA3
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 20:06:30 +0100 (CET)
Received: by mail-ot0-f169.google.com with SMTP id w38so1137809ota.8
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 11:06:30 -0800 (PST)
In-Reply-To: <20180226185920.GA24671@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, "S.j. Wang" <shengjiu.wang@nxp.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 26, 2018 at 3:59 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> Instead of having this fix to this driver, I would consider about
> removing it as I don't see any reason of having it any more since
> fsl-asoc-card does the same job. Agree?

Yes, I think we can remove it as it is easier to maintain a single
machine driver.

I will send a patch for the removal.
