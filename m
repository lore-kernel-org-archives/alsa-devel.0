From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: sgtl5000: fix power on/off of MIC
	bias
Date: Thu, 29 Mar 2012 13:56:06 +0800
Message-ID: <20120329055604.GB19506@S2101-09.ap.freescale.net>
References: <1332919833-9641-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AFA14104319
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 07:56:13 +0200 (CEST)
Received: by iakh37 with SMTP id h37so2675183iak.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2012 22:56:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1332919833-9641-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lionel Xu <Lionel.Xu@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Zeng Zhaoming <zengzm.kernel@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 28, 2012 at 03:30:33PM +0800, Shawn Guo wrote:
> From: Lionel Xu <Lionel.Xu@freescale.com>
> 
> There is no sound in the recorded wav, to enable recording, the VAG
> should be powered up, and the mic bias resistor should be set up with
> proper value.
> 
> Signed-off-by: Lionel Xu <lionel.xu@freescale.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Zeng Zhaoming <zengzm.kernel@gmail.com>

Mark, I just send a patch authored by Zeng Zhaoming, which fixes the
problem in a more sensible way.  So please ignore this one.

-- 
Regards,
Shawn
