From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH v3 1/2] ASoC: stm32: add bindings for SAI
Date: Tue, 2 May 2017 07:45:35 +0000
Message-ID: <5bf88908-37ec-412f-9123-6f90938b5b66@st.com>
References: <1491837596-2924-1-git-send-email-olivier.moysan@st.com>
 <1491837596-2924-2-git-send-email-olivier.moysan@st.com>
 <20170428205358.fxjqaki44xqim4ta@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 8A8B1266D09
 for <alsa-devel@alsa-project.org>; Tue,  2 May 2017 09:45:41 +0200 (CEST)
In-Reply-To: <20170428205358.fxjqaki44xqim4ta@rob-hp-laptop>
Content-Language: en-US
Content-ID: <B69FB7BA43FE884BA4F02D14552C4F7A@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, Benjamin GAIGNARD <benjamin.gaignard@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org

Hello Rob,

On 04/28/2017 10:53 PM, Rob Herring wrote:
> On Mon, Apr 10, 2017 at 05:19:55PM +0200, olivier moysan wrote:
>> This patch adds documentation of device tree bindings for the
>> STM32 SAI ASoC driver.
>>
>> Signed-off-by: olivier moysan <olivier.moysan@st.com>
>> ---
>>  .../devicetree/bindings/sound/st,stm32-sai.txt     | 89 ++++++++++++++++++++++
>>  1 file changed, 89 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>> new file mode 100644
>> index 0000000..c59a3d7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>> @@ -0,0 +1,89 @@
>> +STMicroelectronics STM32 Serial Audio Interface (SAI).
>
> [...]
>
>> +	sai1b: audio-controller@40015824 {
>> +		#sound-dai-cells = <0>;
>> +		compatible = "st,stm32-sai-sub-b";
>> +		reg = <0x40015824 0x1C>;
>> +		clocks = <&rcc 1 CLK_SAI2>;
>> +		clock-names = "sai_ck";
>> +		dmas = <&dma2 5 0 0x400 0x0>;
>> +		dma-names = "tx";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_sai1b>;
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			sai1b_port: port@0 {
>> +				reg = <0>;
>> +				cpu_endpoint: endpoint {
>> +					remote-endpoint = <&codec_endpoint>;
>> +					audio-graph-card,format = "i2s";
>> +					audio-graph-card,bitclock-master = <&codec_endpoint>;
>> +					audio-graph-card,frame-master = <&codec_endpoint>;
>
> These property names are wrong.
>

I have taken into account this comment (and previous ones).
They will be included in next update of this patch set.

>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +audio-codec {
>> +	codec_port: port {
>> +		codec_endpoint: endpoint {
>> +			remote-endpoint = <&cpu_endpoint>;
>> +		};
>> +	};
>> +};
>> --
>> 1.9.1
>>

Best regards
Olivier
