From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Tue, 08 Jun 2010 16:40:22 +0100
Message-ID: <hulo7u$oe7$1@dough.gmane.org>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>	<hp744t$5b5$1@dough.gmane.org>	<r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>	<hqbv5m$cmf$1@dough.gmane.org>	<g2t4f3252891004201932k53dae8a1me8f7e968f8a28b5b@mail.gmail.com>	<hqmbmm$hsj$1@dough.gmane.org>	<i2r4f3252891004211816ldfedff21nfe61537043c9b22f@mail.gmail.com>	<htls4d$phr$1@dough.gmane.org>
	<4BFE7840.4070004@ladisch.de>	<htm0et$eb4$1@dough.gmane.org>
	<htm9mn$n1c$1@dough.gmane.org>	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>	<huicj9$t30$1@dough.gmane.org>
	<AANLkTil4q611GLiV-k1vO2Svepg_kioyUypp2rWNslxR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 86567103912
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 17:39:52 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OM0u7-0004mL-6O
	for alsa-devel@alsa-project.org; Tue, 08 Jun 2010 17:39:51 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2010 17:39:51 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2010 17:39:51 +0200
In-Reply-To: <AANLkTil4q611GLiV-k1vO2Svepg_kioyUypp2rWNslxR@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Raymond Yau at 08/06/10 05:01 did gyre and gimble:
> According to your email , you mention than your hardware has a cutoff at 14%
> in PA

It's actually closer to about 16%... but in that area yes.

> the mixer application programmer  can select any kind of scaling in the
> slider

Indeed, but pulseaudio exposes a pa_volume_t which is basically a linear
scale. This upper bound is exposed via a constant: PA_VOLUME_MAX

pulse/volume.h:113:#define PA_VOLUME_MAX ((pa_volume_t) UINT32_MAX-1)

And the "100%" aka 0dB point is represented by another constant,
PA_VOLUME_NORM:

pulse/volume.h:107:#define PA_VOLUME_NORM ((pa_volume_t) 0x10000U)

The scale between 0 and PA_VOLUME_NORM is linear via pa_volume_t but
this is mapped via the cubic mapping internally when controling the
volume of the alsa device.

So volume control GUIs and the ALSA plugin use this scale in a linear
fashon to represent the rand 0% (pa_volume_t = 0) to 100% (pa_volume_t =
PA_VOLUME_NORM).

> do you mean 14% in pavucontrol or Master volume control of "pulse" device ?

Both. They both use the range 0 ... PA_VOLUME_NORM to represent 0% -
100% and thus they correspond with each other fine[1]

> but pavucontrol did not provide any dB value at any point

It doesn't display the dB value, but perhaps it should? It's more of a
developer tool anyway (tho' used by a lot of users until desktop
provided tools catch up) so exposing dB here would make sense IMO. I'll
cook up a patch.



Col


1. Note that this may change at some point in the future as we define
how much to show the user as an "overdrive" of volume. As you may know,
gnome-volume-control allows a setting up to 150%, but this isn't
refelected in the alsa plugin. Ultimately we decided to define a new
constant "PA_VOLUME_OVERDRIVE" (or similar, I can't remember the exact
name) and set this to be +11dB (via the current cubic mapping function).
This approximates to the 150% offered in g-v-c.

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
