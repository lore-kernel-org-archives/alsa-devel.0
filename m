From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1] ASoC: fsl_esai: replace fall-through
	with break
Date: Tue, 9 Apr 2019 20:51:00 -0700
Message-ID: <20190410035059.GA8844@Asurada>
References: <66c117128f300b0ec5f278f538412789c78b60a6.1554715589.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 949EFF8068A
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 05:51:07 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id 9so545192pfj.13
 for <alsa-devel@alsa-project.org>; Tue, 09 Apr 2019 20:51:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <66c117128f300b0ec5f278f538412789c78b60a6.1554715589.git.shengjiu.wang@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "gustavo@embeddedor.com" <gustavo@embeddedor.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 08, 2019 at 09:28:06AM +0000, S.j. Wang wrote:
> case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be independent of
> each other, so replace fall-through with break.
> 
> Fixes: 16bbeb2b43c3 ("ASoC: fsl_esai: Mark expected switch fall-through")
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
