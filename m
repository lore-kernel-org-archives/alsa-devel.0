From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ASoC: Fix Panda board support
Date: Mon, 21 Nov 2011 15:37:03 +0200
Message-ID: <CAPo=G1wJ9_jB7oHpiuLkg+bbuSksAhMmN0q8g38h5WU8RJUyvQ@mail.gmail.com>
References: <1321881246-24163-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 68BB22414F
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 14:37:19 +0100 (CET)
Received: by mail-iy0-f174.google.com with SMTP id e36so8918009iag.5
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 05:37:03 -0800 (PST)
In-Reply-To: <1321881246-24163-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Obviously I do not have Panda Board...
We need to patch the board-oma4panda.c in arch/arm/mach-omap2/ as well...
Will resend the series again.

-- =

P=E9ter


On Mon, Nov 21, 2011 at 3:14 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wro=
te:
> Hello,
>
> The following two patch fixes the audio support for Panda board. The sdp4=
430
> machine driver suppose to handle sdp4430/panda board, but for some reason
> the machine_is check was excluding the Panda board.
>
> It would be nice if this can be integrated to 3.2.
>
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
> =A0ASoC: sdp4430: No need to announce the loading of the driver
> =A0ASoC: sdp4430: Fix Panda support
>
> =A0sound/soc/omap/sdp4430.c | =A0 =A08 +++++---
> =A01 files changed, 5 insertions(+), 3 deletions(-)
>
> --
> 1.7.8.rc3
