From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: How to set TWL4030 to Option2
Date: Fri, 15 May 2009 19:51:11 +0900
Message-ID: <4A0D491F.9090509@samsung.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E7BA4@dlee07.ent.ti.com>
	<4A0D378E.5090004@samsung.com> <20090515094512.GB4449@sirena.org.uk>
	<4A0D4032.20506@samsung.com> <20090515103544.GC4449@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 754B324396
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 12:51:50 +0200 (CEST)
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KJO001JKM5BS0@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 15 May 2009 19:51:11 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KJO00LJ6M5BJJ@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 15 May 2009 19:51:11 +0900 (KST)
In-reply-to: <20090515103544.GC4449@sirena.org.uk>
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

On 5/15/2009 7:35 PM, Mark Brown wrote:
> On Fri, May 15, 2009 at 07:13:06PM +0900, Joonyoung Shim wrote:
> 
>> Oh, i see, thanks. But because the startup() function of codec dai is
>> called earlier than startup() function of machine, i think that we need
>> an control to set option2.
> 
> init() is called when the DAI is instantiated, not during playback or
> record.
> 

I confused the functions. :)
thanks.
