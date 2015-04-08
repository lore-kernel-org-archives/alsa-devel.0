From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Wed, 8 Apr 2015 09:29:56 +0800
Message-ID: <CAN8ccibnmaUT9r9Mrcwg4GY2vNegF+nsf0+t8_hB29_xhipRyg@mail.gmail.com>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <1427820547.2856.10.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1427891224.2711.31.camel@loki>
 <CAEUnVG4iCJGGPw2=R+TxVCoj3ky2SBgZDpZrFbswXh36b-WydA@mail.gmail.com>
 <CAN8cciaYWDECp0cP+E0i-rMbfJKn=WiEZXe0YvS9q48MmB89Ng@mail.gmail.com>
 <1428312393.2616.19.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B2F70265055
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 03:29:57 +0200 (CEST)
Received: by obbeb7 with SMTP id eb7so43655114obb.3
 for <alsa-devel@alsa-project.org>; Tue, 07 Apr 2015 18:29:56 -0700 (PDT)
In-Reply-To: <1428312393.2616.19.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, 1406355@bugs.launchpad.net
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>, Han Lu <han.lu@intel.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

> > > >
> >
> > How do these kind of jack handle by UCM ?
> >
> >
http://www.dell.com/support/home/us/en/19/product-support/product/inspiron-15-3537/manuals
> >
> > 6 Headset port Connect a headphone, a microphone, or a headphone and
> > microphone combo (headset).
> >
>
> UCM is not really needed for this device as Pulseaudio handles the
> standardised HDA jacks and routing (there is nothing stopping a UCM
> config being defined though). So for each input/output endpoint above
> you would list it's jack kcontrol in the endpoint device section. e.g.
> sound server reads jack input and type, checks UCM config and matches
> the device before setting routing according to UCM device.
>

When using hda emu and latest alsa driver with
https://launchpadlibrarian.net/193669943/AlsaInfo.txt

The driver create capture source control which allow user to select
internal mic, headset mic and headphone mic , this control change the
function of the combo jack to headphone, headset and mic

If this logic is also applied to those notebook with three physical jack:
headset, headphone and mic jack

The user need to select the headset mic , mic and internal mic using
capture source control when not using pulseaudio
