From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsactl adds volume controls?
Date: Mon, 11 Oct 2010 09:25:50 +0100
Message-ID: <i8uhme$c09$1@dough.gmane.org>
References: <s5hr5hczi06.wl%tiwai@suse.de>
	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>
	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>
	<4CA5834D.5030408@ladisch.de>	<4CA59976.2020306@colin.guthr.ie>
	<4CA5A38A.7050006@ladisch.de>	<i8ce5u$fj3$1@dough.gmane.org>
	<4CAD7F3D.3090205@ladisch.de>	<4CAF1AF2.3060907@colin.guthr.ie>
	<4CAF1FA3.5000402@ladisch.de>	<4CAF2533.1060102@colin.guthr.ie>
	<4CAF27B7.9080909@colin.guthr.ie>	<4CAF2DD1.5050306@ladisch.de>
	<4CAF37DE.8070205@colin.guthr.ie>	<4CAF3DA0.9020908@ladisch.de>
	<AANLkTi=go5q_+zw2EMh7fSa6SesNG3s8ZXjEJHsU=B--@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C55C2440E
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 10:26:00 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P5Dhn-0004yZ-EM
	for alsa-devel@alsa-project.org; Mon, 11 Oct 2010 10:25:59 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2010 10:25:59 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2010 10:25:59 +0200
In-Reply-To: <AANLkTi=go5q_+zw2EMh7fSa6SesNG3s8ZXjEJHsU=B--@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 11/10/10 02:34 did gyre and gimble:
> How about softvol plugin , the dB scale seem wrong, it alwaysl mute at
> min_dB even if I change min_dB to -21 ?

I would suspect that this needs fixed also. David's alsamixertest does
indeed report when PCM mutes at min, to identify this error case.

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
