From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000642]: Crash on trying to set "any" hw_params
Date: Thu, 18 Nov 2004 18:29:13 +0100
Message-ID: <f1ed529f60ae22b9c68afc8f0a5aad65@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A6BEC1EE
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 18:29:13 +0100 (MET)
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
Last Modified:              11-18-2004 18:29 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-11-04 11:48 rbultje        New Issue                                    
11-18-04 18:29 tiwai          Note Added: 0002457                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
