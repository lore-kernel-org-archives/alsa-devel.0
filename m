From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002122]: DMIX crashes Ekiga
Date: Tue, 16 May 2006 11:19:47 +0200
Message-ID: <279370912e55ac7db7731b69bc2097ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F1285233
	for <alsa-devel@alsa-project.org>; Tue, 16 May 2006 11:19:47 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2122> 
======================================================================
Reported By:                dsandras
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   2122
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             05-13-2006 17:35 CEST
Last Modified:              05-16-2006 11:19 CEST
======================================================================
Summary:                    DMIX crashes Ekiga
Description: 
This problem is probably related to problem #2095 that was closed. 
Unfortunately, I can not reopen it, so I'm posting a new bug report.

When using DMIX, Ekiga crashes. This problem was not present with earlier
versions of libasound2. I applied all patches from CVS.
======================================================================

----------------------------------------------------------------------
 dsandras - 05-15-06 23:41 
----------------------------------------------------------------------
"I cannot test here as I do not have a hardware mixing sound card, and the
problem varies by device."

Me neither. Simply use DMIX.

"If you set the period and buffer sizes in your .asoundrc to the values
from the non-working config do you get the same results?"

Yes.

"What if you try changing Ekiga to set the period and buffer to 256/2048,
as you have done in your .asoundrc?"

I do not know how to do that. Advice from an ALSA developer would be
welcome. Ekiga is really a widespread VoIP softphone, and getting help
from an ALSA developer to improve DMIX support would be more than welcome.

----------------------------------------------------------------------
 tiwai - 05-16-06 11:19 
----------------------------------------------------------------------
First, don't apply a single patch but use the whole HG tree.  The code sync
between tester and developer is one of most important things.

What is the sample rate the app uses?  One of differences between your
setting and the default is the sample rate.  The default is 48k while
yours is 44.1k.

Another difference is period and buffer size.  The recent dmix code does
async data transfer and may have varied periods.  Try to set the following
in ~/.asoundrc:

   defaults.pcm.dmix_max_periods   -1

This will force apps the fixed number of periods defined by slave PCM.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-06 17:35 dsandras       New Issue                                    
05-13-06 17:39 dsandras       Note Added: 0009795                          
05-13-06 17:41 dsandras       Note Added: 0009796                          
05-13-06 18:29 rlrevell       Note Added: 0009799                          
05-13-06 18:36 dsandras       Note Added: 0009800                          
05-13-06 18:37 dsandras       File Added: busytone.wav                     
05-15-06 10:35 tiwai          Status                   assigned => resolved
05-15-06 10:35 tiwai          Resolution               open => fixed       
05-15-06 10:35 tiwai          Note Added: 0009814                          
05-15-06 11:01 dsandras       Status                   resolved => feedback
05-15-06 11:01 dsandras       Resolution               fixed => reopened   
05-15-06 11:01 dsandras       Note Added: 0009816                          
05-15-06 11:07 tiwai          Note Added: 0009818                          
05-15-06 22:33 dsandras       Note Added: 0009828                          
05-15-06 22:42 rlrevell       Note Added: 0009829                          
05-15-06 22:46 dsandras       Note Added: 0009830                          
05-15-06 22:58 rlrevell       Note Added: 0009831                          
05-15-06 22:59 dsandras       Note Added: 0009832                          
05-15-06 23:28 rlrevell       Note Added: 0009833                          
05-15-06 23:41 dsandras       Note Added: 0009834                          
05-16-06 11:19 tiwai          Note Added: 0009836                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
