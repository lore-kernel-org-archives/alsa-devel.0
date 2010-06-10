From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Thu, 10 Jun 2010 17:11:21 +0100
Message-ID: <hur2pt$uaa$1@dough.gmane.org>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>	<hp744t$5b5$1@dough.gmane.org>	<r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>	<hqbv5m$cmf$1@dough.gmane.org>	<g2t4f3252891004201932k53dae8a1me8f7e968f8a28b5b@mail.gmail.com>	<hqmbmm$hsj$1@dough.gmane.org>	<i2r4f3252891004211816ldfedff21nfe61537043c9b22f@mail.gmail.com>	<htls4d$phr$1@dough.gmane.org>
	<4BFE7840.4070004@ladisch.de>	<htm0et$eb4$1@dough.gmane.org>
	<htm9mn$n1c$1@dough.gmane.org>	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>	<huicj9$t30$1@dough.gmane.org>	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>	<hulnlp$m00$1@dough.gmane.org>
	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 22A4410398A
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jun 2010 18:11:12 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OMkLT-0007Kf-Rv
	for alsa-devel@alsa-project.org; Thu, 10 Jun 2010 18:11:08 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2010 18:11:07 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2010 18:11:07 +0200
In-Reply-To: <AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 10/06/10 04:16 did gyre and gimble:
> Can you explain how PA handle the volume controls of ac97 codec ?
> 
> PCM -34.5dB to +*12* dB
> Master -46.5dB to 0dB
> 
> The total dB range (PCM + MASTER) is -81dB to +*12*dB
> 
> 
> Most user concern about recording without distrotion. (i.e. best result when
> Capture Volume at 0dB , PCM and Master Volume at 0dB ) and they need where
> are 0dB points

I'm not 100% sure how this is handled, but I know it's not ignored.
You'll have to ask Lennart directly or dig in the code to see for sure.

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
