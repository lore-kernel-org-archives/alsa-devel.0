From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v4 0/2] sti: add audio interface to the
	hdmi driver
Date: Thu, 28 Apr 2016 14:13:03 +0200
Message-ID: <5721FE4F.4030908@st.com>
References: <1461252554-16522-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 489992661A4
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 14:13:12 +0200 (CEST)
In-Reply-To: <1461252554-16522-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.co>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: alsa-devel@alsa-project.org

Add linux-fbdev diffusion list in loop for patch-set review.

On 04/21/2016 05:29 PM, Arnaud POULIQUEN wrote:
> This patchset implements audio interface in HDMI drm driver. Implementation is based on 
> ASoC generic hdmi codec driver( https://patchwork.kernel.org/patch/8713141/). 
> It also proposes helper functions to compute N and CTS parameters
> according to HDMI 1.4b specification. 
> 
> V4:
>      fixes for "video: hdmi: add helper functions for N and CTS"
>         - typo error and additional comments
>         - cts_1_ratio computation
>         - warning reported by kbuild test robot
>         - add rounded value for 297/1.001 MHz
> 
> V3: 
>      - video: hdmi: add helper function for N and CTS
>      	  Also used on Mediatek platform (https://patchwork.kernel.org/patch/8887341)
> 	  delta vs V2:
>           - typo fixes
>           - if/else code optimisation
>      - drm: sti: Add ASoC generic hdmi codec support.
> 	  - typo fixes
>           - add audio registers in debugfs information
>                 
> V2: RFC
> https://patchwork.kernel.org/patch/8091531/("video: hdmi: add helper function for N and CTS")
> https://patchwork.kernel.org/patch/8091561/("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")
>      - patch: video: hdmi: add helper function for N and CTS
>          Fixes based on Russel King remarks
>          - Duplicate function to have a separte treatment for coherent and
>            non-coherent clocks
>          - Add ratio field for alternate CTS value
>          - Clock frequency in Hz for TMDS and audio clocks
>          - Add information concerning clocks and CTS calculation. 
> 
> V1: 
> This RFC is the implementation of audio HDMI on sti platform based on generic hdmi-codec driver:
> 	https://patchwork.kernel.org/patch/7215271/ ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")
> 	https://patchwork.kernel.org/patch/8062611/ ("video: hdmi: add helper function for N and CTS")
> Arnaud Pouliquen (2):
>   video: hdmi: add helper functions for N and CTS
>   drm: sti: Add ASoC generic hdmi codec support.
> 
>  drivers/gpu/drm/sti/Kconfig    |   1 +
>  drivers/gpu/drm/sti/sti_hdmi.c | 248 ++++++++++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/sti/sti_hdmi.h |  13 +++
>  drivers/video/hdmi.c           | 208 ++++++++++++++++++++++++++++++++++
>  include/linux/hdmi.h           |  24 ++++
>  5 files changed, 477 insertions(+), 17 deletions(-)
> 
