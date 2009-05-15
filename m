From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: How to set TWL4030 to Option2
Date: Fri, 15 May 2009 20:00:07 +0900
Message-ID: <4A0D4B37.9020003@samsung.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E7BA4@dlee07.ent.ti.com>
	<4A0D378E.5090004@samsung.com> <20090515094512.GB4449@sirena.org.uk>
	<2C7D3DF36ADFFC479B44490D912B616705F69E7BAA@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id D9113103971
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 13:00:09 +0200 (CEST)
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KJO002WRMK70S@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 15 May 2009 20:00:07 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KJO00KMMMK7C1@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 15 May 2009 20:00:07 +0900 (KST)
In-reply-to: <2C7D3DF36ADFFC479B44490D912B616705F69E7BAA@dlee07.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On 5/15/2009 7:05 PM, Lopez Cruz, Misael wrote:
>>> In current code, as you say, you have to directly change 
>>> the value of the reg cache for setting to option2, also
>>> you have to modify the REG_OPTION and REG_VOICE_IF reg for
>>> voice, but this is temporary method.
> 
>> This can be done with a register write from the DAI init()
>> function in the machine driver in order to avoid modifying
>> twl4030.c itself.
> 
> For audio and voice interface, following things need to be configured:
> 
> Audio interface:
> - Output pins state: high impendance or application mode
> - Enable audio interface
> 
> Voice interface:
> - Enable voice data input
> - Enable voice data output
> - Output pins state: high impedance or application mode
> - Enable voice interface
> 
> I think that interfaces can be enabled in DAI init as Mark suggests,

Yes, but i worry about whether this reg value can be changed on the fly
or not.

> but input/output should be enabled depending on whether we are doing
> playback/capture or not, and then they should be handled in the codec
> driver.

Hmm, the twl4030 codec can do the voice communication at the same time
while doing playback/capture, is not it?

> 
> For the codec operation mode selection, I still think Peter's
> advice is more appropriate because options1,2 are not really tight to
> DAIs. For example, we can be in option2 (voice/audio) and do
> transferences using both DAIs: I2S and PCM.
