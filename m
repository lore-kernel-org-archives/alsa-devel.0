From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000584]: LADSPA plugins which require multiple channels are not connected to properly -> SEGV
Date: Tue, 13 Dec 2005 15:26:24 +0100
Message-ID: <7ee2ce95663c0813f3382651ca755c97@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9821F1C0
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 15:26:24 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=584> 
======================================================================
Reported By:                divVerent
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   584
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-15-2004 22:58 CEST
Last Modified:              12-13-2005 15:26 CET
======================================================================
Summary:                    LADSPA plugins which require multiple channels are
not connected to properly -> SEGV
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

----------------------------------------------------------------------
 divVerent - 03-20-05 15:15 
----------------------------------------------------------------------
By handling multichannel LADSPA plugins so that all channels are connected
to their slots.

I see that this would break old functionality which can "expand" a
single-channel LADSPA plugin to all channels. Perhaps it would be good to
make this "expansion" an option of the LADSPA plugin.

Unfortunately, from what I've read in the ALSA source code about this, it
would require a complete rewrite of the LADSPA interface. But I still hope
I am wrong.

----------------------------------------------------------------------
 perex - 12-13-05 15:26 
----------------------------------------------------------------------
It's fixed in ALSA CVS. The configuration example works now and the LADSPA
code in alsa-lib was recoded to be more universal.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-15-04 22:58 divVerent      New Issue                                    
10-15-04 23:21 divVerent      Issue Monitored: divVerent                    
03-20-05 13:02 jdthood        Note Added: 0004076                          
03-20-05 15:15 divVerent      Note Added: 0004090                          
12-13-05 15:26 perex          Status                   new => resolved     
12-13-05 15:26 perex          Resolution               open => fixed       
12-13-05 15:26 perex          Assigned To               => perex           
12-13-05 15:26 perex          Note Added: 0007018                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
