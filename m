From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 04/11] IIO: add DT bindings for stm32
	DFSDM filter
Date: Fri, 24 Mar 2017 09:37:32 -0500
Message-ID: <20170324143732.nvq2wfra6q3hcrhs@rob-hp-laptop>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-5-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 71FC32669DD
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 15:37:34 +0100 (CET)
Received: by mail-oi0-f66.google.com with SMTP id l203so357284oia.3
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 07:37:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1489759704-30217-5-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, olivier moysan <olivier.moysan@st.com>, kernel@stlinux.com, Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 17, 2017 at 03:08:17PM +0100, Arnaud Pouliquen wrote:
> Add bindings that describes Digital Filter for Sigma Delta
> Modulators. DFSDM allows to connect sigma delta
> modulators.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> V2->V3:
>    Fixes based on V2 comments
> 
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        | 120 +++++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt

Acked-by: Rob Herring <robh@kernel.org>
