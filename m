From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: mx6: Audio does not work on linux-next 20140107
Date: Tue, 7 Jan 2014 20:28:14 +0800
Message-ID: <20140107122813.GA6750@MrMyself>
References: <CAOMZO5C=TFczzz8CQj6N=N_Z=p26_73SJvSk5cmp9FPVxF+O=A@mail.gmail.com>
 <52CBEDFA.10603@metafoo.de>
 <CAOMZO5C18WJQKJPuK_Pwq=EW0UhFh=9wxc4M4QEGBscZCHim8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DB1B2616F4
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 13:43:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAOMZO5C18WJQKJPuK_Pwq=EW0UhFh=9wxc4M4QEGBscZCHim8g@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Nicolin Chen <b42378@freescale.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jan 07, 2014 at 10:29:48AM -0200, Fabio Estevam wrote:
> Nicolin,
> 
> On linux-next I am no longer able to play audio without the sdma
> firmware (ok, maybe we should handle this topic on another thread).

I haven't tested the linux-next tree with my SabreSD recently. But..would that
be caused by the SDMA firmware version 2? Please try this patch to trick the
original sdma firmware and see if it's gonna work.

Surely, I'll test on my side tomorrow.

Thank you.
Nicolin Chen

--Qxx1br4bt0+wmkIi
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment; filename="0002-firmware-imx-sdma-v2.patch"

>From d033e19003ee4e0e51b617a808cd068899f7fc01 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <b42378@freescale.com>
Date: Wed, 6 Nov 2013 15:06:50 +0800
Subject: [PATCH 2/2] firmware: imx: sdma v2

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 firmware/imx/sdma/sdma-imx6q.bin.ihex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/firmware/imx/sdma/sdma-imx6q.bin.ihex b/firmware/imx/sdma/sdma-imx6q.bin.ihex
index 2e561f0..ceb114b 100644
--- a/firmware/imx/sdma/sdma-imx6q.bin.ihex
+++ b/firmware/imx/sdma/sdma-imx6q.bin.ihex
@@ -1,4 +1,4 @@
-:1000000053444D4101000000010000001C000000AD
+:1000000053444D4102000000010000001C000000AC
 :1000100026000000B40000007A0600008202000002
 :10002000FFFFFFFF00000000FFFFFFFFFFFFFFFFDC
 :10003000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0
-- 
1.8.4


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Qxx1br4bt0+wmkIi--
