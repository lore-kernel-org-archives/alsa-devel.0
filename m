From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Question: Selecting one codec from multiple codecs
 using rk3288_hdmi_analog driver
Date: Wed, 8 May 2019 13:02:15 +0800
Message-ID: <CAFv8Nw+etFr6Wsd2WoXC+pzQ_rhcqTTzDSUOgWC-dETbvZ=iVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com
 [IPv6:2607:f8b0:4864:20::943])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF270F8075E
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 07:02:43 +0200 (CEST)
Received: by mail-ua1-x943.google.com with SMTP id 94so4644339uaf.10
 for <alsa-devel@alsa-project.org>; Tue, 07 May 2019 22:02:43 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>
Cc: romain.perier@collabora.com, sjoerd.simons@collabora.com, Doug Anderson <dianders@chromium.org>, tzungbi@chromium.org
List-Id: alsa-devel@alsa-project.org

Hi all,
I am wondering whether it is possible to selectively play to one codec
out of multiple codecs.

There is a multiple codec usage in driver rk3288_hdmi_analog:
https://github.com/torvalds/linux/blob/master/sound/soc/rockchip/rk3288_hdmi_analog.c
https://patchwork.kernel.org/patch/9554267/
I am not sure whether the driver supports playing to analog output or
HDMI selectively one at a time ?

I don't have a Firefly-RK3288 board to test that driver, but I have
RK3288 veyron board.
I followed the similar way like that driver does to support max98090
and HDMI on RK3288 veyron board. However, when I play to the device,
it goes to both max98090 and HDMI codec.
>From rk3288_hdmi_analog implementation, I failed to find out how to
turn off HDMI codec when HDMI path is unwanted.
The DAPM pin switch "HDMI" does not help since that even if DAPM path
I2S Playback -> TX -> HDMI is turned off, the startup ops of HDMI
codec is still called from soc_pcm_open path.

Could someone please explain whether this is supported in the framework ?
There seems to be two ways to achieve this
One is to use TDM and select different channel for two codecs.
The second is to add mixer controls and turn codec on/off to disable
codec completely.
But those requires changes on codec driver and the capability of TDM
or mixer control on each codec.
Maybe there should be a way to bypass startup ops of one of multiple
codecs if it is unwanted ?

Any help or suggestion is appreciated. Thanks!
