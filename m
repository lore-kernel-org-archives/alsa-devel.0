From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support
	for audio
Date: Wed, 07 Jan 2015 17:18:20 +0000
Message-ID: <54AD6A5C.60903@arm.com>
References: <cover.1420628786.git.moinejf@free.fr>	<0084acea5a3475a77531d6a77483f36d3469111a.1420628786.git.moinejf@free.fr>	<54AD4511.30702@arm.com>
 <20150107180825.52334d4f@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id C543F26053B
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 18:18:21 +0100 (CET)
In-Reply-To: <20150107180825.52334d4f@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 01/07/15 17:08, Jean-Francois Moine wrote:
> On Wed, 07 Jan 2015 14:39:13 +0000
> Andrew Jackson <Andrew.Jackson@arm.com> wrote:
> 
>>> +  - audio-ports: must contain one or two values selecting the source
>>> +	in the audio port.
>>> +	The source type is given by the corresponding entry in
>>> +	the audio-port-names property.  
>>
>> I think that this entry might benefit from a little more explanation.
>> The value specified here selects which pins on the chip provide the
>> audio input doesn't it?  In the outline datasheet that I have these are
>> listed in table 17:
>>
>> Audio port 	Input configuration
>> 		S/PDIF 		I2S-bus
>> AP0 		- 		WS (word select)
>> AP1 		S/PDIF input 	I2S-bus channel 0
>> AP2 		S/PDIF input 	I2S-bus channel 1
>> AP3[1] 				I2S-bus channel 2
>> AP4[1] 				I2S-bus channel 3
>> ACLK 		- 		SCK (I2S-bus clock)
>>
>> [1] Depending on package.
> 
> Your table is close to the one in the TDA9983B documentation I have,
> but the pins are not exactly the same:
> 
> AP0 		WS (word select)
> AP1 		I2S-bus port 0
> AP2 		I2S-bus port 1
> AP3 		I2S-bus port 2
> AP4 		I2S-bus port 3
> AP5		MCLK (master clock for S/PDIF)
> AP6		S/PDIF input
> AP7		AUX (internal test)
> ACLK 		SCK (I2S-bus clock)
> 
> That's why I did not know clearly why I had to set AP2 for S/PDIF input
> and (AP0 + AP1) for I2S input in the Cubox.
> 
> Then, the only more explanation I could give is "have a look at the
> audio input format and at the register 0x1e page 0 in the documentation
> of the TDA998x chip".
> 
> BTW, the tda998x driver supports only the TDA9989, TDA19988 and
> TDA19989 chips. If the TDA9983B would be supported, the audio port
> definitions would be of no use.
> 
> So, what would you see as an explanation?
> 

I understand your difficulty!  I was just wanting something to clarify the 
meaning of the value without reference to the driver source.

You could add something like this to your existing explanation: "The value
describes which audio input pins are selected; this varies depending
on chip type so consult the section on audio port configuration in the 
relevant datasheet.".  

	Andrew
