From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: remove unused mux
Date: Thu, 1 Aug 2013 20:22:35 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB935C48AB55@rtitmbs7.realtek.com.tw>
References: <1375356562-28151-1-git-send-email-bardliao@realtek.com>
 <51FA4EDF.4020809@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 48CAB260305
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 14:22:47 +0200 (CEST)
In-Reply-To: <51FA4EDF.4020809@metafoo.de>
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
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Thursday, August 01, 2013 8:05 PM
> To: Bard Liao
> Cc: broonie@kernel.org; lgirdwood@gmail.com; Oder Chiou;
> alsa-devel@alsa-project.org; swarren@nvidia.com; swarren@wwwdotorg.org;
> Flove
> Subject: Re: [alsa-devel] [PATCH] ASoC: rt5640: remove unused mux
> 
> On 08/01/2013 01:29 PM, bardliao@realtek.com wrote:
> > From: Bard Liao <bardliao@realtek.com>
> >
> > Remove unused "INL Mux" and "INR Mux".
> >
> > Signed-off-by: Bard Liao <bardliao@realtek.com>
> > ---
> > I meet a kernel panic issue if I don't remove the unused widget and modify
> something in rt5640_dapm_widgets[] and/or rt5640_dapm_routes[].
> > The message is "Unable to handle kernel paging request at virtual address
> 6b6b6bd3".
> > PC is at dapm_clear_walk_output+0x18/0x7c LR is at
> > dapm_clear_walk_output+0x18/0x7c If I remove those unused widget, ie.
> > not appear in rt5640_dapm_routes[], everything is fine.
> > So I think they should be removed.
> 
> The kernel panic is my fault. I introduced a memory corruption bug in the
> ASoC DAPM core. It's not specific to this drivers, I'll send the fix in a minute.

Thanks for your clarification.
However, I think those two widgets should be removed still.
Because there is no those MUXs in RT5640 codec in fact.

> 
> - Lars
> 
> ------Please consider the environment before printing this e-mail.
