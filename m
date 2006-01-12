From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001101]: [VIA 8237 with ALC850] gstreamer alsasink with default device does not work but with "device=hw:0" it does
Date: Fri, 13 Jan 2006 00:18:16 +0100
Message-ID: <cf7b165dcef262bc60c26d4eee4378a3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C0C2A144
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 00:18:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1101> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1101
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-11-2005 22:15 CEST
Last Modified:              01-13-2006 00:18 CET
======================================================================
Summary:                    [VIA 8237 with ALC850] gstreamer alsasink with
default device does not work but with "device=hw:0" it does
Description: 
The submitter of #305189 and an interlocutor have discovered that
gstreaming to "alsasink" does not work but the same to "alsasink
device=hw:0" does work.

Please see http://bugs.debian.org/305189 for the discussion which includes
lots more detail.
======================================================================

----------------------------------------------------------------------
 GhePeU - 06-09-05 14:10 
----------------------------------------------------------------------
I'm experiencing the same problem with gstreamer, alsa-driver 1.0.9,
alsa-lib 1.0.9 and Sound Blaster Live! 5.1 (emu10k1). With alsa-lib 1.0.9
rc3 everything works flawlessy, and I can confirm that specifying
device=hw:0 fixes this on 1.0.9.

bug in gstremer bugzilla:
http://bugzilla.gnome.org/show_bug.cgi?id=306934

output:
ghepeu@KazeNoTani ~ $ LC_ALL="C" gst-launch-0.8 filesrc
location="lugradio-s2e12-280305.ogg" ! spider ! alsasink
RUNNING pipeline ...
ERROR: from element /pipeline0/alsasink0: Could not get/set settings
from/on resource.
ERROR: from element /pipeline0/spider0/vorbisdec0: Internal GStreamer
error: pad problem.  File a bug.
Additional debug info:
gstpad.c(2562): gst_pad_set_explicit_caps: /pipeline0/spider0/vorbisdec0:
failed to negotiate (try_set_caps with "audio/x-raw-float,
rate=(int)22000, channels=(int)1, endianness=(int)1234, width=(int)32,
buffer-frames=(int)0" returned REFUSED)
Execution ended after 15 iterations (sum 272120000 ns, average 18141333
ns, min 33000 ns, max 137303000 ns).

ghepeu@KazeNoTani ~ $ LC_ALL="C" gst-launch-0.8 filesrc
location="lugradio-s2e12-280305.ogg" ! spider ! alsasink device=hw:0
RUNNING pipeline ...
Execution ended after 126 iterations (sum 1858311000 ns, average 14748500
ns, min 27000 ns, max 372437000 ns).



----------------------------------------------------------------------
 rlrevell - 01-13-06 00:18 
----------------------------------------------------------------------
Is this fixed in later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-11-05 22:15 jdthood        New Issue                                    
05-13-05 14:17 tiwai          Note Added: 0004645                          
05-13-05 15:38 jdthood        Note Added: 0004650                          
05-15-05 22:58 lool           Issue Monitored: lool                        
05-15-05 22:59 lool           Note Added: 0004674                          
06-09-05 14:04 GhePeU         Note Added: 0004980                          
06-09-05 14:04 GhePeU         Issue Monitored: GhePeU                      
06-09-05 14:10 GhePeU         Note Edited: 0004980                         
01-13-06 00:18 rlrevell       Note Added: 0007600                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
