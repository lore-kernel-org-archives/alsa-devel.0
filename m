From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
Date: Thu, 13 Apr 2017 08:01:34 +0000
Message-ID: <a87748e4-21e7-f65a-5be1-fe4f60bdfbef@st.com>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
 <20170411211040.htrcedus3c57fbed@sirena.org.uk>
 <86a179ad-7961-18f7-8050-25e0e584c77d@st.com>
 <20170412113251.nfyk5sw6c5pnpmwr@sirena.org.uk>
 <d886a9c7-ca46-f37a-0e82-6ed8d7a4e052@st.com>
 <20170412153831.r2urwvfseipfsrsi@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170412153831.r2urwvfseipfsrsi@sirena.org.uk>
Content-Language: en-US
Content-ID: <61595464C201CA45AB5F85AA62B5B662@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin GAIGNARD <benjamin.gaignard@st.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 04/12/2017 05:38 PM, Mark Brown wrote:
> On Wed, Apr 12, 2017 at 12:58:16PM +0000, Olivier MOYSAN wrote:
>> On 04/12/2017 01:32 PM, Mark Brown wrote:
>
>>> It is totally normal to just not use one direction in a given system, we
>>> don't normally need to do anything special to handle things.  I'm a bit
>>> confused as to what's different here and needs configuring?
>
>> The IP does not provide an audio channel configured either as rx or tx.
>> I agree, that in such case, the cpu driver does not generally need
>> to worry about direction and there is nothing special required to handle it.
>
> No, that's not what I'm saying - such hardware would be extremely
> unusual.
>
>> Here the IP provides 2 channels, 1 tx and 1 rx,  which may be active or
>> not. The driver has to know which channel is used, and if both channels
>> have to be managed. The affected registers depend on selected channel.
>
> This sounds like essentially every audio controller out there.  The
> overwhelming majority of controllers do exactly as you describe and have
> both directions in the same IP, this really doesn't seem at all unusual.
> Off the top of my head I can only think of one SoC family which combines
> multiple IPs to do bidirectional audio (though I didn't check).
>
> It really feels like there is something different here and I'm just
> missing it.
>

Yes, I think I need to give more details on design choices.

The IP provides 2 channels.
I can see mainly 3 solutions to link dais to these channels:

1) 2 static dais NOT exclusive
	- dai tx
	- dai rx
The IP exhibits a mode register, where you select mode TX, RX or FD.
There are 2 two options to manage this register.
option 1:
	start first channel with mode RX or TX
	when second channel is started, mode has to be changed to FD.
	Transfers have to be stopped before changing configuration
	registers, so this leads to cuts in audio stream.
option 2:
	start a first channel with mode FD.
	In this case, we may have unpredictable behavior for the stream
	which is not already started. probably underrun/overrun.
So, this solution rises problem for full-duplex management.

2) 3 static dais exclusive
	- dai tx
	- dai rx
	- dai rx-tx (fd)
This is the current implementation.
The choice of the dai is done at probe time. It is provided by DT 
through sound-dai parameter.
When dai fd is selected, after starting first stream, we assume that
second stream will be started. In this case we wait for second stream
to be available before enabling IP and starting transfers.

3) 1 dynamic dai
	- dai rx or tx or fd (according to dma conf in IP node)
Here the driver exposes only a single dai constructed from dma 
configuration provided by IP DT node.
This allows to get ride of sound-dai parameter.
This was my suggestion after Rob comments on DT bindings.

Hope this will help clarifying design constraints.

>> Moreover specific processing has to be performed if both channels are used.
>
> Given that this case has to be supported anyway I'd be more inclined to
> ask the question the other way around TBH.
>

Best regards
olivier
