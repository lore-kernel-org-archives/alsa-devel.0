From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000642]: Crash on trying to set "any" hw_params
Date: Sun, 20 Mar 2005 13:16:01 +0100
Message-ID: <6a0381a6f6ae04b7d9ee5827272addec@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 258E9140
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 13:16:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=642> 
======================================================================
Reported By:                rbultje
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   642
Category:                   ordinary pcm
Reproducibility:            sometimes
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-11-2004 11:48 CET
Last Modified:              03-20-2005 13:16 CET
======================================================================
Summary:                    Crash on trying to set "any" hw_params
Description: 
Hi,

we received several similar bug reports in our bugzilla about ALSA-related
crashers. It seems that the simple sequence of snd_pcm_hw_params_any()
followed by snd_pcm_hw_params() will cause a floating point exception in
libalsa. I can't reproduce it myself, but for backtraces and email
addresses of people that can, see e.g.
http://bugzilla.gnome.org/show_bug.cgi?id=151288 or
http://bugzilla.gnome.org/show_bug.cgi?id=153227 (plus all the bug reports
dupped to those).

If you need any information, either from me or from the reporters, feel
free to contact me, I'll try to get all information required to resolve
this. I've added a workaround in GStreamer CVS, but still think that this
is a bug.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-18-04 18:29 
----------------------------------------------------------------------
Please provide the alsa-lib version number they use.
I guess this bug occurs when the rate plugin is used.
Do you have any simple test case?

----------------------------------------------------------------------
 jdthood - 03-20-05 13:16 
----------------------------------------------------------------------
Many bugs were filed in the GNOME BTS about this.  Lots of backtraces
have been provided there.

It looks as if GNOME has worked around the problem, though.  Ronald
Bultje writes:
> I have applied a workaround to CVS, I think version 0.8.6
> of gst-plugins will fix this. Can you please test that once
> it comes out?
> Also, I'm still of the opinion that this is an ALSA bug, since
> apparently the simple sequence of snd_pcm_hw_params_any()
> followed by snd_pcm_hw_params() will cause crashes.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-11-04 11:48 rbultje        New Issue                                    
11-18-04 18:29 tiwai          Note Added: 0002457                          
03-20-05 13:16 jdthood        Note Added: 0004078                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
