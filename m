From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 0/2] fsl-ssi fixups
Date: Thu,  9 Jan 2014 11:16:09 +0100
Message-ID: <1389262571-12489-1-git-send-email-mpa@pengutronix.de>
References: <20140108172144.GP31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140108172144.GP31886@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks, here are the two fixups for the series. The binding documentation did
not contain a list of compatibles yet, so I added it.

Regards,

Markus


Markus Pargmann (2):
  ASoC: fsl-ssi doc: Add list of supported compatibles
  ASoC: fsl-ssi: Fix stats compile warning

 Documentation/devicetree/bindings/sound/fsl,ssi.txt | 7 ++++++-
 sound/soc/fsl/fsl_ssi.c                             | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
1.8.5.2
