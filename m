From: Tim <terminator356@users.sourceforge.net>
Subject: Re: multi pcm and mmap problem
Date: Sat, 1 Dec 2007 18:33:35 -0500
Message-ID: <200712011833.36219.terminator356@users.sourceforge.net>
References: <200711210158.42108.terminator356@users.sourceforge.net>
	<200711261746.59712.terminator356@users.sourceforge.net>
	<s5habozkcks.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp106.rog.mail.re2.yahoo.com (smtp106.rog.mail.re2.yahoo.com
	[68.142.225.204]) by alsa0.perex.cz (Postfix) with SMTP id 77C2624600
	for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2007 00:19:09 +0100 (CET)
In-Reply-To: <s5habozkcks.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi, after a week of testing your multi-plughw patch 
 I'm satisfied it works fine.

One odd thing is that when I start Jack, sometimes I 
 immediately get a series of ever increasing xruns,
 sometimes hundreds of them with each display update of QJackctl.
Simply restarting QJackctl cures it and it runs for many hours 
 without trouble.
I am not convinced it has anything to do with your patch,
 maybe just my new .asoundrc and new altered setup.

Also, I never have tested any multi playback configuration, just record. 
When I get a chance I will test it.

Thanks. Tim.
