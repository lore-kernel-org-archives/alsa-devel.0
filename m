From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/8] ASoC: generic-dmaengine-pcm: Add
 support for half-duplex
Date: Sun, 21 Apr 2013 15:14:38 +0800
Message-ID: <20130421071436.GA10647@S2101-09.ap.freescale.net>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 by alsa0.perex.cz (Postfix) with ESMTP id B786D26109F
 for <alsa-devel@alsa-project.org>; Sun, 21 Apr 2013 09:14:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1366478947-9377-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 20, 2013 at 07:29:00PM +0200, Lars-Peter Clausen wrote:
> Some platforms which are half-duplex share the same DMA channel between the
> playback and capture stream. Add support for this to the generic dmaengine PCM
> driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Patch 1 ~ 4,

Tested-by: Shawn Guo <shawn.guo@linaro.org>
