From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: HDA: Fix front mic on Dell Precision
	M6500
Date: Tue, 24 Aug 2010 08:57:55 +0800
Message-ID: <AANLkTin4X_gNKCeuEbFZ87QcUybx+AuGV7HSaXNEZsLT@mail.gmail.com>
References: <4C72C5EF.6090600@canonical.com> <1282590450.2600.9.camel@laptop>
	<4C72CB43.2040800@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id EF93E24545
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 02:57:57 +0200 (CEST)
Received: by ewy21 with SMTP id 21so3017667ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 17:57:57 -0700 (PDT)
In-Reply-To: <4C72CB43.2040800@canonical.com>
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

2010/8/24 David Henningsson <david.henningsson@canonical.com>

> I admit that the best thing would be to make the driver support all
> three mics, but at this point, the alsa driver can only support two, one
> called "mic" and one called "front mic". I believe the best choice is to
> select the internal mic as "front mic" and the mic jack on the laptop as
> "mic", thus leaving the docking station mic jack non-functional.
>
> The behavior without this patch is to select the mic jack on the laptop
> as "mic" and the mic on the docking station as "front mic", thus leaving
> the internal mic non-functional in all cases, and that regardless of you
> have a docking station or not.
>
> 2010-08-23 21:07, Jerone Young skrev:
> > For laptops you would want to take preference of the docking jack over
> > the interal mic if you are in a docking station.
> >
> > So if you do plug into a docking station and you have a microphone in
> > the docking station, a user would want to use that over the internal
> > microphone. You wouldn't want the laptop internal mic preferred over the
> > docking station microphone.
> >
> >                               Thanks,
> >                                       Jerone
> >
> > On Mon, 2010-08-23 at 21:03 +0200, David Henningsson wrote:
> >> The BIOS of Dell Precision M6500 lists both 0x0e and 0x11 as
> >> front mics, and the driver only supports one front mic. This
> >> commit adds a quirk for preferring node 0x11 (internal mic) to
> >> node 0x0e (possibly docking station mic).
> >>
> >> Alsa-info reference:
> >> http://launchpadlibrarian.net/54232083/alsa-info.txt.xyFVpIysHt
> >>
>

There are two ADC , this mean that the correct model should provide two
capture subdevices instead of one

Node 0x15 [Audio Input] wcaps 0x1d0541: Stereo
  Device: name="STAC92xx Analog", type="Audio", device=0
  Converter: stream=1, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x17
  Processing caps: benign=0, ncoeff=0
Node 0x16 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x18
  Processing caps: benign=0, ncoeff=0
