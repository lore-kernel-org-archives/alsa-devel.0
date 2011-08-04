From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/3] ALSA: snd-usb: Accept UAC2 FORMAT_TYPE
 descriptors with bLength > 6
Date: Thu, 4 Aug 2011 16:17:09 +0200
Message-ID: <CACTFLAN70my5TZmGvvU+547hhdq75Zvia+gi3Xpz-1BNfchkwg@mail.gmail.com>
References: <1312466188-3428-1-git-send-email-zonque@gmail.com>
	<1312466188-3428-2-git-send-email-zonque@gmail.com>
	<s5h1ux1l18a.wl%tiwai@suse.de> <4E3AAA06.3020204@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2581F24467
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 16:17:11 +0200 (CEST)
Received: by yxm34 with SMTP id 34so1180126yxm.38
	for <alsa-devel@alsa-project.org>; Thu, 04 Aug 2011 07:17:10 -0700 (PDT)
In-Reply-To: <4E3AAA06.3020204@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 4, 2011 at 4:17 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Obviously some temporary debugging patch to log protocol/bLength.
>
> --8<---------------------------------------------------------------->8--
> ALSA: snd-usb: Accept UAC2 FORMAT_TYPE descriptors with bLength > 6
>
> The Focusrite Scarlett 18i6 USB has them that way, which is probably a
> bug. Anyway, the driver should simply ignore this fact.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Reported-by: Nicolai Krakowiak <nicolai.krakowiak@gmail.com>
> Cc: stable@kernel.org
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> ---
> =A0sound/usb/endpoint.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index 1eea7e3..1867bbd 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -352,7 +352,7 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audi=
o *chip, int iface_no)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (((protocol =3D=3D UAC_VERSION_1) && (f=
mt->bLength < 8)) ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((protocol =3D=3D UAC_VERSION_2) &&=
 (fmt->bLength !=3D 6))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((protocol =3D=3D UAC_VERSION_2) &&=
 (fmt->bLength < 6))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_printk(KERN_ERR "%d:%u=
:%d : invalid UAC_FORMAT_TYPE desc\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->=
devnum, iface_no, altno);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;

Either that or apply the patch I've just sent out. Both is fine for me.

Daniel
