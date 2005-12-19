From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001660]: snd_es18xx doesn't output sound for 16-bit sources
Date: Mon, 19 Dec 2005 17:37:13 +0100
Message-ID: <0608dd27709f8f6ebddbe8ac60b5ebc9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D8A5818F
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2005 17:37:13 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1660> 
======================================================================
Reported By:                marcelpaulo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1660
Category:                   ISA - es18xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             2.6.14-2-686
======================================================================
Date Submitted:             12-19-2005 17:37 CET
Last Modified:              12-19-2005 17:37 CET
======================================================================
Summary:                    snd_es18xx doesn't output sound for 16-bit sources
Description: 
I recently tried to switch from OSS to ALSA. alsaconf didn't configure the
soundcard correctly, so I manually edited /etc/modprobe.d/sound with the
parameters I got from the BIOS.
gxine and xmms output no sound from streaming audio sources (16-bit), and
aplay produced sound only for 8-bit wav files. The discussion in
alsa-devel thread:
http://thread.gmane.org/gmane.linux.alsa.devel/29442
reached the conclusion of a bug in snd_es18xx.
If any further information and tests are needed, please let me know.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-19-05 17:37 marcelpaulo    New Issue                                    
12-19-05 17:37 marcelpaulo    Distribution              => Debian sid      
12-19-05 17:37 marcelpaulo    Kernel Version            => 2.6.14-2-686    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
