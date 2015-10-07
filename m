From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH RFC V2 0/5] another generic audio hdmi
 codec proposal
Date: Wed, 07 Oct 2015 12:21:51 +0200
Message-ID: <5614F23F.7050608@metafoo.de>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
 <56127ADB.6080700@ti.com> <561392F7.90608@st.com> <5613EC62.8000007@ti.com>
 <5614D58F.9010102@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-060.synserver.de (smtp-out-094.synserver.de
 [212.40.185.94])
 by alsa0.perex.cz (Postfix) with ESMTP id 38CD4265AE8
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 12:23:20 +0200 (CEST)
In-Reply-To: <5614D58F.9010102@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Jyri Sarha <jsarha@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "moinejf@free.fr" <moinejf@free.fr>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "bcousson@baylibre.com" <bcousson@baylibre.com>, David Airlie <airlied@linux.ie>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Takashi Iwai <tiwai@suse.de>, "tony@atomide.com" <tony@atomide.com>, "broonie@kernel.org" <broonie@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


Added Hans, who's working a lot on the HDMI transmitter drivers (including
audio support) as well as the media list to Cc.

On 10/07/2015 10:19 AM, Arnaud Pouliquen wrote:
> 
> 
>>> My approach is the reverse: DRM driver does not need to know anything
>>> about audio side. As ALSA is the client of DRM, seems more logical from
>>> my point of view ...
>>> Now if a generic solution must be found for all video drivers, sure,
>>> your solution is more flexible.
>>> But if i well understood fbdev drivers are no more accepted for upstream
>>> (please correct me if I'm wrong).
>>> So i don't know we have to keep fbdev in picture...
>>>
>>
>> I am not promoting fbdev support. I am merely asking if we want to force
>> all HDMI drivers to implement a drm_bridge if they want to support audio.
>>
> Yes this is a good point... My implementation is based on hypothesis that
> HDMI drivers are now upstreamed as DRM drivers.

The other place where you can find HDMI support is in V4L2, both receive as
well as transmit. And while the hope for fbdev is that it will be phased out
V4L2 will stay around for a while. And we probably want to have a common API
that can take care of both DRM and V4L so we do not need two sets of helper
functions for things like EDID parsing etc.

- Lars
