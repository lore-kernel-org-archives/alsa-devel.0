From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001854]: alsa-lib obfuscates terminal or something segfaults
Date: Sat, 18 Feb 2006 19:59:26 +0100
Message-ID: <dd0ed1a4d45c5e79ca714642bfcda08a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 040A11BB
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2006 19:59:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1854> 
======================================================================
Reported By:                hesabo
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1854
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-18-2006 19:59 CET
Last Modified:              02-18-2006 19:59 CET
======================================================================
Summary:                    alsa-lib obfuscates terminal or something segfaults
Description: 
alsa-lib produces bad error messages like
"""
ALSA lib pcm_direct.c:222:(make_local_socket) connect failed:
I&#65535;&#65535;&#65535;&#65535;: No such file or directory
ALSA lib pcm_dmix.c:851:(snd_pcm_dmix_open) unable to connect client
aplay: main:544: audio open error: No such file or directory
"""
or
"""
ALSA lib pcm_direct.c:222:(make_local_socket) connect failed: : N&#9146;
&#9149;&#9508;&#9228;&#9252; °&#9227;&#9484;&#9226; &#9146;&#9148;
&#9229;&#9227;&#9148;&#9226;&#9228;&#9500;&#9146;&#9148;&#8804;
ALSA &#9484;&#9227;&#9225;
&#9147;&#9228;&#9492;_&#9229;&#9492;&#9227;&#9474;.&#9228;:851:(&#9149;&#9532;&#9229;_&#9147;&#9228;&#9492;_&#9229;&#9492;&#9227;&#9474;_&#9146;&#9147;&#9226;&#9532;)
&#9508;&#9532;&#9618;&#9225;&#9484;&#9226; &#9500;&#9146;
&#9228;&#9146;&#9532;&#9532;&#9226;&#9228;&#9500;
&#9228;&#9484;&#9227;&#9226;&#9532;&#9500;
&#9618;&#9147;&#9484;&#9618;&#8804;: &#9492;&#9618;&#9227;&#9532;:544:
&#9618;&#9508;&#9229;&#9227;&#9146; &#9146;&#9147;&#9226;&#9532;
&#9226;&#9148;&#9148;&#9146;&#9148;: N&#9146; &#9149;&#9508;&#9228;&#9252;
°&#9227;&#9484;&#9226; &#9146;&#9148;
&#9229;&#9227;&#9148;&#9226;&#9228;&#9500;&#9146;&#9148;&#8804;
"""
or
"""
Segmentation fault
"""

The segmentation fault is not reproducible nor is the string in the error
message.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-06 19:59 hesabo         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
