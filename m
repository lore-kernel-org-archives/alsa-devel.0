From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCHES] Integrate minimal systemd support in
	alsa-utils
Date: Wed, 24 Nov 2010 17:55:28 +0000
Message-ID: <icjjig$3ft$1@dough.gmane.org>
References: <20101123021657.GA17275@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id E08CD2444A
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 18:55:40 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PLJZE-0001HV-8b
	for alsa-devel@alsa-project.org; Wed, 24 Nov 2010 18:55:40 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 18:55:40 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 18:55:40 +0100
In-Reply-To: <20101123021657.GA17275@tango.0pointer.de>
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

'Twas brillig, and Lennart Poettering at 23/11/10 02:16 did gyre and gimble:
> +udevrulesdir=/lib/udev/rules.d
> +

This doesn't appear to be used unless I missed something?

If it were used, I'd rather make this configurable. Obviously udev
pretty much mandates this path but it's a PITA when doing non-root make
installs to custom prefixes when it's hard coded like this. But like I
say, this looks unused here...

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
