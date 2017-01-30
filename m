From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 3/7] IIO: add bindings for STM32 DFSDM ADC driver
Date: Mon, 30 Jan 2017 16:26:48 +0100
Message-ID: <f11398fe-c74f-3e33-c154-418709404aeb@st.com>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-4-git-send-email-arnaud.pouliquen@st.com>
 <fa6b541d-2818-afa7-82fa-eb19806e9f4d@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <fa6b541d-2818-afa7-82fa-eb19806e9f4d@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Cameron <jic23@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Alexandre TORGUE <alexandre.torgue@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello Jonathan,

My comments below.

Regards

Arnaud
On 01/29/2017 12:58 PM, Jonathan Cameron wrote:
> On 23/01/17 16:32, Arnaud Pouliquen wrote:
>> This patch adds documentation of device tree bindings for the
>> STM32 DFSDM ADC.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Trivial bits inline.
>> ---
>>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        | 60 ++++++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt 
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt  b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt 
>> new file mode 100644
>> index 0000000..c156bcb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt 	
>> @@ -0,0 +1,60 @@
>> +STMicroelectronics STM32 DFSDM ADC device driver
>> +
>> +STM32 DFSDM ADC is a sigma delta analog-to-digital converter.
>> +It has to be declared in device-tree as a subnode of the DFSDM mfd node.
>> +
>> +It has several multiplexed input channels. Conversions can be performed
>> +in single, scan or discontinuous mode. Conversions can be launched in software
>> +or using hardware triggers.
>> +Each instance of the driver uses one filter instance handle by the DFSDM mfd
>> +driver.
>> +
>> +DFSDM also offers extra features:
>> +-The analog watchdog feature allows the application to detect if the
>> + input voltage goes beyond the user-defined, higher or lower thresholds.
>> +-The short circuit detection allows allows the application to detect if the
>> + input is in CC.
>> +-The clock absence detection allows application to detect if SPI input is clocked.
>> +
>> +Required properties:
>> +- compatible:	Must be "st,stm32-dfsdm-adc".
>> +- reg:		Specifies the DFSDM filter instance.
>> +- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
>> +- st,adc-channels:	List of single-ended channels muxed for this ADC.
>> +- st,adc-channel-names:	List of single-ended channels Name.
>> +
>> +Optional properties:
>> +- st,adc-channel-types:	Single-ended channel input type. Default value is 0.
>> +			- 0: SPI with data on rising edge (default)
>> +			- 1: SPI with data on falling edge
> This is an element that can be described without magic numbers so I'd
> prefer that you do so.
> 
> Also spell check edage -> edge.
ok i will use strings
> 
>> +			- 2: manchester codec, rising edage = logic 0
>> +			- 3: manchester codec, rising edage = logic 1
>> +- st,adc-channel-clk-src: Conversion clock source. default value is 1.
>> +			  - 0: External SPI clocl (CLKIN x)
>> +			  - 1: internal SPI clock (CLKOUT) (default)
>> +			  - 2: internal SPI clock divided by 2 (falling edge).
>> +			  - 2: internal SPI clock divided by 2 (rising edge).
> 3?
>> +- st,adc-alt-channel: 	  must be defined if Two ADCs are connected on same SPI
>> +			  input.
>> +			  If not set channel n is connected to SPI input n.
>> +			  If set channel n is connected to SPI input n + 1.
> ? Two data inputs with shared clock?
Yes you can connect 2 digital microphones on one SPI.
One samples audio data on the clock rising edge, the other one samples
on the falling edge.
you can see an example in slide 15 of following document.
http://www.st.com/content/ccc/resource/training/technical/product_training/96/b6/2b/ea/72/3f/4e/d5/STM32L4_System_DFSDM.pdf/files/STM32L4_System_DFSDM.pdf/jcr:content/translations/en.STM32L4_System_DFSDM.pdf

I will describe this in an RFC to explain hardware but, to summarize,
there are 3 main "entities" in DFSDM:
- The serial interface: SPI or Manchester bus.
- The channel: it a kind of bridge than can be connected:
   on one side to a serial input (channel n connected to SPI interface n
or n + 1)
   on other side to one or several filters.

The filter: low pass filter + integrator.

>> +
>> +Example:
>> +	dfsdm: dfsdm@4400D000 {
>> +		iio_dfsdm0: iio-dfsdm@0 {
>> +			compatible = "st,stm32-dfsdm-adc";
>> +			#io-channel-cells = <1>;
>> +			reg = <0>;
>> +			st,adc-channels = <1>;
>> +			st,adc-channel-names = "in0";
>> +		};
>> +		iio_dfsdm1: iio-dfsdm@1 {
>> +			compatible = "st,stm32-dfsdm-adc";
>> +			#io-channel-cells = <1>;
>> +			reg = <1>;
>> +			st,adc-channels = <1>;
>> +			st,adc-channel-names = "in1";
>> +			st,adc-channel-types = <1>;
>> +			st,adc-alt-channel = <1>;
>> +		};
>> +	};
>>
> 
