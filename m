From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: ALSA/pulseaudio problem workaround
Date: Thu, 17 Mar 2011 09:58:58 +0000
Message-ID: <4D81DB62.8090900@colin.guthr.ie>
References: <AANLkTinGB1-Ft0B98_Z9TnFkL+Pqd8VPVKy4bEC57c8n@mail.gmail.com>	<4D7E2BB0.7080108@colin.guthr.ie>	<AANLkTimGLW1B=aKmw4Y1Znxee5u=F=P-hAWzr3L_OYN8@mail.gmail.com>	<4D7EA24B.7080304@colin.guthr.ie>
	<AANLkTim-jqhW-7hMrwuWQ1oYqt+PtxPX8iLGXzWh0BqV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 4726E103974
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 10:59:00 +0100 (CET)
In-Reply-To: <AANLkTim-jqhW-7hMrwuWQ1oYqt+PtxPX8iLGXzWh0BqV@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Craig Bourne <craigbourne@gmail.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Craig Bourne at 16/03/11 17:57 did gyre and gimble:
> Contrary to the expectations expressed by both Colin and Fernando, the
> rate of success in getting audio output from Fedora 14 applications
> without any tinkering in these first few tests (somewhat less than
> 20%) is, if anything, higher than I would expect based on my
> experience.

While you tests are interesting, I'm not really sure they are relevant
to the ALSA mailing list.

This is primarily a distribution-related discussion in how things are
configured and setup OOTB on a Fedora install.

It is perhaps more appropriate to that that discussion to a
fedora-specific list.

If you keep me CC'ed in such discussions, I'd be happy to lent any
insights I can.

In order to integrate PulseAudio properly in a distribution, many
different components are configured to use PA by default. This includes
e.g. Phonon on KDE, GStreamer and other audio output libraries (e.g.
libao) and applications (e.g. mplayer). Many of these apps/framesworks
should degrade gracefully in the event that PA is not running, but some
may require specific setup to use alsa directly if the OOTB experience
is designed to be a PA-based one. Depending on how much effort the
distribution puts on to making PA optional will depend on your
experience in this regard.

I would recommend testing your results against, e.g. Mandriva (or the
Mageia alpha2) which offers a ticky box to disable PA and see how you
get on. If the results are the same then I can help look at this as a
more distro-agnostic issue, but if it works fine, then you obviously
need to go poke Fedora.

But like I say, this discussion actually has very little to do with the
upstream ALSA project.

Cheers

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
