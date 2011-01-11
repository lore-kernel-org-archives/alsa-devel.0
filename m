From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsa virtual sound card (with networked output)
Date: Tue, 11 Jan 2011 15:35:42 +0000
Message-ID: <ightce$qr6$1@dough.gmane.org>
References: <AANLkTinXD8u9riu9uwhJPsdKthUHDmK5K1o_+7vv4mcU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A72F2440F
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 16:35:57 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PcgGL-0006uC-0T
	for alsa-devel@alsa-project.org; Tue, 11 Jan 2011 16:35:57 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 16:35:56 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 16:35:56 +0100
In-Reply-To: <AANLkTinXD8u9riu9uwhJPsdKthUHDmK5K1o_+7vv4mcU@mail.gmail.com>
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

'Twas brillig, and Metyl Methylius at 11/01/11 14:51 did gyre and gimble:
> Hello everyone,
> 
> I was wondering if its possible to just create a "virtual" sound card
> using alsa which will just sent its audio stream to other computer
> (using TCP/IP or UDP for example). On the other end there would be
> some kind of server (or just nc -u -l -p 31337 | aplay ). I want to do
> it on alsa layer because other aps using alsa will get immediate
> support.
> 
> It should be something like described in
> 
> http://alsa.opensrc.org/index.php/Network
> 
> but with transparent support for all alsa based applications. I dont
> care about syncronization or transmission delay. Any pointers as how
> this could be done in alsa ?

Any particular reason you cannot use PulseAudio? It support usage from
existing ALSA apps and also works automatically with SSH by
piggy-backing connection settings on X11 root windows which are
accessable when the remote connection has X11 forwarding enabled.

> This mess was sent using 100% recycled electrons. If you want to get
> rid of this mess just turn off your computer,

:)

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
