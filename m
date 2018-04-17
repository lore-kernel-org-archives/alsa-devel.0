From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 0/3] ASoC: stm32: sai: add support of
	iec958 controls
Date: Tue, 17 Apr 2018 08:29:17 +0000
Message-ID: <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E02F92673D2
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 10:29:33 +0200 (CEST)
In-Reply-To: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
Content-Language: en-US
Content-ID: <2457FA169E377F43A07A71F8D69433AF@st.com>
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
Cc: "jsarha@ti.com" <jsarha@ti.com>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, Benjamin GAIGNARD <benjamin.gaignard@st.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Hello,

I guess the blocking patch in this patchset is the patch "add IEC958 
channel status control helper". This patch has been reviewed several 
times, but did not get a ack so far.
If you think these helpers will not be merged, I will reintegrate the 
corresponding code in stm driver.
Please let me know, if I need to prepare a v2 without helpers, or if we 
can go further in the review of iec helpers patch ?

Best regards
olivier


On 03/13/2018 05:27 PM, Olivier Moysan wrote:
> This patchset adds support of iec958 controls to STM32 SAI driver.
> 
> The patch makes use of iec958 control status helpers previously proposed
> and discussed through the following threads:
> https://patchwork.kernel.org/patch/8062601/
> https://patchwork.kernel.org/patch/8091551/ (v2)
> https://patchwork.kernel.org/patch/8462961/ (v3)
> https://patchwork.kernel.org/patch/8533731/ (v4)
> 
> Olivier Moysan (3):
>    ALSA: pcm: add IEC958 channel status control helper
>    ASoC: stm32: sai: add iec958 controls support
>    ASoC: dmaengine_pcm: document process callback
> 
>   include/sound/dmaengine_pcm.h |   2 +
>   include/sound/pcm_iec958.h    |  19 +++++++
>   sound/core/pcm_iec958.c       | 114 ++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/stm/Kconfig         |   1 +
>   sound/soc/stm/stm32_sai_sub.c | 101 ++++++++++++++++++++++++++++++++-----
>   5 files changed, 225 insertions(+), 12 deletions(-)
> 
