From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000199]: Bug in sis7012 driver - or probably I'm doing something wrong ?
Date: Tue, 13 Dec 2005 12:46:05 +0100
Message-ID: <c5d899630a736a920a6df6238bcda058@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3877E1C1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 12:46:05 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=199> 
======================================================================
Reported By:                rrrozman
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   199
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-10-2004 09:15 CEST
Last Modified:              12-13-2005 12:46 CET
======================================================================
Summary:                    Bug in sis7012 driver - or probably I'm doing
something wrong ?
Description: 
Hi,

I have Asus pundit with sis7012 sound device and alsa 1.0.4 under Suse
9.0.
I've got advice how to use this 6 channel device as 3 stereo channels but
there seems something not to be right (it could be my mistake).

I have /etc/asound.conf :
pcm_slave.sis {
pcm "hw:0"
channels 6
rate 48000
buffer_size 4096  # make these sizes smaller for lower latency
period_size 2048
periods 0
period_time 0
}

pcm.ch12 {
type dmix
ipc_key 47110815
slave sis
bindings.0 0
bindings.1 1
}

pcm.ch34 {
type dmix
ipc_key 47110815
slave sis
bindings.0 2
bindings.1 3
}

pcm.ch56 {
type dmix
ipc_key 47110815
slave sis
bindings.0 4
bindings.1 5
}


pcm.a {
type plug
slave.pcm ch12
}

pcm.b {
type plug
slave.pcm ch34
}

pcm.c {
type plug
slave.pcm ch56
}

pcm.dmixerALL {
type dmix
ipc_key 47110815
slave sis
    bindings.0 0
    bindings.1 1
    bindings.2 2
    bindings.3 3
    bindings.4 4
    bindings.5 5
}

pcm.channelALL {
    type plug
    slave.pcm "dmixerALL"
    ttable.0.0 1
    ttable.1.1 1
    ttable.0.2 1
    ttable.1.3 1
    ttable.0.4 1
    ttable.1.5 1
}
-----------------------------------------

Now I do:

- alsaplayer with mp3 file on device plug:a
- aplay -D plug:ch12 (funny is that plug:a doesn't work)
- everything is ok and mixed properly

- but if I start another alsaplayer on plug:b (probably also plug:c would
be
the same), then aplay produces sound that is "interleaved" in short
chunks
and also sound from alsaplayer on plug:b is also heard in addition to
original mp3 and aplay sound.

Am I doing something worng or is this somkind of bug or limitation of
alsa
driver ?

Thanks in advance,

Robert.



======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 12:46 
----------------------------------------------------------------------
No one ever responded to this.

Submitter: Did you ever solve the problem on your own?

----------------------------------------------------------------------
 jdthood - 12-13-05 12:46 
----------------------------------------------------------------------
No feedback was forthcoming.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-10-04 09:15 rrrozman       New Issue                                    
03-19-05 12:46 jdthood        Note Added: 0004039                          
12-13-05 12:46 jdthood        Status                   new => closed       
12-13-05 12:46 jdthood        Note Added: 0007001                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
