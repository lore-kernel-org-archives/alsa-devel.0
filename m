From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Sat, 23 Oct 2010 19:51:24 +0800
Message-ID: <AANLkTikajDQp7rLk4ZXp60ebOBhUG3opVH+Mm6a203iC@mail.gmail.com>
References: <4C77CE1D.2070501@canonical.com>
	<4C77DD09.3060909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C9E88243C8
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Oct 2010 13:51:25 +0200 (CEST)
Received: by eyg24 with SMTP id 24so883304eyg.38
	for <alsa-devel@alsa-project.org>; Sat, 23 Oct 2010 04:51:25 -0700 (PDT)
In-Reply-To: <4C77DD09.3060909@ladisch.de>
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

2010/8/27 Clemens Ladisch <clemens@ladisch.de>

> David Henningsson wrote:
> > So I've discovered that my sound card has a "PCM Playback Volume"
> > control, but changing that control does not alter the volume.
> >
> > Interestingly enough, this control does not come from the HDA parser, it
> > is added by alsactl at boot time...!
>
> This control was created by the software volume plugin.  When not using
> this plugin, the control does not have any effect.
>
> To get rid of it, delete its entry from /etc/asound.state.
>

May be the problem is related to those virtual Master Playback Volume /
Playback Switch

If the user has set the volume of slave controls to different level and use
alsactl to store the values in /etc/asound.state

Those slaves of the virtual master volumes are restored before the virtual
Master Volume
but the restore of virtual master volume set the volume control of all
slaves to same level

Is this the reason why kmix remove the left/right balance control ?
