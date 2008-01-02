From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Wed, 02 Jan 2008 09:10:44 -0600
Message-ID: <477BA974.8010308@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D20524338
	for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2008 16:11:01 +0100 (CET)
In-Reply-To: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
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
> On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
>> +               ssi@16000 {
>> +                       compatible = "fsl,ssi";
>> +                       cell-index = <0>;
>> +                       reg = <16000 100>;
>> +                       interrupt-parent = <&mpic>;
>> +                       interrupts = <3e 2>;
>> +                       fsl,mode = "i2s-slave";
>> +                       codec {
>> +                               compatible = "cirrus,cs4270";
>> +                               /* MCLK source is a stand-alone oscillator */
>> +                               bus-frequency = <bb8000>;
>> +                       };
>> +               };
> 
> Does this need to be bus-frequency? It's always called MCLK in all of
> the literature.

I'm trying to make this node as generic as possible.  The fabric driver 
is the one that will parse this node and pass the data to the codec 
driver, so I can't use any codec-specific terms.

The API from the fabric driver for passing clock information includes a 
clock ID, a direction, and a frequency.  I can do something like this:

clock1 = <0, bb8000>

Would that be better?

> 
> In my case the MCLK comes from a chip on the i2c bus that is
> programmable How would that be encoded?.

I'm going under the assumption that MCLK does not change once the board 
is up and running.  In your case, you'd need to do something quite 
different, because you're not reading the clock info from the device 
tree and passing it to the codec at initialization once.  If you want to 
define an extension to the 'codec' child node that handles that, I'll 
add it to the documentation.
