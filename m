From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 1/2] dt-bindings: Document STM32 I2S
	bindings
Date: Wed, 12 Apr 2017 08:30:31 +0000
Message-ID: <86a179ad-7961-18f7-8050-25e0e584c77d@st.com>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
 <20170411211040.htrcedus3c57fbed@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E7D5C266884
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 10:30:34 +0200 (CEST)
In-Reply-To: <20170411211040.htrcedus3c57fbed@sirena.org.uk>
Content-Language: en-US
Content-ID: <BACBF3D0996F4A4E89E150351BD2B8AD@st.com>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin GAIGNARD <benjamin.gaignard@st.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 04/11/2017 11:10 PM, Mark Brown wrote:
> On Tue, Apr 11, 2017 at 03:44:52PM +0000, Olivier MOYSAN wrote:
>
>> However, regarding STM32 I2S driver, I'm wondering if selecting DAI
>> is the best way to configure interface as tx, rx or fd.
>
> Why do you even need to configure this?
>

The IP provides two data wires, SD in and SD out. So it can be 
configured either as capture or playback only, or full-duplex.
This corresponds to a mode selection through a register configuration.

>> Maybe, it is more relevant to configure DAI according to DMA
>> configuration from I2S node.
>> This would moreover avoid to allocate 2 dmas channels when not
>> necessary (tx or rx only).
>> If you agree with this, I will implement this change in a v2.
>
> That sounds wrong, I'd expect this wiring to be done statically as part
> of the .dtsi for the SoC (or just grabbed as needed at runtime if
> things are flexbile enough) rather than being a configuration thing done
> per board...  I had thought that this was configuration reflecting
> different ways of taping out the IP with different feature sets, is that
> not the case?
>

This configuration is board dependent. The IP may be used as rx, tx or 
fd depending on board. So I think it can make sense to have a DMA 
configuration linked to board, and to set IP mode accordingly.

BRs
olivier
