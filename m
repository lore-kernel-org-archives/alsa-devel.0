From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Configuring an audio path within ALSA
Date: Mon, 25 Jun 2012 19:56:34 -0700
Message-ID: <4FE924E2.2010504@codeaurora.org>
References: <CABTnDnPfGF8AddTSQ4GPyyvosQVa7K6Koda2cz79dknxWMaTVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A302247DE
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 04:56:38 +0200 (CEST)
In-Reply-To: <CABTnDnPfGF8AddTSQ4GPyyvosQVa7K6Koda2cz79dknxWMaTVg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rashmi narayan <rashmi.nyn@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/25/2012 5:26 AM, rashmi narayan wrote:
> Dear ALSA Folks,
>
> I am a newbie to ALSA .I am trying to configure a path within the driver to
> open up /power up the path within the codec from MIC-IN to LineOUT. How can
> I do this within ALSA. Please send me some pointers.
>
If your CODEC driver is written to plug into ASoC framework, ASoC
dynamic audio power management(DAPM) will be able to link MIC-IN to
Lineout. After a set of ALSA mixer commands is issued to create a path
from one end point to another end point, DAPM will kick in and enable
the path according to widgets and audio routing map defined in the
CODEC driver.

> Thank you,
> Rashmi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
