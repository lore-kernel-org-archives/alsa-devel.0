From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/2] Add "cval->res = 384" quirk for
 Logitech Webcam C600
Date: Sat, 12 Mar 2011 09:04:53 +0800
Message-ID: <AANLkTinUUrnDJreq8A=Or0ZQTq78QaND-wfY=RBy9WOi@mail.gmail.com>
References: <1299765219-31386-1-git-send-email-bug-track@fisher-privat.net>
	<1299765219-31386-3-git-send-email-bug-track@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A4611037EA
	for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2011 02:04:53 +0100 (CET)
Received: by fxm6 with SMTP id 6so1509902fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 17:04:53 -0800 (PST)
In-Reply-To: <1299765219-31386-3-git-send-email-bug-track@fisher-privat.net>
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

2011/3/10 Alexey Fisher <bug-track@fisher-privat.net>

> One more affected devices: Logitech Webcam C600 (046d:0808)
>
> Volume range before quirk is 6400, after (also real) is 16.
>
> Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
> ---
>  sound/usb/mixer.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index eba8ae8..c549522 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -1122,6 +1122,7 @@ static void build_feature_ctl(struct mixer_build
> *state, void *raw_desc,
>                }
>                break;
>
> +       case USB_ID(0x046d, 0x0808):
>        case USB_ID(0x046d, 0x0809):
>        case USB_ID(0x046d, 0x0991):
>        /* Most audio usb devices lie about volume resolution.
> --
> 1.7.1
>
>
It is because each step of usb audio is 1/256dB  , so 384 step is 1.5dB

Is there any way to verify the resolution is 1.5dB ?

since alsamixertest does not check the capture volume (only check the
playback volume)

And mindB +18dB and maxdB +30dB  ,  It can still record sound using audacity
at +18dB , so it seem break the pulseaudio developer 's assumption that 0%
is -infinite dB


state.U0x46d0x992 {
    control.1 {
        iface MIXER
        name 'Mic Capture Switch'
        value false
        comment {
            access 'read write'
            type BOOLEAN
            count 1
        }
    }
    control.2 {
        iface MIXER
        name 'Mic Capture Volume'
        value 3072
        comment {
            access 'read write'
            type INTEGER
            count 1
            range '0 - 3072'
            dbmin 1800
            dbmax 3000
            dbvalue.0 3000
        }
    }
}
