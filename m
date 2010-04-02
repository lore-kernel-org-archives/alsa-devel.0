From: David Lee <david.lee.csj@gmail.com>
Subject: Re: mx27_wm9712.c memory leak
Date: Fri, 2 Apr 2010 10:20:13 +0800
Message-ID: <o2x8db5520f1004011920p98e9ac2fva3b57ae7411af49c@mail.gmail.com>
References: <n2u8db5520f1003302315m823880cbt6566a21953fb6d18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f209.google.com (mail-gx0-f209.google.com
	[209.85.217.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E0721038C3
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Apr 2010 04:20:14 +0200 (CEST)
Received: by gxk1 with SMTP id 1so1396240gxk.16
	for <alsa-devel@alsa-project.org>; Thu, 01 Apr 2010 19:20:13 -0700 (PDT)
In-Reply-To: <n2u8db5520f1003302315m823880cbt6566a21953fb6d18@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/3/31 David Lee <david.lee.csj@gmail.com>

> Dear alsaers:
>
> I am doing a test for imx27 platform with wm9712 as its sound card. When my
> programe that used for recording audio is running in background, I use top
> command to watch system condition. But the memory used and catchedd is
> rising as time past.I check my application programe , I dont think there is
> any wrong.So I think there's some wrong in audio drivers.
> Pleae check attachment for the driver code and my programe .
>
> Any suggestion will be greatly appreciate.
>
> Best regards.
>
>
> david sever of GOD
>
