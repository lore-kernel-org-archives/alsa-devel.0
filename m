From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Weird sound issue on 2.6.36
Date: Tue, 26 Oct 2010 08:40:46 +0100
Message-ID: <4CC685FE.1010706@colin.guthr.ie>
References: <AANLkTimd_ukkeT1Y7w5p-T20Y+yPwFD6uH1_Tmuubnbw__13989.8699046627$1288072993$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 816B9103815
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Oct 2010 09:40:55 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PAe9N-0006Nd-Ri
	for alsa-devel@alsa-project.org; Tue, 26 Oct 2010 09:40:53 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2010 09:40:53 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2010 09:40:53 +0200
In-Reply-To: <AANLkTimd_ukkeT1Y7w5p-T20Y+yPwFD6uH1_Tmuubnbw__13989.8699046627$1288072993$gmane$org@mail.gmail.com>
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

'Twas brillig, and Felipe Contreras at 24/10/10 23:07 did gyre and gimble:
> Hi,
> 
> I suddenly noticed that sound is not working on 2.6.36; there's no
> error, or warning, everything seems to be working, but there's no
> sound coming out.
> 
> I tried the rc's and AFAICR it was working fine, maybe I changed the
> config, but everything seems to be ok. I went back to the rc's and
> still couldn't get them to work. 2.6.35.7 works though.
> 
> I'm attaching the config.

Mentioning what sound chip you have would probably be a good start :p

There is a regression with Intel HDA - Analog Devices (adNNNN) chips in
.36, so first random guess would be that.

See the "snd-hda-intel + ad198x is broken with 2.6.36" if this applies
to you.

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
