From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000642]: Crash on trying to set "any" hw_params
Date: Thu, 31 Mar 2005 20:47:41 +0200
Message-ID: <d7f7f243c663bf066fcecd233223e892@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 83E6C24B
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 20:47:41 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
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
Status:                     acknowledged
======================================================================
Date Submitted:             11-11-2004 11:48 CET
Last Modified:              03-31-2005 20:47 CEST
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
03-31-05 20:47 jdthood        Status                   new => acknowledged 
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
