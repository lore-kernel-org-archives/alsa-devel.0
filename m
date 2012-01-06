From: Manuel Jander <manuel.jander@gmail.com>
Subject: Re: [PATCH] ALSA au88x0: Fix IRQ fifo error and
 channels swap of 4 channels playback
Date: Fri, 6 Jan 2012 13:00:51 +0100
Message-ID: <CACRof1UDjOjw4XUU3q-WTJi4U6Osg=eHLoV6g0bz2yBC1FdjTw@mail.gmail.com>
References: <CAN8cciYgJ9U0aS6np4nV+uws_0VEgmRXE2ocaLdc_7MgS6_7+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5116C103866
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 13:00:52 +0100 (CET)
Received: by iaae16 with SMTP id e16so2532407iaa.38
	for <alsa-devel@alsa-project.org>; Fri, 06 Jan 2012 04:00:51 -0800 (PST)
In-Reply-To: <CAN8cciYgJ9U0aS6np4nV+uws_0VEgmRXE2ocaLdc_7MgS6_7+w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

thanks a lot. I tried your attached patch to 2.6.39 and in compiles
and works OK as far as I can tell. I have not tested with 4 channel
items though.

Best Regards,
Manuel

On Fri, Jan 6, 2012 at 3:22 AM, Raymond Yau <superquad.vortex2@gmail.com> w=
rote:
> [PATCH ] ALSA au88x0 - Fix IRQ fifo error and channels swap of 4
> channels playback
>
> - Fix IRQ fifo error when playing stereo by set stereo flag of fifo contr=
ol
> =A0This also fix the swap of front and rear channels on au8830
>
>
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1840
>
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1726
