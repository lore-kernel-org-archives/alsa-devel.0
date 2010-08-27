From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Sat, 28 Aug 2010 06:58:20 +0800
Message-ID: <AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>
References: <4C77CE1D.2070501@canonical.com> <4C77DD09.3060909@ladisch.de>
	<4C78059B.50801@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CE581038BE
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 00:58:23 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2390807ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 15:58:23 -0700 (PDT)
In-Reply-To: <4C78059B.50801@canonical.com>
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

2010/8/28 David Henningsson <david.henningsson@canonical.com>

> 2010-08-27 17:43, Clemens Ladisch skrev:
> > David Henningsson wrote:
> >> So I've discovered that my sound card has a "PCM Playback Volume"
> >> control, but changing that control does not alter the volume.
> >>
> >> Interestingly enough, this control does not come from the HDA parser, it
> >> is added by alsactl at boot time...!
> >
> > This control was created by the software volume plugin.  When not using
> > this plugin, the control does not have any effect.
> >
> > To get rid of it, delete its entry from /etc/asound.state.
>
> Hmm, I wonder if this is an Ubuntu-specific bug then? Because when I run
> Maverick (the upcoming Ubuntu release) from a Live-CD, the "PCM Playback
> Volume" control is still there (and there is no asound.state, neither in
> /etc or in /var/lib/alsa).
> When I use the plughw interface, the "PCM Playback Volume" does not
> affect volume output. Should I use another device string to test the
> softvol plugin, to see if it's there or not?
>

The softvol plugin it is defined in "front" device in
/usr/share/alsa/cards/HDA-Intel.conf

reason is some HDA codec does not has any hardware volume control (analog)

this user-defined control only effective when the application use "front"
device

it is a bug in PA server to open "front" device for playback and capture

it is not easy to remove the control unless you know the trick

shutdown without alsactl store
