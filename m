From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 06/17] Documentation: Define the MOP500
 Audio Machine Driver Device Tree bindings
Date: Tue, 11 Sep 2012 11:06:00 +0200
Message-ID: <504EFEF8.6020707@stericsson.com>
References: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
 <1345816913-4113-7-git-send-email-lee.jones@linaro.org>
 <20120910164413.GC24506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
 [207.126.144.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E26A264F53
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 11:06:08 +0200 (CEST)
In-Reply-To: <20120910164413.GC24506@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "arnd@arndb.de" <arnd@arndb.de>, Roger NILSSON1 <roger.xr.nilsson@stericsson.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 09/10/2012 06:44 PM, Lee Jones wrote:

> Ola poke.
> 
> On Fri, Aug 24, 2012 at 03:01:42PM +0100, Lee Jones wrote:
>> Here we add the required documentation for the new Device Tree
>> bindings pertaining to the MOP500 Audio Machine driver.
>> 
>> CC: alsa-devel@alsa-project.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>  .../devicetree/bindings/sound/ux500-mop500.txt     |   39 ++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/ux500-mop500.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/sound/ux500-mop500.txt b/Documentation/devicetree/bindings/sound/ux500-mop500.txt
>> new file mode 100644
>> index 0000000..48e071c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/ux500-mop500.txt
>> @@ -0,0 +1,39 @@
>> +* MOP500 Audio Machine Driver
>> +
>> +This node is responsible for linking together all ux500 Audio Driver components.
>> +
>> +Required properties:
>> + - compatible              : "stericsson,snd-soc-mop500"
>> +
>> +Non-standard properties:
>> + - stericsson,cpu-dai      : Phandle to the CPU-side DAI
>> + - stericsson,audio-codec  : Phandle to the Audio CODEC
>> + - stericsson,card-name    : Over-ride default card name
>> +
>> +Example:
>> +
>> +	sound {
>> +		compatible = "stericsson,snd-soc-mop500";
>> +
>> +		stericsson,cpu-dai = <&msp1 &msp3>;
>> +		stericsson,audio-codec = <&codec>;
>> +	};
>> +
>> +	msp1: msp@80124000 {
>> +		compatible = "stericsson,ux500-msp-i2s";
>> +		reg = <0x80124000 0x1000>;
>> +		interrupts = <0 62 0x4>;
>> +		v-ape-supply = <&db8500_vape_reg>;


I'm no DT-expert, but why are you adding MSP-stuff in the machine-driver? They
are also added in the next patch.

>> +	};
>> +
>> +	msp3: msp@80125000 {
>> +		compatible = "stericsson,ux500-msp-i2s";
>> +		reg = <0x80125000 0x1000>;
>> +		interrupts = <0 62 0x4>;
>> +		v-ape-supply = <&db8500_vape_reg>;
>> +	};
>> +
>> +	codec: ab8500-codec {
>> +		compatible = "stericsson,ab8500-codec";
>> +		stericsson,earpeice-cmv = <950>; /* Units in mV. */


Only four voltages are allowed here. Maybe enumerate them in the comment?

>> +	};
>> -- 
>> 1.7.9.5
>> 
> 
