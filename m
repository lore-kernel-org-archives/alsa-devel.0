From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 3/3] pulse: Add fallback option
Date: Mon, 12 Sep 2011 09:20:53 +0800
Message-ID: <CAN8cciZURymvDfFbep7WZn8ZWY_0WmiBZrZwrXV1kqTQ5Fs=kQ@mail.gmail.com>
References: <s5hk4b5w7aq.wl%tiwai@suse.de>
	<s5hfwltw75w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id D0D6324747
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 03:20:53 +0200 (CEST)
Received: by fxe22 with SMTP id 22so2036494fxe.38
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2011 18:20:53 -0700 (PDT)
In-Reply-To: <s5hfwltw75w.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/7/26 Takashi Iwai <tiwai@suse.de>:
> [Patch to alsa-plugins]
>
> Added "fallback" option to give the PCM / controller name as a fallback
> when connecting to PA server fails.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> =A0doc/README-pulse =A0| =A0 19 +++++++++++++++++++
> =A0pulse/ctl_pulse.c | =A0 17 ++++++++++++++++-
> =A0pulse/pcm_pulse.c | =A0 17 ++++++++++++++++-
> =A0pulse/pulse.c =A0 =A0 | =A0 =A07 ++++---
> =A0pulse/pulse.h =A0 =A0 | =A0 =A02 +-
> =A05 files changed, 56 insertions(+), 6 deletions(-)
>
> diff --git a/doc/README-pulse b/doc/README-pulse
> index d5431b4..5b119f9 100644
> --- a/doc/README-pulse
> +++ b/doc/README-pulse
> @@ -39,3 +39,22 @@ you need to do this with PCM:s then specify two PCM:s =
with different "device".
>
> =A0If you do not specify any source and/or sink, then the server's defaul=
ts will
> =A0be used.
> +
> +When "fallback" option is set, the plugin will try to open the given PCM
> +(or control) automatically when connecting to PA server fails. =A0Typica=
lly,
> +it should point to "sysdefault", which was introduced recently in alsa-l=
ib,
> +so that the system-default setup is used even when you overwrite "defaul=
t"
> +PCM and control definitions.
> +
> + =A0 =A0pcm.pulse {
> + =A0 =A0 =A0 =A0type pulse
> + =A0 =A0 =A0 =A0fallback "sysdefault"
> + =A0 =A0}
> +
> + =A0 =A0ctl.pulse {
> + =A0 =A0 =A0 =A0type pulse
> + =A0 =A0 =A0 =A0fallback "sysdefault"
> + =A0 =A0}
> +
> + =A0 pcm.!default "pulse"
> + =A0 ctl.!default "pulse"

it seem that override "pulse" is not a good idea

a better way is just add "fallback" to default

pcm.!default {
    type pulse
    fallback "sysdefault"
    hint {
        description "Default"
    }
}

ctl.!default {
    type pulse
    fallback "sysdefault"
    hint {
        description "Default"
    }
}
