From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002122]: DMIX crashes Ekiga
Date: Tue, 16 May 2006 13:02:28 +0200
Message-ID: <393817279b44dd7448c3ae2d327bcd5b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C8A6C22D
	for <alsa-devel@alsa-project.org>; Tue, 16 May 2006 13:02:28 +0200 (MEST)
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
Last Modified:              05-16-2006 13:02 CEST
======================================================================
Summary:                    DMIX crashes Ekiga
Description: 
This problem is probably related to problem #2095 that was closed. 
Unfortunately, I can not reopen it, so I'm posting a new bug report.

When using DMIX, Ekiga crashes. This problem was not present with earlier
versions of libasound2. I applied all patches from CVS.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-16-06 12:04 
----------------------------------------------------------------------
OK, let me rephrase my questions again:

- Wheter you're using the whole latest HG tree
- What is the sample rate your app uses
- What happens if you set "defaults.pcm.dmix_max_periods -1"

Could you answer them?  Otherwise I can't help.

Other userful information are:

- The hardware and driver that the problem appears
- Change period_size to 1024 and periods to 16 in your dmix config.
  No buffer_size.  It's the as same config as in default.

And what is your "plugin"?  Did you write a new plugin for alsa-lib and
use it?

----------------------------------------------------------------------
 dsandras - 05-16-06 13:02 
----------------------------------------------------------------------
"Wheter you're using the whole latest HG tree"

Not completely. I couldn't find a way to generate a patch with hg and then
I cancelled and took only the patch that was interesting to fix the
original problem.

"What is the sample rate your app uses"

8kHz or 16kHz depending if the codec is wideband or not.

"What happens if you set "defaults.pcm.dmix_max_periods -1"

The result is good. 

"The hardware and driver that the problem appears"

All hardware, all drivers. All of the developers have different hardware
and they can all reproduce the problem without the .asoundrc that I gave
you or without the .asoundrc that you gave me. Of course, only with DMIX.

"Change period_size to 1024 and periods to 16 in your dmix config.
No buffer_size. It's the as same config as in default"

It gives bad results.

"And what is your "plugin"? Did you write a new plugin for alsa-lib and
use it?"

It is the portion of code that Ekiga is using to manager audio devices,
the ALSA version.

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
05-16-06 11:52 dsandras       Note Added: 0009837                          
05-16-06 12:04 tiwai          Note Added: 0009838                          
05-16-06 13:02 dsandras       Note Added: 0009839                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
