From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [RFC PATCH 2/2] ASoC: select sysclk clock from
 mlck clock provider in wm8994 driver
Date: Wed, 20 Dec 2017 12:42:10 +0000
Message-ID: <c51bf5a8-27f7-6d76-f4fb-c8884387bdca@st.com>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-3-git-send-email-olivier.moysan@st.com>
 <20171214173624.GM9788@sirena.org.uk>
 <43426b67-3546-8422-7fcb-9fa1ff192679@st.com>
 <20171219093506.GD8563@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 36575266BBC
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 13:42:14 +0100 (CET)
In-Reply-To: <20171219093506.GD8563@sirena.org.uk>
Content-Language: en-US
Content-ID: <1387522FCEF46D46814DDF041B87AEBA@st.com>
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

On 12/19/2017 10:35 AM, Mark Brown wrote:
> On Fri, Dec 15, 2017 at 03:15:22PM +0000, Olivier MOYSAN wrote:
> 
>> You are right. wm8994 allows to select either MCLK for each AIF.
>>   From this point of view, the current patch is too limiting.
>> MCLK information in DT allows to enforce MCLK use, but an additionnal
>> information is required to determine AIF MCLK assignment.
>> Available properties in codec DAI node, such as clocks property, cannot
>> help here.
> 
>> Maybe a DAPM linked to a control is a better way to select AIF source,
>> When source is not provided by clk_id in wm8994_set_dai_sysclk().
>> In this case, wm8994_set_dai_sysclk() would only have to check
>> if clock source is not already set.
> 
>> Please let me know if this option sounds better to you.
> 
> What are you trying to accomplish here?  You appear to be trying to move
> the system clocking configuration from the machine driver to the CODEC
> which is not how things are supposed to work.
> 

As a generic machine, simple or audio graph cards are not able to manage 
codec clock muxing.
If we exclude the management of muxing through codec controls,
the remaining solution is to handle it fully through clock framework.
The current patch only supports a limited range of muxing capabilities 
of the codec.
To have a full management of the muxing, I think it is necessary to add
a device tree node for each codec interface and to define an aif clock 
in these nodes.
Then parent clock assignment of these aif clocks would allow to handle 
the muxing.

Please, let me known if is this the right direction for you.

BRs
olivier
