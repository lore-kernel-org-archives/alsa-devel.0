From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 0/2] rockchip-i2s: add power setting for
 I2S controller and fix some critical bugs
Date: Fri, 29 Aug 2014 21:30:43 -0700
Message-ID: <CAD=FV=XPYkDJ2J3rTHZgKzbH_EMBUmCMwHWjpf1Aagnv_mUqGQ@mail.gmail.com>
References: <1409350027-17604-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f181.google.com (mail-vc0-f181.google.com
 [209.85.220.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A5742607B6
 for <alsa-devel@alsa-project.org>; Sat, 30 Aug 2014 06:30:44 +0200 (CEST)
Received: by mail-vc0-f181.google.com with SMTP id ij19so3391046vcb.26
 for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2014 21:30:44 -0700 (PDT)
In-Reply-To: <1409350027-17604-1-git-send-email-jay.xu@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jianqun <jay.xu@rock-chips.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, tiwai@suse.de, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, yongjun_wei@trendmicro.com.cn, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Jianqun,

On Fri, Aug 29, 2014 at 3:07 PM, Jianqun <jay.xu@rock-chips.com> wrote:
> Add optional power setting for i2s controller found on rk3066, rk3168 and rk3288
> processors from rockchip, should according to hardware design.
>
> Default setting for I2S controller is powered by 3.3V, there needs this patch if
> it's powered by 1.8V by hardware design.
>
> Jianqun (2):
>   rockchip-i2s: dt: add grf requested properties to set power of I2S controller
>   rockchip-i2s: add power setting for I2S controller, also fix some bugs
>
>  .../devicetree/bindings/sound/rockchip-i2s.txt     |  6 +-
>  sound/soc/rockchip/rockchip_i2s.c                  | 93 +++++++++++++---------
>  sound/soc/rockchip/rockchip_i2s.h                  | 13 +--
>  3 files changed, 68 insertions(+), 44 deletions(-)

Did the general solution I posted at
<https://patchwork.kernel.org/patch/4807821/> not work for you?  ...or
did you not see that?

-Doug
