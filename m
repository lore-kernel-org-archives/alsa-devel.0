From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001802]: error: structure has no member named `cur_altsetting'
Date: Tue, 31 Jan 2006 16:44:58 +0100
Message-ID: <acee6f009d6432d86183b567ab610a49@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A9CDE1DD
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2006 16:44:58 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1802> 
======================================================================
Reported By:                ldrolez
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1802
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.4
======================================================================
Date Submitted:             01-31-2006 16:44 CET
Last Modified:              01-31-2006 16:44 CET
======================================================================
Summary:                    error: structure has no member named
`cur_altsetting'
Description: 
Here is the make error:

...
...
  CC [M]  /tmp/alsa-driver-1.0.11rc3/acore/seq/oss/seq_oss_synth.o
  CC [M]  /tmp/alsa-driver-1.0.11rc3/acore/seq/oss/seq_oss_midi.o
  CC [M]  /tmp/alsa-driver-1.0.11rc3/acore/seq/oss/seq_oss_readq.o
  CC [M]  /tmp/alsa-driver-1.0.11rc3/acore/seq/oss/seq_oss_writeq.o
  LD [M]  /tmp/alsa-driver-1.0.11rc3/acore/seq/oss/snd-seq-oss.o
  CC [M]  /tmp/alsa-driver-1.0.11rc3/usb/usbaudio.o
  CC [M]  /tmp/alsa-driver-1.0.11rc3/usb/usbmixer.o
/tmp/alsa-driver-1.0.11rc3/usb/usbmixer.c: In function
`snd_usb_mixer_disconnect':
/tmp/alsa-driver-1.0.11rc3/usb/usbmixer.c:2011: warning: implicit
declaration of function `usb_kill_urb'
  CC [M]  /tmp/alsa-driver-1.0.11rc3/usb/usbmidi.o
/tmp/alsa-driver-1.0.11rc3/usb/usbmidi.c: In function
`snd_usbmidi_detect_endpoints':
/tmp/alsa-driver-1.0.11rc3/usb/usbmidi.c:1312: error: structure has no
member named `cur_altsetting'
make[3]: *** [/tmp/alsa-driver-1.0.11rc3/usb/usbmidi.o] Error 1
make[2]: *** [/tmp/alsa-driver-1.0.11rc3/usb] Error 2
make[1]: *** [/tmp/alsa-driver-1.0.11rc3] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.4'

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-06 16:44 ldrolez        New Issue                                    
01-31-06 16:44 ldrolez        Distribution              => Debian          
01-31-06 16:44 ldrolez        Kernel Version            => 2.6.4           
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
