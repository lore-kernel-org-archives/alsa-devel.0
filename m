From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Software mixer at kernel level
Date: Tue, 10 Feb 2009 20:47:20 +0000
Message-ID: <gmsp4o$22e$1@ger.gmane.org>
References: <BAY121-W2620F292F939B826EEDC6DFBBD0@phx.gbl>	<74eb1fe20902091827w7f6020e2r58f0ba27f651de1f@mail.gmail.com>
	<4990FB35.8050205@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 334B7243A1
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 21:47:32 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LWzW0-0006LJ-1X
	for alsa-devel@alsa-project.org; Tue, 10 Feb 2009 20:47:32 +0000
Received: from 80-192-67-147.cable.ubr10.sgyl.blueyonder.co.uk
	([80.192.67.147]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 20:47:32 +0000
Received: from gmane by 80-192-67-147.cable.ubr10.sgyl.blueyonder.co.uk with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 20:47:32 +0000
In-Reply-To: <4990FB35.8050205@cox.net>
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

'Twas brillig, and stan at 10/02/09 03:57 did gyre and gimble:
> (in pulse, one size fits all).

While I don't want to comment on the finer points of this thread, I will 
say that pulse 0.9.15 will be able to switch "profiles" on the fly.

I'm not 100% sure if it currently supports switching sample rates, but 
this should be trivial to implement now if it's not.

This should allow for an app which requires high quality output to 
request a specific hardware sample rate. Not sure how this would work in 
practice in terms of what apps are allowed to do this etc. but it should 
prevent software resampling kicking in in some circumstances.

Apologies if I've misinterpreted this new functionality (and it is a 
little theoretical in terms of putting it into practice), but I think 
i'm right :)

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
