From: Allan Klinbail <allan_k@dodo.com.au>
Subject: Re: [ALSA - driver 0001203]: mtpav driver locks X on
	64 bit native system
Date: Sun, 19 Jun 2005 05:29:58 +0000
Message-ID: <1119158998.7907.21.camel@daw.littlewolf>
References: <f382266181b7df693688899c474656a3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from relay02.mail-hub.dodo.com.au (relay02.mail-hub.dodo.com.au [202.136.32.45])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 25D791A2
	for <alsa-devel@alsa-project.org>; Sun, 19 Jun 2005 08:54:35 +0200 (MEST)
In-Reply-To: <f382266181b7df693688899c474656a3@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: bugtrack@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

HI All 

While I would prefer to use the mtpav, I can get away using my usb midi
device. As such I'm happy to test any patches e.t.c... 

cheers

Allan 


On Sun, 2005-06-19 at 08:51 +0200, bugtrack@alsa-project.org wrote:
> The following issue has been SUBMITTED.
> ======================================================================
> <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1203> 
> ======================================================================
> Reported By:                sonofzev
> Assigned To:                
> ======================================================================
> Project:                    ALSA - driver
> Issue ID:                   1203
> Category:                   GENERIC - mtpav
> Reproducibility:            always
> Severity:                   crash
> Priority:                   normal
> Status:                     new
> Distribution:               Gentoo 2004.3 - 64-bit native
> Kernel Version:             2.6.9 or 2.6.11 or 2.6.12
> ======================================================================
> Date Submitted:             06-19-2005 08:51 CEST
> Last Modified:              06-19-2005 08:51 CEST
> ======================================================================
> Summary:                    mtpav driver locks X on 64 bit native system
> Description: 
> Locks system completely when loading X if mtpav module is already loaded. 
> 
> If loading the module after loading X, the system completely lock when
> firing up any sequencer app. 
> 
> This does not happen on my 32-bit Pentium 4 
> 
> ======================================================================
> 
> Issue History
> Date Modified  Username       Field                    Change              
> ======================================================================
> 06-19-05 08:51 sonofzev       New Issue                                    
> 06-19-05 08:51 sonofzev       Distribution              => Gentoo 2004.3 -
> 64-bit native
> 06-19-05 08:51 sonofzev       Kernel Version            => 2.6.9 or 2.6.11 or
> 2.6.12
> ======================================================================
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
-- 
Allan Klinbail <allan_k@dodo.com.au>



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
