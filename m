From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000584]: LADSPA plugins which require multiple channels are not connected to properly -> SEGV
Date: Fri, 15 Oct 2004 22:58:33 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041015205833.09A184D010@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4FCE9311
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2004 22:58:33 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 1916230571
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2004 22:58:33 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000584
======================================================================
Reported By:                divVerent
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     584
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-15-2004 22:58 CEST
Last Modified:              10-15-2004 22:58 CEST
======================================================================
Summary:                    LADSPA plugins which require multiple channels are not connected to properly -> SEGV
Description: 
Instead of connecting all channels to the LADSPA plugin and invoking it
once, libasound connects them one-by-one and invokes the LADSPA plugin
multiple times. In other words, libasound only handles mono plugins and
"stretches" them into stereo plugins by processing the audio data channel
by channel.

This will however make real stereo/multichannel plugins crash because they
do what "ladspa.h" says:

/* quoting ladspa.h
The plugin may assume that all its input and output ports have been
connected to the relevant data location (see the `connect_port()' function
below) before it is asked to run.
*/
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-15-04 22:58 divVerent      New Bug                                      
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
