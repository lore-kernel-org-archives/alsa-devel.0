From: Allan Klinbail <allan_k@dodo.com.au>
Subject: Re: [ALSA - driver 0001203]: mtpav driver locks X on
	64 bit native system
Date: Thu, 08 Sep 2005 16:36:48 +1000
Message-ID: <1126161408.9937.7.camel@daw.littlewolf>
References: <4a2952cca628b67c731e72971c492bf2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from relay02.mail-hub.dodo.com.au (relay02.mail-hub.dodo.com.au [202.136.32.45])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3B06D1BD
	for <alsa-devel@alsa-project.org>; Thu,  8 Sep 2005 08:35:24 +0200 (MEST)
Received: from [220.240.117.145] (helo=[10.0.0.1])
	by relay02.mail-hub.dodo.com.au with esmtp (Exim 4.34)
	id 1EDG0D-0007jn-11
	for alsa-devel@alsa-project.org; Thu, 08 Sep 2005 16:35:18 +1000
In-Reply-To: <4a2952cca628b67c731e72971c492bf2@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is any work being done on this... 

To my horror and disgust for work purposes I needed to install winblows
on the amd64 and the MOTU proprietary 32 bit driver works...

This simply confirms I have all my printer port settings correct in
BIOS...  

On Mon, 2005-06-27 at 19:39 +0200, bugtrack@alsa-project.org wrote:
> A NOTE has been added to this issue.
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
> Last Modified:              06-27-2005 19:39 CEST
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
> ----------------------------------------------------------------------
>  tiwai - 06-27-05 16:57 
> ----------------------------------------------------------------------
> Yes.  The driver doesn't probe but just trusts the module option (or uses
> the default value 7 blindly).
> 
> ----------------------------------------------------------------------
>  sonofzev - 06-27-05 19:39 
> ----------------------------------------------------------------------
> confirmed that I am using IRQ7 for my printer port.
> 
> Issue History
> Date Modified  Username       Field                    Change              
> ======================================================================
> 06-19-05 08:51 sonofzev       New Issue                                    
> 06-19-05 08:51 sonofzev       Distribution              => Gentoo 2004.3 -
> 64-bit native
> 06-19-05 08:51 sonofzev       Kernel Version            => 2.6.9 or 2.6.11 or
> 2.6.12
> 06-19-05 16:05 sonofzev       Note Added: 0005089                          
> 06-19-05 16:24 sonofzev       Note Deleted: 0005089                        
> 06-20-05 13:47 sonofzev       Note Added: 0005097                          
> 06-21-05 11:25 tiwai          Note Added: 0005104                          
> 06-26-05 10:54 sonofzev       Note Added: 0005261                          
> 06-27-05 16:57 tiwai          Note Added: 0005281                          
> 06-27-05 19:39 sonofzev       Note Added: 0005286                          
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
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
