From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001724]: simple PCM helper function
Date: Tue, 31 Jan 2006 10:26:23 +0100
Message-ID: <bf566c7e354e89b1960ecfcea21c6adb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B0461114
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2006 10:26:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1724> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1724
Category:                   0_general
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-07-2006 05:10 CET
Last Modified:              01-31-2006 10:26 CET
======================================================================
Summary:                    simple PCM helper function
Description: 
/cvs/alsa-lib/test/pcm_min

ALSA lib pcm.c:7127:(snd_pcm_set_params) Unable to set buffer time
(latency) 500000 for PLAYBACK: Invalid argument
Playback open error: Invalid argument

sound card is au8830, the au88x0 driver only accept period size in power
of 2.
======================================================================

----------------------------------------------------------------------
 perex - 01-31-06 10:19 
----------------------------------------------------------------------
Yes and no. It's combination pow2 and periods == integer issue. If the
buffer size is 24000 and period size is 2048, then 24000 / 2048 = 11.7188
which is not integer value and then configuration fails.

In this case depends on the parameter order. Or a better fix maybe to
describe that buffer_size must be N * period_size with pow2 restriction
(create a list with all combinations).

I've tried to add a workaround to snd_pcm_set_params() to CVS, but it does
not prevent other apps using the hw_params ALSA API directly to fail.

----------------------------------------------------------------------
 perex - 01-31-06 10:26 
----------------------------------------------------------------------
To be sure: I'm talking about SNDRV_PCM_HW_PARAM_PERIOD_BYTES restriction.
See pci/emu10k1/emupcm.c code how you can use the
snd_pcm_hw_constraint_list() for this parameter.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-06 05:10 Raymond        New Issue                                    
01-09-06 15:19 Raymond        Note Added: 0007537                          
01-19-06 15:04 Raymond        Note Deleted: 0007537                        
01-19-06 15:36 Raymond        Note Added: 0007721                          
01-28-06 07:58 Raymond        Note Added: 0007828                          
01-28-06 07:58 Raymond        Note Deleted: 0007721                        
01-30-06 18:46 Raymond        Note Added: 0007840                          
01-31-06 03:15 Raymond        Note Added: 0007844                          
01-31-06 06:41 Raymond        Note Edited: 0007840                         
01-31-06 07:03 Raymond        Note Edited: 0007840                         
01-31-06 07:08 Raymond        Note Edited: 0007840                         
01-31-06 07:11 Raymond        Note Edited: 0007840                         
01-31-06 08:31 Raymond        Note Edited: 0007840                         
01-31-06 09:48 Raymond        Note Edited: 0007844                         
01-31-06 10:19 perex          Note Added: 0007845                          
01-31-06 10:26 perex          Note Added: 0007847                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
