From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: RFC: OSS driver removal, a slightly different
	approach
Date: Thu, 19 Jan 2006 13:54:45 -0500
Message-ID: <1137696885.32195.12.camel@mindpipe>
References: <20060119174600.GT19398@stusta.de>
	 <1137694944.32195.1.camel@mindpipe>  <20060119182859.GW19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id BA51115E
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 19:54:47 +0100 (MET)
In-Reply-To: <20060119182859.GW19398@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-01-19 at 19:28 +0100, Adrian Bunk wrote:
> On Thu, Jan 19, 2006 at 01:22:23PM -0500, Lee Revell wrote:
> > On Thu, 2006-01-19 at 18:46 +0100, Adrian Bunk wrote:
> > > 3. no ALSA drivers for the same hardware
> > > 
> > > SOUND_SB 
> > 
> > ALSA certainly does support "100% Sound Blaster compatibles (SB16/32/64,
> > ESS, Jazz16)", it would be a joke if it didn't...
> 
> That's not the problem, I should have added an explanation:
> 
> SOUND_SB (due to SOUND_KAHLUA and SOUND_PAS)
> 

Hmm.  From sound/oss/kahlua.c:

/*
 *      Initialisation code for Cyrix/NatSemi VSA1 softaudio
 *
 *      (C) Copyright 2003 Red Hat Inc <alan@redhat.com>
 *

Why was a new OSS driver written and accepted at such a late date, when
OSS was already deprecated?

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
