From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
Date: Wed, 15 Feb 2017 14:59:18 +0100
Message-ID: <40633f7c-a2ac-1658-cc9d-b30eaff8a95a@st.com>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
 <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 1D034265142
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 14:59:23 +0100 (CET)
In-Reply-To: <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Olivier MOYSAN <olivier.moysan@st.com>, "kernel@stlinux.com" <kernel@stlinux.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Alexandre TORGUE <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 02/14/2017 06:16 PM, Mark Brown wrote:
> On Mon, Feb 13, 2017 at 05:38:26PM +0100, Arnaud Pouliquen wrote:
>> From: olivier moysan <olivier.moysan@st.com>
>> 
>> Add copy support in pcm damengine operations. As example, this
>> allows to: - process data before rendering (IEC status
>> insertion), - process captured sample ( sample mask and shift).
> 
> dmaengine with copy...  so not DMA at all?  I'm a bit confused
> about why we're extending the dmaengine code to have a copy
> operation rather than just writing driver code.
> 

For DFSDM we need to re-arrange samples after DMA transfer, before
sending them to application.
For this, a copy ops(called in snd_pcm_lib_read_transfer) alreday exists
in snd_pcm_ops struct.
This ops is not available at soc dma engine level, so at ASoC driver
level.
Aim of this patch is to expose the copy in driver. DMA is still used,
copy ops just allows to handle the copy_to_user in driver.
Advantage of this add-on is that we still able to take benefice of the
generic DMA in DFSDM driver.
Now if you estimate that it is too stm32 SOC specific, the other
solution is to handle directly the PCM platform device in DFSDM driver.

Regards
Arnaud
