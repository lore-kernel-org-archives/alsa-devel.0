From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: How to set TWL4030 to Option2
Date: Fri, 15 May 2009 18:36:14 +0900
Message-ID: <4A0D378E.5090004@samsung.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E7BA4@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B396103976
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 11:36:22 +0200 (CEST)
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KJO00DJ5IOEAW@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 15 May 2009 18:36:14 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KJO00L41IOEJJ@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 15 May 2009 18:36:14 +0900 (KST)
In-reply-to: <2C7D3DF36ADFFC479B44490D912B616705F69E7BA4@dlee07.ent.ti.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On 5/15/2009 5:21 PM, Lopez Cruz, Misael wrote:
> I'm adding the voice dai to sdp3430 machine driver, but the codec's
> "twl4030_voice_startup" function has a requirement for voice to work: the
> codec has to be in option2. How can I switch the codec to option2 mode?
> There is no control for doing that, and the only way I see is to
> directly modify the reg cache, but I assume that is not the right way
> to do it.

Hi,

In current code, as you say, you have to directly change the value of
the reg cache for setting to option2, also you have to modify the
REG_OPTION and REG_VOICE_IF reg for voice, but this is temporary method.

As Peter already say, we need additional controls.

Regards.

> 
> Could you please clarify?
> 
> -Misa
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
