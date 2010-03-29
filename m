From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Handling of the DXS controls in the via82xx driver
Date: Mon, 29 Mar 2010 09:24:33 +0800
Message-ID: <4f3252891003281824r4544d4bfv811f9c4e4d98381@mail.gmail.com>
References: <4BAE8EF7.20204@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F1453103806
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 03:24:34 +0200 (CEST)
Received: by pwj7 with SMTP id 7so7006618pwj.38
	for <alsa-devel@alsa-project.org>; Sun, 28 Mar 2010 18:24:34 -0700 (PDT)
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
> before my latest upgrade to Linux 2.6.32 (yes, sorry, it's Debian), I
> had four levers in my alsamixer: VIA DXS, VIA DXS 1, VIA DXS 2 and VIA
> DXS 3.  They controlled the hardware mixing when accessing the sound
> device multiple times.
>
> Now they have disappeared.  I think I can pretty certainly trace this
> down to commit 2fb930b53f513cbc4c102d415d2923a8a7091337 to Linux
> [
> http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.32.y.git;a=
=3Dcommit;h=3D2fb930b53f513cbc4c102d415d2923a8a7091337
> ],
> which "move[s] DXS volume controls to PCM interface".
>
> As I'm not an ALSA developer, I don't realize the intended effect of
> this change, but the actual effect is that I cannot change the DXS
> volumes any more.  mplayer still controls the global PCM volume.  Well,
> in fact, there is one way.  While an mplayer is running, I can do:
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
> I suspect that the real *bug* is that mplayer does not use the
> per-channel DXS controls even though it's supposed to (which seems to be
> why the DXS controls are called "PCM Playback Volume").
>
> Personally, rather than fixing this bug, I would just revert to the
> former state.  I was always happy with all the DXS levers set to 75%.
>
>
> Thank you
>
> S=F6ren
>

Those are per voice volume control , they can be used for the hardware
acclearation in wine if wine implmenet the real hardware acceleration

After this change , they are not used by the mixer any more , only those
application which open those subdevices can find the corresponding control
by the subdevice number
