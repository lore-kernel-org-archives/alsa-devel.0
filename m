From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Thu, 27 May 2010 18:21:45 +0100
Message-ID: <htm9mn$n1c$1@dough.gmane.org>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>	<hp744t$5b5$1@dough.gmane.org>	<r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>	<hqbv5m$cmf$1@dough.gmane.org>	<g2t4f3252891004201932k53dae8a1me8f7e968f8a28b5b@mail.gmail.com>	<hqmbmm$hsj$1@dough.gmane.org>	<i2r4f3252891004211816ldfedff21nfe61537043c9b22f@mail.gmail.com>	<htls4d$phr$1@dough.gmane.org>	<4BFE7840.4070004@ladisch.de>
	<htm0et$eb4$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 94E3A103A82
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 19:21:41 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OHgm3-0007PG-9y
	for alsa-devel@alsa-project.org; Thu, 27 May 2010 19:21:39 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 19:21:39 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 19:21:39 +0200
In-Reply-To: <htm0et$eb4$1@dough.gmane.org>
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

'Twas brillig, and Colin Guthrie at 27/05/10 15:43 did gyre and gimble:
> PA should play nice with the softvol plugin so I don't think this is the
> bit that is at fault.
> 
> I strongly suspect that the reason has already been correctly identified
> a while ago, which is that this card considers -48dB silent where as PA
> assumes this level is -200dB. I believe it was Raymond who pointed out
> the -48dB level in the HDA spec before on this list.
> 
> I'm not sure of the internals, but things do indeed go silent when the
> volume reaches the magic -48dB mark (which is around the 14% mark with
> the current cubic mapping).
> 
> I suspect that if I were to define infinity to be 48.0 in PA, everything
> would work nicely.

I'm wrong (surprise, surprise!). Changing this value makes very little
difference.

FWIW, the -200dB thing is just a work around for systems that do not
define INFINITY. On my system this is defined. in bits/inf.h

So the value of 200dB mentioned by Raymond is not actually used
generally speaking.

Even if I undef and define INFINITY to be 48, the actual shut down at
-48 seems to happen regardless.

Looking at this in more depth, it seems that the problem is such that
the Master control of my card controls things down to -46.5dB. Once that
has hit 0, the PCM control takes over and goes down to -51dB

It seems that PA's full scale is determined as the multiplication of
thse two elements; therefore: -97.5dB.

However as things basically go silent at -48dB, the inclusion of Master
and PCM controls represent too large a range.

So either the 48dB of the HDA spec should be split between Master and
PCM more evenly, (e.g. 24dB each) or PCM should be removed and Master
should just have the full 48dB range. I don't really understand the
Master<->PCM relationship, but this is certainly and issue.


So my second guess (having now abandoned the idea of a problem in PA's
-inf definition) is that fixing the above, should fix things :)

Col

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
