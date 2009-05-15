From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: How to set TWL4030 to Option2
Date: Fri, 15 May 2009 19:13:06 +0900
Message-ID: <4A0D4032.20506@samsung.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E7BA4@dlee07.ent.ti.com>
	<4A0D378E.5090004@samsung.com> <20090515094512.GB4449@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 61B432433E
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 12:13:09 +0200 (CEST)
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KJO00DI4KDULB@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 15 May 2009 19:13:06 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KJO00M8IKDUJD@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 15 May 2009 19:13:06 +0900 (KST)
In-reply-to: <20090515094512.GB4449@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Lopez Cruz,
	Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On 5/15/2009 6:45 PM, Mark Brown wrote:
> On Fri, May 15, 2009 at 06:36:14PM +0900, Joonyoung Shim wrote:
> 
>> In current code, as you say, you have to directly change the value of
>> the reg cache for setting to option2, also you have to modify the
>> REG_OPTION and REG_VOICE_IF reg for voice, but this is temporary method.
> 
> This can be done with a register write from the DAI init() function in
> the machine driver in order to avoid modifying twl4030.c itself.
> 

Oh, i see, thanks. But because the startup() function of codec dai is
called earlier than startup() function of machine, i think that we need
an control to set option2.
