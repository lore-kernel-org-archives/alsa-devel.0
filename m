From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Mixer volume/decibel mapping
Date: Thu, 27 May 2010 14:32:31 +0100
Message-ID: <htls8t$phr$2@dough.gmane.org>
References: <201005191834.57919.vand2@gmx.de>	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>	<4BF629B3.9020904@ladisch.de>	<201005210951.36495.peter.ujfalusi@nokia.com>	<4BF658C6.4030404@ladisch.de>	<AANLkTikXWtp87B0Gq_B-vQZXZlBl_MEBqbuHt6N5cTbi@mail.gmail.com>	<4BFB8C89.3010207@ladisch.de>	<AANLkTimNj_7k_l7nKLk87towdjtN5j0CSdmws02gpg8v@mail.gmail.com>
	<AANLkTim4sq_jBHYvxnLk2Pw5bdUDEMJahHPBJGIXH8ds@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id F3247103A53
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 15:35:05 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OHdEl-00031D-Su
	for alsa-devel@alsa-project.org; Thu, 27 May 2010 15:35:03 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 15:35:03 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 15:35:03 +0200
In-Reply-To: <AANLkTim4sq_jBHYvxnLk2Pw5bdUDEMJahHPBJGIXH8ds@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 26/05/10 00:24 did gyre and gimble:
> only one of the PA developer complain about his HDA codec has incorrect dB
> range but not willing to provide alsa-info.sh

I presume you mean me :) I had a hunt through the many mails you sent on
the previous thread and found such a request I'd obviously missed the
first time round. Sorry about that. Not unwilling, just unaware.

I've attached the output to a reply in the other thread.

> There is a patch which may affect the dB scale
> 
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=7c7767ebe2fa847c91a0dd5551ca422aba359473;hp=29fdbec2dcb1ce364812778271056aa9516ff3ed

Interesting. I wonder if this ties in time wise of when I noticed this
working..... If I find time to play, I'll maybe try reverting this to
see if it helps.

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
