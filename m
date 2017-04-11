From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 1/2] dt-bindings: Document STM32 I2S
	bindings
Date: Tue, 11 Apr 2017 15:44:52 +0000
Message-ID: <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 632352666E1
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 17:44:56 +0200 (CEST)
In-Reply-To: <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
Content-Language: en-US
Content-ID: <BD738E8F3DD83B42AF9D82A2C38AEDCE@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin GAIGNARD <benjamin.gaignard@st.com>
List-Id: alsa-devel@alsa-project.org

Hello Rob, Mark

Thanks for your review.
Please find my comments below.

On 04/11/2017 04:32 PM, Mark Brown wrote:
> On Mon, Apr 10, 2017 at 02:48:32PM -0500, Rob Herring wrote:
>> On Thu, Apr 06, 2017 at 05:40:35PM +0200, olivier moysan wrote:
>
>>> +Required properties:
>>> +  - compatible: Must be "st,stm32h7-i2s"
>>> +  - #sound-dai-cells: Must be 1. (one parameter)
>>> +    This parameter allows to specify CPU DAI index in soundcard CPU dai link.
>>> +	index 0: playback DAI
>>> +	index 1: capture DAI
>>> +	index 2: full duplex DAI
>
>> Is this still needed for graph-card?
>
> The graph card is blocked on your review...  I'm also not clear how
> without something like this we'd be able to identify a specific DAI
> within a device if we don't have a way of identifying them.
>
Yes, it seems that audio graph card does not allow to select a specific 
DAI. This will probably be necessary.

However, regarding STM32 I2S driver, I'm wondering if selecting DAI
is the best way to configure interface as tx, rx or fd.
Maybe, it is more relevant to configure DAI according to DMA
configuration from I2S node.
This would moreover avoid to allocate 2 dmas channels when not
necessary (tx or rx only).
If you agree with this, I will implement this change in a v2.

BRs
olivier
