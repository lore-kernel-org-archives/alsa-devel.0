From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] ASoC: TWL4030: change DAPMs for analog
 microphone selection
Date: Wed, 29 Apr 2009 09:19:21 +0900
Message-ID: <49F79D09.6010901@samsung.com>
References: <49F69B56.4000902@samsung.com>
	<200904281506.41577.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 720AE103865
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 02:19:34 +0200 (CEST)
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KIU00G0G6899L@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 29 Apr 2009 09:19:21 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KIU00AML689R5@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 29 Apr 2009 09:19:21 +0900 (KST)
In-reply-to: <200904281506.41577.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "bhmin@samsung.com" <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On 4/28/2009 9:06 PM, Peter Ujfalusi wrote:
> On Tuesday 28 April 2009 08:59:50 ext Joonyoung Shim wrote:
>> The mixer DAPM is suitable than the mux DAPM for the analog microphone
>> registers(0x05, 0x06) because each bit for path is switchable.
> 
> I'm not sure about this one.
> 
> The TRM has this for the ANAMICL register:
> Analog microphone left: Main microphone, headset microphone, carkit
> microphone, or auxiliary left microphone can be routed to the input of the
> A/D converters separately (only one enable bit at 1).
> 
> It is true, that it does not states explicitly that you can not set more than
> 1 bit, but it has this: only one enable bit at 1...
> 
> Are you sure about this?

I read it at TRM too, but cannot believe it such mixer of outputs.

Actually, i setted to 1 both HSMIC_EN bit and MAINMIC_EN bit for the ANAMICL
register, and recorded sound from headset mic and main mic. The result is that
both sounds are recorded.

So, to be sure this part, can you inquire about it to TI side?
