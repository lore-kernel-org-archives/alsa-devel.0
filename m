From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Tue, 4 Jun 2013 14:23:25 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB8A89699525@rtitmbs7.realtek.com.tw>
References: <1369983899-13580-1-git-send-email-bardliao@realtek.com>
 <1121E117AD4ECE49880A389A396215BB8A8969924B@rtitmbs7.realtek.com.tw>
 <51ACBAE0.1070406@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id BF5392655F9
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 08:23:31 +0200 (CEST)
In-Reply-To: <51ACBAE0.1070406@wwwdotorg.org>
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
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Stephen Warren [mailto:swarren@wwwdotorg.org]
> Sent: Monday, June 03, 2013 11:49 PM
> To: Bard Liao
> Cc: broonie@kernel.org; lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> Flove; Oder Chiou; swarren@nvidia.com
> Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
> 
> On 05/31/2013 01:15 AM, Bard Liao wrote:
> > Stephen,
> >
> > I remove the DT support from this patch.
> > Can you add the DT support as a separate patch?
> 
> Yes, I'll do that.
> 
> I assume you also want me to add the code to control the LDO1_EN GPIO,
> since that seems missing from this patch. I thought you said you were going to
> add it. I assume you tested this on Dalmore by manually setting the GPIO from
> U-Boot before booting the kernel?

Yes, please add the code to control the LDO1_EN_GPIO.
Thanks a lot.
I execute "gpio set 171" command in U-Boot every time before booting the kernel.

> 
> I'll try to get to this ASAP; perhaps not today though - we'll see how long the
> other things I have stacked up take.
> 
> ------Please consider the environment before printing this e-mail.
