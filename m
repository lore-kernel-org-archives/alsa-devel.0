From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001132]: Realtek ALC260, snd-hda-intel, 2.4.21-32, catastrophic CrAsH
Date: Tue, 31 May 2005 19:10:41 +0200
Message-ID: <9e13cb69599f0790b1dbb0ee6f12384d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B880A16E
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 19:10:41 +0200 (MEST)
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


The following issue has been REOPENED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1132> 
======================================================================
Reported By:                speedking
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1132
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     feedback
Distribution:               RHEL 3 U5 gold
Kernel Version:             2.4.21-32
======================================================================
Date Submitted:             05-28-2005 02:02 CEST
Last Modified:              05-31-2005 19:10 CEST
======================================================================
Summary:                    Realtek ALC260, snd-hda-intel, 2.4.21-32,
catastrophic CrAsH
Description: 
system hangs when either 'alsaconf' runs or you attempt a 'modprobe
snd-hda-intel'

System is a HP xw4300 workstation, Intel based, running an Azalia
compliant" "Intel High definition Audio" Realtek ALC 260 chip onboard.




======================================================================

----------------------------------------------------------------------
 tiwai - 05-31-05 12:58 
----------------------------------------------------------------------
Fixed with 1.0.9-final.

----------------------------------------------------------------------
 speedking - 05-31-05 19:10 
----------------------------------------------------------------------
I have tried 1.0.9 final this morning and now 'alsaconf' gives me the
following error:

"No Supported PnP or PCI card found.  Would you like to probe Legacy ISA
sound cards/chips"

Saying 'yes' finds no supported chips while saying 'no' bails out.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 02:02 speedking      New Issue                                    
05-28-05 02:02 speedking      Distribution              => RHEL 3 U5 gold  
05-28-05 02:02 speedking      Kernel Version            => 2.4.21-32       
05-31-05 12:58 tiwai          Status                   assigned => resolved
05-31-05 12:58 tiwai          Resolution               open => fixed       
05-31-05 12:58 tiwai          Note Added: 0004825                          
05-31-05 19:10 speedking      Status                   resolved => feedback
05-31-05 19:10 speedking      Resolution               fixed => reopened   
05-31-05 19:10 speedking      Note Added: 0004848                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
