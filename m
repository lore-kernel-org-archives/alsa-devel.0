From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH 1/4] ASoC: hdmi-codec: Add an op to set
 callback function for plug event
Date: Mon, 8 Jul 2019 13:03:53 +0800
Message-ID: <CAFv8NwLP-hUBW8FZW5kooaggeNRG7LAEd2pd_-70YBrVMY-+CQ@mail.gmail.com>
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-2-cychiang@chromium.org>
 <CA+Px+wXtmf9dQQP7ywPLp7Qbbvqau=WnO3qhZ8+qmbJD1gjx+A@mail.gmail.com>
 <20190705121240.GA20625@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com
 [IPv6:2607:f8b0:4864:20::e42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E46C3F800E2
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2019 07:04:23 +0200 (CEST)
Received: by mail-vs1-xe42.google.com with SMTP id k9so7362481vso.5
 for <alsa-devel@alsa-project.org>; Sun, 07 Jul 2019 22:04:23 -0700 (PDT)
In-Reply-To: <20190705121240.GA20625@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: ALSA development <alsa-devel@alsa-project.org>, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.com>, tzungbi@chromium.org, Hans Verkuil <hverkuil@xs4all.nl>, Tzung-Bi Shih <tzungbi@google.com>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel@ffwll.ch>, linux-rockchip@lists.infradead.org, Dylan Reid <dgreid@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 5, 2019 at 8:12 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 05, 2019 at 03:08:37PM +0800, Tzung-Bi Shih wrote:
> > On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> > > +typedef void (*hdmi_codec_plugged_cb)(struct platform_device *dev,
> > > +                                     bool plugged);
> > > +
>
> > The callback prototype is "weird" by struct platform_device.  Is it
> > possible to having snd_soc_component instead of platform_device?
>
> Or if it's got to be a device why not just a generic device so
> we're not tied to a particular bus here?

My intention was to invoke the call in dw-hdmi.c like this:

    hdmi->plugged_cb(hdmi->audio,
                                   result == connector_status_connected);

Here hdmi->audio is a platform_device.
I think dw-hdmi can not get  snd_soc_component easily.
I can use a generic device here so the ops is more general.
The calling will be like
    hdmi->plugged_cb(&hdmi->audio->dev,
                                   result == connector_status_connected);
I will update this in v2.
Thanks!
