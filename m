From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] ASoC: TWL4030: change DAPMs for analog
 microphone selection
Date: Thu, 30 Apr 2009 16:20:16 +0900
Message-ID: <49F95130.3060004@samsung.com>
References: <49F69B56.4000902@samsung.com>
	<200904281506.41577.peter.ujfalusi@nokia.com>
	<49F79D09.6010901@samsung.com>
	<200904300951.21620.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F65B24476
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 09:20:35 +0200 (CEST)
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KIW009TVKDXBJ@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 30 Apr 2009 16:20:21 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KIW0066RKDX3P@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 30 Apr 2009 16:20:21 +0900 (KST)
In-reply-to: <200904300951.21620.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "bhmin@samsung.com" <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On 4/30/2009 3:51 PM, Peter Ujfalusi wrote:
> On Wednesday 29 April 2009 03:19:21 ext Joonyoung Shim wrote:
>> I read it at TRM too, but cannot believe it such mixer of outputs.
>>
>> Actually, i setted to 1 both HSMIC_EN bit and MAINMIC_EN bit for the
>> ANAMICL register, and recorded sound from headset mic and main mic. The
>> result is that both sounds are recorded.
>>
>> So, to be sure this part, can you inquire about it to TI side?
> 
> I'll ask Ti about this and also about the output mixer/mux thing, just to be 
> sure that we are not doing anything 'illegal' with those either.
> 
> We should wait with this until Ti responds, I'll let you know what is their 
> opinion...

Ok, i see.

Thanks.
