From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rl6231: Simplify DMIC divider
	calculation expression
Date: Thu, 6 Aug 2015 02:03:43 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F8C8E6@RTITMBSV03.realtek.com.tw>
References: <1438811913-39249-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 789A2260496
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2015 04:03:49 +0200 (CEST)
In-Reply-To: <1438811913-39249-1-git-send-email-anatol.pomozov@gmail.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Bard Liao <bardliao@realtek.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Anatol Pomozov [mailto:anatol.pomozov@gmail.com]
> Sent: Thursday, August 06, 2015 5:59 AM
> To: alsa-devel@alsa-project.org
> Cc: broonie@kernel.org; Oder Chiou; Albert Chen; Anatol Pomozov
> Subject: [PATCH] ASoC: rl6231: Simplify DMIC divider calculation expression
> 
> Existing implementation checks all divider values and tracks 'red' proximity value
> for the frequency.
> 
> But as divider array is monotonically increasing the first divider that gives DMIC
> rate in 3MHz range is the best one we should use. No need for 'red' zone tracking.
> 
> Additionally make sure that DMIC frequency is higher 1MHz.
> 
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>

Acked-by: Oder Chiou <oder_chiou@realtek.com>
