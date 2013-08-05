From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: change widget sequence for
	depop
Date: Mon, 5 Aug 2013 11:34:18 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB935C48AD46@rtitmbs7.realtek.com.tw>
References: <1375411082-7780-1-git-send-email-bardliao@realtek.com>
 <51FBD607.4000306@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E2582610CA
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 05:34:31 +0200 (CEST)
In-Reply-To: <51FBD607.4000306@wwwdotorg.org>
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
> Sent: Friday, August 02, 2013 11:54 PM
> To: Bard Liao
> Cc: broonie@kernel.org; lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> Flove; Oder Chiou; swarren@nvidia.com
> Subject: Re: [PATCH] ASoC: rt5640: change widget sequence for depop
> 
> On 08/01/2013 08:38 PM, bardliao@realtek.com wrote:
> > From: Bard Liao <bardliao@realtek.com>
> >
> > Add mute/unmute control in widget event and modify the power on/off
> sequence to avoid pop noise.
> 
> So, this does seem to improve (remove) pop noise on headphones. However, it
> also completely prevents speakers from working. Do you know what the
> problem is there?

I am sorry about that.
I tested it without a physical speaker connected but only checked the reg values.
Now, I have a speaker connected on my T40 board.
I will update the patch in a short time.

Thanks.

> 
> ------Please consider the environment before printing this e-mail.
