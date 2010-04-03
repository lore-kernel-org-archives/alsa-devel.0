From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Sat, 03 Apr 2010 11:09:33 +0100
Message-ID: <hp744t$5b5$1@dough.gmane.org>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 29389243FB
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Apr 2010 12:10:52 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Ny0J9-0000eB-3M
	for alsa-devel@alsa-project.org; Sat, 03 Apr 2010 12:10:27 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 03 Apr 2010 12:10:27 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 03 Apr 2010 12:10:27 +0200
In-Reply-To: <q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>
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

'Twas brillig, and Nicolo' Chieffo at 02/04/10 21:25 did gyre and gimble:
> I just had a discussion with pulseaudio developers in which they told
> me that if the speakers don't emit any audio when the ALSA volume is
> 0%, then the correct gain value should be -inf dB (a value lower than
> -200 for pulseaudio means mute). Unfortunately my card has -48 dB.
> 
> They also said that if with -47.25 dB (which is what I get with ALSA
> volume set to 2%) I can hear audio even if it's very very low, at -48
> dB I should still be able to hear something (the scale is
> logarithmic).
> 
> Their request is to change to -200 the gain reported from my card
> driver when the ALSA volume is set to 0%.
> Thanks

FWIW, I've got the same/similar h/w with a cutoff at 14% in PA as you
have. I've been meaning to get this fixed for a while, but I'm
incredibly lazy with certain things that don't bother me practically, so
haven't followed it up yet.

Thanks for getting the ball rolling :)

If any specific debug is needed here, feel free to ask.

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
