From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Handling of the DXS controls in the via82xx driver
Date: Mon, 29 Mar 2010 09:39:53 +0800
Message-ID: <4f3252891003281839h6a1ca85bi2339fef37e6929cc@mail.gmail.com>
References: <4BAE8EF7.20204@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f198.google.com (mail-pz0-f198.google.com
	[209.85.222.198])
	by alsa0.perex.cz (Postfix) with ESMTP id EBD2B10381A
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 03:39:54 +0200 (CEST)
Received: by pzk36 with SMTP id 36so1391609pzk.24
	for <alsa-devel@alsa-project.org>; Sun, 28 Mar 2010 18:39:54 -0700 (PDT)
In-Reply-To: <4BAE8EF7.20204@gmx.de>
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

2010/3/28 Soeren D. Schulze <soeren.d.schulze@gmx.de>

> Hi everyone,
>
> amixer cset numid=3D47,iface=3DPCM,name=3D'PCM Playback Volume' 24,24
>
> When restarting mplayer, the volume is reset to 31,31 (maximum).  Commit
> 3d00941371a765779c4e3509214c7e5793cce1fe
> [
> http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.33.y.git;a=
=3Dcommit;h=3D3d00941371a765779c4e3509214c7e5793cce1fe
> ]
> seems to be responsible for this.
>
> The bad thing about it is that 31,31 is a really bad setting for my
> poorly engineered sound card.  It distorts a lot.
>
>
>
> S=F6ren
>

In theory , the driver should reset the per voice volume control to 0dB
after the subdevice is opened , may be something wrong in dB scale of these
volume control  if you get distorted sound
