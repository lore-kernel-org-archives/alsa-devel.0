From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 2/3] ASoC: fsl_ssi: Add dual fifo mode support
Date: Tue, 29 Oct 2013 08:00:44 -0500
Message-ID: <526FB17C.3090009@tabi.org>
References: <cover.1383047327.git.b42378@freescale.com> <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>,<526FAD41.2000805@tabi.org> <flq2m8se8fxm4icha4yrpcbn.1383051217235@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <flq2m8se8fxm4icha4yrpcbn.1383051217235@email.android.com>
Sender: linux-doc-owner@vger.kernel.org
To: Chen Guangyu-B42378 <B42378@freescale.com>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Huang Shijie-B32955 <B32955@freescale.co>
List-Id: alsa-devel@alsa-project.org

Chen Guangyu-B42378 wrote:
> Without dual fifo support,  handware underrun would occasionally
> occur and then two audio channels would physically swap. This could
> be easily reproduced in low bus frequency situation, while it would
> be better if we enable dual fifo.

Ok.

ACK.
