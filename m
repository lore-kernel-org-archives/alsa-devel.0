From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] snd-usb-6fire: volume control for
 individual analog channels
Date: Thu, 15 Sep 2011 18:52:15 +0200
Message-ID: <CACTFLAPAWdnSV7uky00b05i4VXwD1PFPXJi64yOzsP6xD+btpw@mail.gmail.com>
References: <1326db76d53.-6181476231545168842.2132841142197504851@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f45.google.com (mail-pz0-f45.google.com
	[209.85.210.45])
	by alsa0.perex.cz (Postfix) with ESMTP id AFDFD103B1D
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 18:52:17 +0200 (CEST)
Received: by pzk33 with SMTP id 33so1474170pzk.32
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 09:52:16 -0700 (PDT)
In-Reply-To: <1326db76d53.-6181476231545168842.2132841142197504851@zoho.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Torsten Schenk <torsten.schenk@zoho.com>
Cc: tiwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, clemens <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 5:32 PM, Torsten Schenk <torsten.schenk@zoho.com> w=
rote:
> Added a stereo volume control for each analog output channel pair.
> Master volume modified so that it acts as a software weight for
> the individual channel faders.
> Added mute switches for master and individual analog channels.
>
> Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>
> Cc: stable@kernel.org [3.0+]
> ---
> diff -Nur a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
> --- a/sound/usb/6fire/chip.c =A0 =A02011-09-15 16:11:08.000000000 +0000
> +++ b/sound/usb/6fire/chip.c =A0 =A02011-09-15 16:11:46.000000000 +0000
> @@ -5,7 +5,7 @@
> =A0*
> =A0* Author: =A0 =A0 Torsten Schenk <torsten.schenk@zoho.com>
> =A0* Created: =A0 =A0Jan 01, 2011
> - * Version: =A0 =A00.3.0
> + * Version: =A0 =A00.3.6

On a general note - I would suggest you drop your own versioning and
let git do the job.
