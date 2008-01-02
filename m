From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Wed, 02 Jan 2008 09:19:03 -0600
Message-ID: <477BAB67.4080003@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 618092461E
	for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2008 16:18:43 +0100 (CET)
In-Reply-To: <9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:
> On 1/1/08, Jon Smirl <jonsmirl@gmail.com> wrote:
>> On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
>>> +               ssi@16000 {
>>> +                       compatible = "fsl,ssi";
>>> +                       cell-index = <0>;
>>> +                       reg = <16000 100>;
>>> +                       interrupt-parent = <&mpic>;
>>> +                       interrupts = <3e 2>;
>>> +                       fsl,mode = "i2s-slave";
>>> +                       codec {
>>> +                               compatible = "cirrus,cs4270";
>>> +                               /* MCLK source is a stand-alone oscillator */
>>> +                               bus-frequency = <bb8000>;
>>> +                       };
>>> +               };
>> Does this need to be bus-frequency? It's always called MCLK in all of
>> the literature.
>>
>> In my case the MCLK comes from a chip on the i2c bus that is
>> programmable How would that be encoded?.
> 
> Looking at the cs4270 codec driver it is controlled by i2c (supports
> SPI too).  What happened to the conversation about putting codecs on
> the controlling bus and then linking them to the data bus?

The current CS4270 driver doesn't support device trees.  When I wrote 
it, the idea of putting I2C info in the device tree was not finalized, 
and since the driver is supposed to be cross-platform, I decided to do 
it the old-fashioned way.  Before I update the code, however, I'm 
waiting for:

1) The current code to be accepted into the tree
2) ASoC is updated to V2
3) The current drivers are updated to support ASoC V2.

I think ASoC V2 will make it easier to support device trees, but I'm not 
ready yet for that.

> If that's the case the cs4270 should be in the i2c bus node (missing
> currently) and then a link from the SSI bus would point to it.

The CS4270 is a child of both the I2C bus *and* the SSI bus.  It needs 
to have two nodes, one under each.  Your're right in that there needs to 
be a link, but until the code is updated to ASoC V2, I think it's 
premature to add that support.
