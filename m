From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Add Aquila sound driver
Date: Fri, 09 Jul 2010 11:21:08 +0900
Message-ID: <4C368794.2040600@samsung.com>
References: <4C355AC2.8090502@samsung.com>
	<20100708070549.GA29850@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 5134B24452
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jul 2010 04:21:11 +0200 (CEST)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L5900MNAQJ88IB0@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 09 Jul 2010 11:21:08 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L59009VIQJ85P@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 09 Jul 2010 11:21:08 +0900 (KST)
In-reply-to: <20100708070549.GA29850@opensource.wolfsonmicro.com>
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
Cc: Chanwoo Choi <cw00.choi@samsung.com>, alsa-devel@alsa-project.org, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Jul 08, 2010 at 01:57:38PM +0900, Chanwoo Choi wrote:
>> This patch add sound support for the Aquila board based on S5PC110.
>>
>> The Aquila board is based on Samsung SoC(S5PC110) and include
>> WM8994 codec over I2Sv5 to support sound. As there is currently
>> no driver for the I2Sv5, the code to use I2Sv5 is deleted
>> on this patch.
> 
> This looks good from my point of view, though I'm not sure if you want
> to do any updates for Jassi's comments and Liam also needs to review
> still.
> 
Ok, I am talking about using I2Sv5 with Jassi.
Also, Should I specially send this patch to review to Liam?
or What is another way to review?

> One other thing that you might want to do - I'm not sure if you noticed
> but there is now an API call snd_soc_dapm_ignore_suspend() which allows 
> audio paths to be kept up while the system is suspended, intended for
> use in cases like voice calls on mobile phones where audio is running
> even though the Linux system is suspended.  To use this you should mark
> all DAPM endpoints which can be live over suspend as ignoring suspend
> then ASoC should transparently keep any paths between endpoints marked
> this way up.
I see that your mentioned patcth.
But,
before I had received the patch to keep audio path on suspend,
to execute voice-call on suspend implemented that the state of LDO of 
codec is kept high to run audio in cases voice call while the Linux system
is suspended.

I will try to find your mentioned patch and check to apply the sound driver
of Aquila board.

Thank you,
Chanwoo Choi
