From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Sat, 25 Sep 2010 14:07:49 +0100
Message-ID: <i7ks75$39j$1@dough.gmane.org>
References: <alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>	<1283864698.3048.26.camel@odin>	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>	<i781vn$nhb$1@dough.gmane.org>	<AANLkTin8fTA0CoUiPzASG4kepbSyWiDf7xrX-iJB8EQA@mail.gmail.com>	<alpine.LNX.2.00.1009211938110.6226@eeebox2.perex-int.cz>	<20100922132052.GC32476@sirena.org.uk>	<alpine.LNX.2.00.1009221544480.6226@eeebox2.perex-int.cz>	<20100922151419.GF26395@rakim.wolfsonmicro.main>	<alpine.LNX.2.00.1009221950540.6226@eeebox2.perex-int.cz>	<20100922184817.GT26395@rakim.wolfsonmicro.main>
	<AANLkTimJQeLohP-3q=Qe1VrEe9DUuC+DZUJoyXDxKBSk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 82204103818
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Sep 2010 15:07:57 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OzUTt-0001J7-3k
	for alsa-devel@alsa-project.org; Sat, 25 Sep 2010 15:07:57 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2010 15:07:57 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2010 15:07:57 +0200
In-Reply-To: <AANLkTimJQeLohP-3q=Qe1VrEe9DUuC+DZUJoyXDxKBSk@mail.gmail.com>
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

'Twas brillig, and Niels Mayer at 23/09/10 08:18 did gyre and gimble:
> IMHO, such a layer could obviate the need for pulseaudio and instead
> dynamically  invoke the appropriate ALSA constructs (dmix, dsnoop,
> plug, etc) needed to satisfy application constraints against hardware
> limitations.

I completely fail to see how this construct replaces PulseAudio.. The
UCM support is intended to be implemented in PA. We currently already
have a "poor man's UCM" in PA as we probe many popular configurations on
init to determine a list of "Profiles" the user can select. Once the UCM
stuff is available in ALSA, we (or rather Liam :p) can try and use UCM
instead of htis probing scheme. As not all h/w will instantly support
UCM metadata, the probing scheme will still be used as a fall back.

But obtaining these profiles is actually a very small part of PA. There
are many other things that PA does that is totally beyond this scope and
I see no way for ontologies or otherwise to implement those capabilities
and features.

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
