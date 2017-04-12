From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 1/2] dt-bindings: Document STM32 I2S
	bindings
Date: Wed, 12 Apr 2017 12:58:16 +0000
Message-ID: <d886a9c7-ca46-f37a-0e82-6ed8d7a4e052@st.com>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
 <20170411211040.htrcedus3c57fbed@sirena.org.uk>
 <86a179ad-7961-18f7-8050-25e0e584c77d@st.com>
 <20170412113251.nfyk5sw6c5pnpmwr@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A28C42665D5
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 14:58:20 +0200 (CEST)
In-Reply-To: <20170412113251.nfyk5sw6c5pnpmwr@sirena.org.uk>
Content-Language: en-US
Content-ID: <6F10239CB1489B46B734FA9E915A79F3@st.com>
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

On 04/12/2017 01:32 PM, Mark Brown wrote:
> On Wed, Apr 12, 2017 at 08:30:31AM +0000, Olivier MOYSAN wrote:
>> On 04/11/2017 11:10 PM, Mark Brown wrote:
>
>>> That sounds wrong, I'd expect this wiring to be done statically as part
>>> of the .dtsi for the SoC (or just grabbed as needed at runtime if
>>> things are flexbile enough) rather than being a configuration thing done
>>> per board...  I had thought that this was configuration reflecting
>>> different ways of taping out the IP with different feature sets, is that
>>> not the case?
>
>> This configuration is board dependent. The IP may be used as rx, tx or
>> fd depending on board. So I think it can make sense to have a DMA
>> configuration linked to board, and to set IP mode accordingly.
>
> It is totally normal to just not use one direction in a given system, we
> don't normally need to do anything special to handle things.  I'm a bit
> confused as to what's different here and needs configuring?
>

The IP does not provide an audio channel configured either as rx or tx.
I agree, that in such case, the cpu driver does not generally need
to worry about direction and there is nothing special required to handle it.

Here the IP provides 2 channels, 1 tx and 1 rx,  which may be active or 
not. The driver has to know which channel is used, and if both channels
have to be managed. The affected registers depend on selected channel. 
Moreover specific processing has to be performed if both channels are used.

BRs
olivier
