From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 1/2] dt-bindings: Document STM32 I2S
	bindings
Date: Thu, 27 Apr 2017 15:57:51 +0000
Message-ID: <7005b06f-457c-90f4-bdf1-bed75c565063@st.com>
References: <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
 <20170411211040.htrcedus3c57fbed@sirena.org.uk>
 <86a179ad-7961-18f7-8050-25e0e584c77d@st.com>
 <20170412113251.nfyk5sw6c5pnpmwr@sirena.org.uk>
 <d886a9c7-ca46-f37a-0e82-6ed8d7a4e052@st.com>
 <20170412153831.r2urwvfseipfsrsi@sirena.org.uk>
 <a87748e4-21e7-f65a-5be1-fe4f60bdfbef@st.com>
 <20170426161553.oc5pozga53ttypyq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 302EC2671F3
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 17:57:55 +0200 (CEST)
In-Reply-To: <20170426161553.oc5pozga53ttypyq@sirena.org.uk>
Content-Language: en-US
Content-ID: <B1BE832AE22B1047A525FF9178AE3688@st.com>
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

On 04/26/2017 06:15 PM, Mark Brown wrote:
> On Thu, Apr 13, 2017 at 08:01:34AM +0000, Olivier MOYSAN wrote:
>
>> 1) 2 static dais NOT exclusive
>> 	- dai tx
>> 	- dai rx
>> The IP exhibits a mode register, where you select mode TX, RX or FD.
>> There are 2 two options to manage this register.
>> option 1:
>> 	start first channel with mode RX or TX
>> 	when second channel is started, mode has to be changed to FD.
>> 	Transfers have to be stopped before changing configuration
>> 	registers, so this leads to cuts in audio stream.
>> option 2:
>> 	start a first channel with mode FD.
>> 	In this case, we may have unpredictable behavior for the stream
>> 	which is not already started. probably underrun/overrun.
>> So, this solution rises problem for full-duplex management.
>
>> 2) 3 static dais exclusive
>> 	- dai tx
>> 	- dai rx
>> 	- dai rx-tx (fd)
>> This is the current implementation.
>> The choice of the dai is done at probe time. It is provided by DT
>> through sound-dai parameter.
>> When dai fd is selected, after starting first stream, we assume that
>> second stream will be started. In this case we wait for second stream
>> to be available before enabling IP and starting transfers.
>
>> 3) 1 dynamic dai
>> 	- dai rx or tx or fd (according to dma conf in IP node)
>> Here the driver exposes only a single dai constructed from dma
>> configuration provided by IP DT node.
>> This allows to get ride of sound-dai parameter.
>
> None of these options reflect how normal I2S controllers present
> themselves in DT.  To repeat, you should present a single bidirectional
> DAI for the single physical bidirectional I2S controller that your
> hardware has.
>
> If it's not possible to figure out a way to make the controller support
> simultaneous playback and record with the two started independently then
> the driver should just return an error if userspace tries to start the
> second direction up.  This will severely limit the utility of the driver
> as Linux generally treats playback and record independently but that's
> going to apply just as much with any of the options involving multiple
> DAIs or configuration in DT.  You might be able to do something with
> feeding it dummy data I guess?
>

Ok. I will implement a single bidirectional DAI in v2.

Best regards
Olivier
