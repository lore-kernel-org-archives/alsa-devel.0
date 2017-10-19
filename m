From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [INTERNAL][PATCH 0/7] ASoC: stm32: Add SAI
 synchronization support
Date: Thu, 19 Oct 2017 13:27:41 +0000
Message-ID: <85690d88-046e-7092-465e-4a8942a1cb35@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 18121266DE1
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 15:27:43 +0200 (CEST)
In-Reply-To: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
Content-Language: en-US
Content-ID: <1365B4D93373A64393C075CFB8FACA05@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh@kernel.org" <robh@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Arnaud POULIQUEN <arnaud.pouliquen@st.com>, Benjamin GAIGNARD <benjamin.gaignard@st.com>
List-Id: alsa-devel@alsa-project.org

Please ignore "[INTERNAL]" in subject.
Sorry for this unappropriated header.

On 10/19/2017 03:03 PM, Olivier Moysan wrote:
> This patch-set adds support of synchronization features for SAI interface.
> It also adds minor fixes and improvements.
> 
> Olivier Moysan (7):
>    ASoC: stm32: Add synchronization to SAI bindings
>    ASoC: stm32: sai: Move static settings to DAI init
>    ASoC: stm32: sai: Fix DMA burst size
>    ASoC: stm32: sai: fix stop management in isr
>    ASoC: stm32: sai: Remove spurious IRQs on stop
>    ASoC: stm32: sai: Fix get reset controller
>    ASoC: stm32: sai: Add synchronization support
> 
>   .../devicetree/bindings/sound/st,stm32-sai.txt     |  14 +-
>   sound/soc/stm/stm32_sai.c                          | 162 ++++++++++++++++++++-
>   sound/soc/stm/stm32_sai.h                          |  22 ++-
>   sound/soc/stm/stm32_sai_sub.c                      | 156 +++++++++++++++++---
>   4 files changed, 318 insertions(+), 36 deletions(-)
> 
