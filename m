From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [RFC PATCH 2/2] ASoC: select sysclk clock from
 mlck clock provider in wm8994 driver
Date: Fri, 15 Dec 2017 15:15:22 +0000
Message-ID: <43426b67-3546-8422-7fcb-9fa1ff192679@st.com>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-3-git-send-email-olivier.moysan@st.com>
 <20171214173624.GM9788@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 61308266D45
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 16:15:28 +0100 (CET)
In-Reply-To: <20171214173624.GM9788@sirena.org.uk>
Content-Language: en-US
Content-ID: <AD8248A230597440B736B23B6327F411@st.com>
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
Cc: Benjamin GAIGNARD <benjamin.gaignard@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

Thanks for your comment.

On 12/14/2017 06:36 PM, Mark Brown wrote:
> On Thu, Dec 14, 2017 at 05:53:58PM +0100, Olivier Moysan wrote:
>> When defined in device tree, MCLK1 and MCLK2 are used
>> as sysclk for aif1 and aif2 interfaces respectively.
> 
> That's not a valid assumption as far as I remember?  The AIFs can use
> either MCLK depending on the system configuration I think.
> 

You are right. wm8994 allows to select either MCLK for each AIF.
 From this point of view, the current patch is too limiting.
MCLK information in DT allows to enforce MCLK use, but an additionnal 
information is required to determine AIF MCLK assignment.
Available properties in codec DAI node, such as clocks property, cannot 
help here.

Maybe a DAPM linked to a control is a better way to select AIF source,
When source is not provided by clk_id in wm8994_set_dai_sysclk().
In this case, wm8994_set_dai_sysclk() would only have to check
if clock source is not already set.

Please let me know if this option sounds better to you.

>> If clock rate is let 0, the frequency provided by
>> wm8994_set_dai_sysclk() is used instead.
> 
> I'd expect this the other way around, if we didn't specify a frequency
> then read it from the input otherwise try to use clk_set_rate() to
> propagate things up.
> 

If I implement a control to select the AIF source, I will drop the code
related to mclk clock provider.

Regards
Olivier
