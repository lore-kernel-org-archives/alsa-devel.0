From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 1/6] ASoC: davinci-mcbsp: add binding
	for McBSP
Date: Fri, 15 Apr 2016 14:28:40 +0530
Message-ID: <5710AD40.8000209@ti.com>
References: <1460375117-4311-1-git-send-email-petr@barix.com>
 <1460375117-4311-2-git-send-email-petr@barix.com>
 <20160413143014.GA12136@rob-hp-laptop> <5710AACF.9070402@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A2B7261AAF
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2016 10:58:46 +0200 (CEST)
In-Reply-To: <5710AACF.9070402@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, khilman@kernel.org, ijc+devicetree@hellion.org.uk, lgirdwood@gmail.com, broonie@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Friday 15 April 2016 02:18 PM, Petr Kulhavy wrote:

> On 13.04.2016 16:30, Rob Herring wrote:

>> On Mon, Apr 11, 2016 at 01:45:12PM +0200, Petr Kulhavy wrote:

>>> a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
>>> b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
>>> new file mode 100644
>>> index 000000000000..de45865c3863
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
>>> @@ -0,0 +1,51 @@
>>> +Texas Instruments DaVinci McBSP module
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +This binding describes the "Multi-channel Buffered Serial Port" (McBSP)
>>> +audio interface found in some TI DaVinci processors like the
>>> OMAP-L138 or AM180x.
>>> +
>>> +
>>> +Required properties:
>>> +~~~~~~~~~~~~~~~~~~~~
>>> +- compatible : "ti,da850-mcbsp"
>> You list several SoCs above, but only one compatible string here. A
>> specific compatible string per SoC please.
>>
> Hi Rob,
> 
> thank you for your feedback. I can test only on the AM1808 platform,
> however as far as I understand the OMAP L138 and AM1808 use the same
> McBSP hardware. The TI guys can give more insight here... Isn't it then
> redundant to define more compatible strings? Sorry for my ignorance, I
> just don't know the policy of defining the compatible strings.

DA850, OMAP-L138 and AM18x are pin-for-pin compatible devices meant for
different markets/applications. IP-wise, silicon-integration-wise or
pin-wise, there is no difference in way McASP behaves between the parts.

Thanks,
Sekhar
