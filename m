From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Expected behaviour for two mic jacks
Date: Sun, 14 Nov 2010 16:14:21 +0000
Message-ID: <ibp1sr$nvs$2@dough.gmane.org>
References: <4CDD0DDB.9020509@canonical.com>
	<AANLkTikJR7D-4X2ivznG0-RgQDJXA8yx_RHMkc5nBens@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id BB2671037EA
	for <alsa-devel@alsa-project.org>; Sun, 14 Nov 2010 17:14:39 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PHfDy-0004xM-MF
	for alsa-devel@alsa-project.org; Sun, 14 Nov 2010 17:14:38 +0100
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 14 Nov 2010 17:14:38 +0100
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 14 Nov 2010 17:14:38 +0100
In-Reply-To: <AANLkTikJR7D-4X2ivznG0-RgQDJXA8yx_RHMkc5nBens@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 14/11/10 01:01 did gyre and gimble:
> The main point is pulseaudio does not support more than 2 sources on one
> sound card

Sure it does, it's just not something that is probed for by default. All
you need to do is write an appropriate mixer profile (see
/usr/share/pulse/alsa-mixer/

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
