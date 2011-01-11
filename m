From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Adding a "capture" device naming scheme
Date: Tue, 11 Jan 2011 18:40:01 +0000
Message-ID: <igi861$q8o$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E049103895
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 19:40:17 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Pcj8j-00023q-3x
	for alsa-devel@alsa-project.org; Tue, 11 Jan 2011 19:40:17 +0100
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 19:40:17 +0100
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 19:40:17 +0100
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

Hi,

As has been pointed out a few times, it's incorrect to use "front:" for
capture, but can we have an official name/wrapper (I'm unsure of the
terminology here) for this so we don't use hw: for recording?

I'd be in favour of "capture:" or "input:" as these both seem quite
logical and easy to understand.

It would be used thusly:

  arecord -f S16_LE -c 2 -D capture:CARD=Intel

as opposed to the incorrect:
  arecord -f S16_LE -c 2 -D front:CARD=Intel
or the low level:
  arecord -f S16_LE -c 2 -D hw:CARD=Intel

Keeping it wrapped up allows for e.g. softvol or other things to be
plugged in as appropriate in the config and thus future proofs things a
little.

If someone could point me roughly in the right direction I'll make a
patch. I suspect it'll be easy enough to cook up the relevant config
needed (and I suspect it's just config rather than code that needs
patched, but I could be wrong).

It would be nice to get this into a release (alsa-lib?) soon so that it
can propigate and we can require it.

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
