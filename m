From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2.6.38.4 broke my audio
Date: Tue, 26 Apr 2011 10:02:47 +0800
Message-ID: <BANLkTikNMpM3zsiwvz3USTYjye17WV0_Og@mail.gmail.com>
References: <20110424113037.11af0b04@omega.digital-domain.net>
	<20110425000126.GA18681@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 00C141037EC
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 04:02:49 +0200 (CEST)
Received: by fxm5 with SMTP id 5so153588fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2011 19:02:47 -0700 (PDT)
In-Reply-To: <20110425000126.GA18681@suse.de>
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

2011/4/25 Greg KH <gregkh@suse.de>

> On Sun, Apr 24, 2011 at 11:30:37AM +0100, Andrew Clayton wrote:
> > Hi guys.
> >
> > Just upgraded to .4 from .3 and found my audio was _really_ quiet. All
> > the mixers looked sane.
> >
> > A quick check of the changelog and a revert of:
> >
> > commit 58541cc27531727f7120683a7cb123ee3ada4bd4
> > Author: Takashi Iwai <tiwai@suse.de>
> > Date:   Mon Mar 28 12:05:31 2011 +0200
> >
> >     ALSA: hda - Fix pin-config of Gigabyte mobo
> >
> >     commit c6b358748e19ce7e230b0926ac42696bc485a562 upstream.
> >
> >     Use pin-fix instead of the static quirk for Gigabyte mobos 1458:a002.
> >
> >     Bugzilla: https://bugzilla.novell.com/show_bug.cgi?id=677256
> >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> >
> > made it normal again.
>
>
According the user manal of GA-880GM-D2H

5-2-1     Configuring 2/4/5.1/7.1-Channel Audio

The motherboard provides three audio jacks on the back panel
which support 2/4/5.1/7.1(Note)-channel audio

The pictures to the right show the 7.1-channel speaker
configurations.

The bottom picture use the "Front panel HP" as "Side Speaker Out"
