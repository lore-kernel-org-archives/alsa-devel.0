From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001075]: IEC958 Capture Switch cannot be set with alsamixer
Date: Fri, 13 Jan 2006 00:16:12 +0100
Message-ID: <a6415573f2c47be4192a188536a12ae0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ECE9D144
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 00:16:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1075> 
======================================================================
Reported By:                vsu
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1075
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-24-2005 16:44 CEST
Last Modified:              01-13-2006 00:16 CET
======================================================================
Summary:                    IEC958 Capture Switch cannot be set with alsamixer
Description: 
alsamixer (both 1.0.8 and CVS snapshot from 2005-04-23) is not able to
control IEC958 Capture Switch of the ALC850 codec:

- When alsamixer is started, IEC958 Capture Switch is always displayed as
turned on, regardless of the actual state.

- When pressing Space, the switch seems to be toggled on screen, however,
the actual mixer state does not change.

The switch can be controlled with amixer:

$ amixer cset numid=40,iface=MIXER,name='IEC958 Capture Switch' on
numid=40,iface=MIXER,name='IEC958 Capture Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
$ amixer cset numid=40,iface=MIXER,name='IEC958 Capture Switch' off
numid=40,iface=MIXER,name='IEC958 Capture Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off

When the switch state is changed this way while alsamixer is running, the
alsamixer screen is updated, and the switch is drawn as if turned on.
======================================================================

----------------------------------------------------------------------
 vsu - 08-20-05 19:06 
----------------------------------------------------------------------
Even more - I have found that I also cannot control IEC958 Playback Switch
through alsamixer.  This control does not even appear on the screen - the
"IEC958" element is shown as an enum control (with values "PCM", "Analog
In", "IEC958 In"), and there is no mute box below it.

Also, when I switch to the view with all controls (with F5), I don't see
the capture switch for IEC958 too - only the enum control is displayed.

I have attached my asound.state file and the output of "amixer contents"
and "amixer scontents".

----------------------------------------------------------------------
 rlrevell - 01-13-06 00:16 
----------------------------------------------------------------------
Any improvement in 1.0.11-rc* or ALSA CVS?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-24-05 16:44 vsu            New Issue                                    
08-20-05 16:02 jdthood        Note Added: 0005877                          
08-20-05 18:16 vsu            Note Added: 0005881                          
08-20-05 18:59 vsu            File Added: asound.state                     
08-20-05 19:00 vsu            File Added: amixer_contents                    
08-20-05 19:00 vsu            File Added: amixer_scontents                    
08-20-05 19:06 vsu            Note Added: 0005882                          
01-13-06 00:16 rlrevell       Note Added: 0007597                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
