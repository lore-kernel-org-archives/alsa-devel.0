From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: snd jack report and unsolicited event ad1988
Date: Thu, 5 May 2011 15:05:41 +0800
Message-ID: <BANLkTikbOGHJp9VJ+yyA4dJxgcbuNk4LeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1489210393D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 09:06:05 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1533867fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 05 May 2011 00:06:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/28 Takashi Iwai <tiwai@suse.de>

> At Thu, 28 Apr 2011 21:10:23 +0800,
> Raymond Yau wrote:
> >
>
> > Still unable to enable the unsolicited event for jack sense even if I a=
dd
> > the unsol_event and verb for the audio jacks at rear panel since I don't
> > have the HDA compilant front audio panel
> >
> > SoundMax automatically popup immediately when jack is plug into the rear
> > panel at other OS, so the hardware is capable of jack sense at rear pan=
el
> >
> > AFG Function Id: 0x1 (unsol 0)
> >
> > Is there any trick to enable/debug the unsolicited event ?
> > seem unsol event is disabled in the HDA controller
>
> No, there shouldn't be big differences.  Otherwise it won't work on
> any other machines.
>
> There might be other way to trigger the jack detection, e.g. GPIO
> unsolicited event, depending on the codec chip.  I don't remember how
> is AD1988, though...
>
>
> OK, after a few experiments, unsolicited events seem to work for those re=
ar
panel jacks

1) for the unsolicited event , different tags have to be assigned for six
different jacks

This mean that the driver need to define FRONT_MIC_EVENT, REAR_MIC_EVENT,
LINE_IN_EVENT in addition to HP_EVENT

Can  snd_jack_report used to report the mic event of two pink jacks (front
panel and rear panel) of the desktop to the user space program?

2) when the jack is plug in or out. , snd_hda_jack_detect() work with
no_trigger_sense=3D1 to detect jack presence but the driver get several
unsolicited responses with no_trigger_sense=3D0

3) snd_hda_pin_sense() need trigger sense to get the Impedance
it usually get the value of 0x7FFF,FFFF and need to wait for a while to get
the sense measurement

(all1=92s) indicates that a valid sense reading is not available, or the se=
nse
measurement is busy if it has been recently triggered
