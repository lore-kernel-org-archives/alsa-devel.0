From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Device creation order
Date: Fri, 03 Apr 2009 11:34:00 +0100
Message-ID: <gr4omo$dct$1@ger.gmane.org>
References: <20090403015429.GA702@tango.0pointer.de>	<alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>	<20090403072030.GB15466@buzzloop.caiaq.de>
	<alpine.LNX.2.00.0904030921280.17368@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 10E581037EB
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 12:34:15 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lpgiy-0002C9-II
	for alsa-devel@alsa-project.org; Fri, 03 Apr 2009 10:34:12 +0000
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 03 Apr 2009 10:34:12 +0000
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 03 Apr 2009 10:34:12 +0000
In-Reply-To: <alpine.LNX.2.00.0904030921280.17368@eeebox2.perex-int.cz>
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

'Twas brillig, and Jaroslav Kysela at 03/04/09 08:31 did gyre and gimble:
> Lennart, why you need to enumerate all devices per card at one time? I 
> think that having mixer access plus one PCM device is enough for minimal 
> configuration for PA.

PA now has a concept of "cards". The hal-detect module will load the 
module-alsa-card module which in turn will probe the "card" in question 
to see what it supports.

As alsa does not export information such as what parts of the card can 
be used concurrently, the module-alsa-card has to be able to probe e.g. 
5.1 output + stereo input to see if it works. From this probing, we can 
build up a list of "Card Profiles" so we can let the user pick their 
configuration[1] they want. When a user changes configuration, it will 
take care of loading the individual module-alsa-sink and 
module-alsa-source modules for dealing with the actual output/input.

Hope that explains why the whole card is needed rather than just a 
single PCM.

Col

See:
http://colin.guthr.ie/development/configuring-card-profiles-in-pulseaudio.html

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
