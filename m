From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001228]: Skype Does not work with aoss
Date: Sat, 28 Jan 2006 06:13:09 +0100
Message-ID: <e2efbdf37229d38f3ddd86f691146fdd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1A9DB1B1
	for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2006 06:13:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1228> 
======================================================================
Reported By:                hil
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1228
Category:                   
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-03-2005 09:09 CEST
Last Modified:              01-28-2006 06:13 CET
======================================================================
Summary:                    Skype Does not work with aoss
Description: 
I downloaded alsa-oss-1.0.9rc2 and install by
# ./configure --with-aoss=yes && make && make install
as root. Virtually every program works except skype
(http://www.skype.com/) version 1.1.0.13_API. I downloaded the Fedora
version of skype from the skype official website. Skype only uses
/dev/dsp. I guess skype uses /dev/dsp as microphone input as well. I could
not hear anything and the microphone did not work as well if I run  skype
like aoss /usr/bin/skype. If I run skype without aoss, then skype works
just fine.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001224 artsd-like style
======================================================================

----------------------------------------------------------------------
 nono31 - 01-28-06 06:11 
----------------------------------------------------------------------
kiax:

Pa_SetLatency: could not SNDCTL_DSP_SETFRAGMENT
Pa_SetLatency: numBuffers = 5, framesPerBuffer = 160, powerOfTwo = 9
Pa_SetupDeviceFormat: could not SNDCTL_DSP_SETFMT
Pa_SetLatency: could not SNDCTL_DSP_SETFRAGMENT
Pa_SetLatency: numBuffers = 5, framesPerBuffer = 160, powerOfTwo = 10
Pa_SetupDeviceFormat: could not SNDCTL_DSP_SETFMT
PortAudio error at opening separate input stream: Host error.
IaxWrapper::interrupt_call() hanging up and exiting..
Sáb Jan 28 05:10:06 2006 IaxWrapper::event_text() Message: Type=1
Message=Hanging up call 0
Sáb Jan 28 05:10:06 2006 IaxWrapper::event_state() processing IAX event..
Sáb Jan 28 05:10:06 2006 IaxWrapper::event_state() call state 0 :
active=0, outgoing=0, ringing=0, complete=0, selected=0
Sáb Jan 28 05:10:06 2006 IaxWrapper::event_state() call info 0 : remote=,
remote_name=, local=Mathieu, local_context=default
Sáb Jan 28 05:10:06 2006 IaxWrapper::event_state() INACTIVE 0
Sáb Jan 28 05:10:06 2006 IaxWrapper::event_text() Message: Type=4
Message=iaxclient audio: Can't open Audio Device, we tried 5 times. 
Perhaps you do not have an input or output device?
Sáb Jan 28 05:10:06 2006 IaxWrapper::event_text() Message: Type=3
Message=Can't start audio

----------------------------------------------------------------------
 nono31 - 01-28-06 06:13 
----------------------------------------------------------------------
Uploaded strace just in case...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-03-05 09:09 hil            New Issue                                    
08-09-05 15:33 rapand         Note Added: 0005732                          
08-10-05 00:49 rlrevell       Relationship added       duplicate of 0001224
08-10-05 00:50 rlrevell       Note Added: 0005740                          
12-31-05 00:19 rlrevell       Note Added: 0007315                          
01-02-06 18:54 rlrevell       Relationship deleted     duplicate of 0001224
01-02-06 18:55 rlrevell       Relationship added       related to 0001224  
01-02-06 18:56 rlrevell       Note Added: 0007375                          
01-05-06 21:36 Hetfield       Note Added: 0007479                          
01-05-06 21:40 rlrevell       Note Added: 0007480                          
01-05-06 21:42 rlrevell       Note Added: 0007481                          
01-05-06 22:01 Hetfield       Note Added: 0007482                          
01-28-06 05:34 nono31         Note Added: 0007824                          
01-28-06 05:35 nono31         Issue Monitored: nono31                      
01-28-06 05:38 rlrevell       Note Added: 0007825                          
01-28-06 06:11 nono31         Note Added: 0007826                          
01-28-06 06:12 nono31         File Added: strace_aoss_kiax.bz2                  
 
01-28-06 06:13 nono31         Note Added: 0007827                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
