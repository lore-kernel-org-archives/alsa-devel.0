From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Date: Thu, 28 Feb 2019 20:50:42 -0800
Message-ID: <20190301045041.GA5064@Asurada>
References: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59386F8073C
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 05:50:51 +0100 (CET)
Received: by mail-pl1-x642.google.com with SMTP id q3so10864775pll.4
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 20:50:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi Shengjiu,

On Thu, Feb 28, 2019 at 05:56:31AM +0000, S.j. Wang wrote:
> cs42xx8 is a 24-bit A/D and 24-bit D/A device, so the S32_LE
> should not be in the supported format list.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/codecs/cs42xx8.c | 3 +--

This is for cs42xx8 codec driver, but its maintainers aren't
seemly in To/Cc list. Please run ./scripts/get_maintainer.pl
for it and resend.
