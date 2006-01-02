From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000429]: Feature: Ability to cap the volume
Date: Mon, 2 Jan 2006 20:40:00 +0100
Message-ID: <565a0618d6b2613262b48265e20a7c62@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C811F13E
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 20:40:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=429> 
======================================================================
Reported By:                morgoth
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   429
Category:                   alsamixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-07-2004 23:39 CEST
Last Modified:              01-02-2006 20:39 CET
======================================================================
Summary:                    Feature: Ability to cap the volume
Description: 
For my soundcard (SB Live! 1024) I can't have the PCM higher then 74%
before I get some werd noises. If there was a way to cap or lock the
volume so that _no_ programs (like xmms or mplayer) could turn it higher.
That would be great :)
I don't know why all programs try to adjust the PCM instead of Master or
any of the others. But a cap would be a start ;)
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-02-06 20:12 
----------------------------------------------------------------------
Ah ok.  Well jcdutton's work to make alsa mixer use DB values might help. 
Then it would be up to the app to not do silly things like play back .wav
files with the gain to +12 DB.

pzad, what do you think the status of this bug should be?

----------------------------------------------------------------------
 pzad - 01-02-06 20:39 
----------------------------------------------------------------------
I don't know. "PCM" on sb live is not good name, because it controls volume
of front speakers (not only PCM playback but all other sources too). Maybe
solution is to remove "PCM" control from ac97 (and set it to 0 db) and
rename "Wave" to "PCM". This means only inputs will be controlable and not
outputs.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-07-04 23:39 morgoth        New Issue                                    
08-08-04 19:41 afran          Issue Monitored: afran                       
08-08-04 19:52 afran          Note Added: 0001545                          
12-31-05 07:26 rlrevell       Note Added: 0007350                          
01-02-06 19:36 afran          Note Added: 0007377                          
01-02-06 20:01 pzad           Note Added: 0007378                          
01-02-06 20:12 rlrevell       Note Added: 0007379                          
01-02-06 20:39 pzad           Note Added: 0007387                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
