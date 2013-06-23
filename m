From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] [patch 1/1] imx-sgtl5000: return
 E_PROBE_DEFER if ssi/codec not found
Date: Sun, 23 Jun 2013 18:48:32 -0300
Message-ID: <CAOMZO5DOTEGKe0Fm-54vkm+oyY4_tBwgzoLpnKdmvbdgb=s4pA@mail.gmail.com>
References: <20130620212100.075892857@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f43.google.com (mail-vb0-f43.google.com
 [209.85.212.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 17172261A46
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2013 23:48:33 +0200 (CEST)
Received: by mail-vb0-f43.google.com with SMTP id e12so7521563vbg.2
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2013 14:48:32 -0700 (PDT)
In-Reply-To: <20130620212100.075892857@rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 20, 2013 at 6:20 PM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
> If the ssi or codec drivers are not loaded (for instance, because spi or i2c
> bus drivers are not loaded), returning -EINVAL will for people to unload and
> then reload the module to get sound working. Returning E_PROBE_DEFER will
> mitigate this.
>
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Which board you are using that fails to probe sgtl5000?

I have fixed this problem for some boards recently.
