From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
 is exceptionally large: 349696 bytes (1821 ms).
Date: Thu, 31 Dec 2009 11:41:56 +0000
Message-ID: <hhi2m3$26b$1@ger.gmane.org>
References: <1261191766.18070.10.camel@localhost.localdomain>	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>	<1261352484.18070.47.camel@localhost.localdomain>	<1261869811.30924.69.camel@localhost.localdomain>	<4f3252890912261739x372fb678yde8a8e0edb93fe6e@mail.gmail.com>	<1261947691.24632.29.camel@localhost.localdomain>	<4f3252890912272114t6dcfa58bj4d5b5e6e606c5004@mail.gmail.com>	<1262058553.20808.15.camel@localhost.localdomain>
	<4f3252890912292307qc3c4b29m98c7d6e4c8fd6a7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 839EE1037FF
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 12:42:19 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NQJQ1-0002wL-MC
	for alsa-devel@alsa-project.org; Thu, 31 Dec 2009 12:42:17 +0100
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 12:42:17 +0100
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 12:42:17 +0100
In-Reply-To: <4f3252890912292307qc3c4b29m98c7d6e4c8fd6a7d@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 30/12/09 07:07 did gyre and gimble:
> Why do PA server try to open an non-existing device iec958 so many times ?

It has to try and open the device several times to probe for available
profiles. This is only done at startup and then cached for the duration
of the run in the form of a list of available profiles.

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
