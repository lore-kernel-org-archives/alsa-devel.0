From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001920]: output from only 2 speakers(out of 5 speakers)
Date: Fri, 17 Mar 2006 19:54:16 +0100
Message-ID: <74ba828e3a10c77d4846af77510dc758@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 256A217C
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 19:54:17 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1920> 
======================================================================
Reported By:                binilbenjamin
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1920
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 4
Kernel Version:             2.6
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-13-2006 19:02 CET
Last Modified:              03-17-2006 19:54 CET
======================================================================
Summary:                    output from only 2 speakers(out of 5 speakers)
Description: 
i'm having a 5.1 speakers..when i play music ,only 2 of them are working!!!
i had changed the channel mode in alsamixer to 6 channel..yet no
changes!!! 
Motherboard : Asus A8N-E
OS: fedora core 4

======================================================================

----------------------------------------------------------------------
 rlrevell - 03-17-06 19:44 
----------------------------------------------------------------------
You could also set XMMS to artds/esd output (whichever sound server you're
using)

----------------------------------------------------------------------
 tiwai - 03-17-06 19:54 
----------------------------------------------------------------------
Alternatively, you can use the following dmix defintion for 5.1 output.  It
requires the very latest CVS version of alsa-lib (committed 30 minutes
ago).

Anyway, it's a non-bug, so I close this bug.
For further questions, go to alsa-users ML, please.


pcm.!default "dmix51"

pcm.dmix51 {
	type plug
	slave {
		pcm {
			type dmix
			ipc_key {
				@func refer
				name defaults.pcm.ipc_key
			}
			ipc_gid {
				@func refer
				name defaults.pcm.ipc_gid
			}
			slave {
				pcm "hw"
				period_size 1024
				periods 16
				channels 6
			}
		}
	}
	ttable {
		0.0 1
		1.1 1
		0.2 1
		1.3 1
		0.4 0.5
		1.4 0.5
		0.5 0.5
		1.5 0.5
	}
}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-13-06 19:02 binilbenjamin  New Issue                                    
03-13-06 19:02 binilbenjamin  Distribution              => Fedora Core 4   
03-13-06 19:02 binilbenjamin  Kernel Version            => 2.6             
03-13-06 19:33 rlrevell       Note Added: 0008455                          
03-13-06 19:49 binilbenjamin  Note Added: 0008457                          
03-13-06 19:54 rlrevell       Note Added: 0008458                          
03-13-06 20:16 binilbenjamin  Note Added: 0008459                          
03-13-06 20:25 rlrevell       Note Added: 0008460                          
03-14-06 17:44 binilbenjamin  Note Added: 0008501                          
03-14-06 17:56 rlrevell       Note Added: 0008504                          
03-14-06 18:34 binilbenjamin  Note Added: 0008505                          
03-14-06 18:52 rlrevell       Note Added: 0008506                          
03-14-06 19:00 rlrevell       Note Added: 0008507                          
03-14-06 19:02 binilbenjamin  Note Added: 0008508                          
03-14-06 19:12 rlrevell       Note Added: 0008509                          
03-14-06 19:23 tiwai          Note Added: 0008510                          
03-14-06 19:27 binilbenjamin  Note Added: 0008511                          
03-14-06 20:08 rlrevell       Note Added: 0008512                          
03-15-06 18:27 binilbenjamin  Note Added: 0008560                          
03-15-06 18:40 rlrevell       Note Added: 0008562                          
03-15-06 19:10 binilbenjamin  Note Added: 0008566                          
03-15-06 19:54 rlrevell       Note Added: 0008570                          
03-16-06 17:53 binilbenjamin  Note Added: 0008616                          
03-16-06 19:27 rlrevell       Note Added: 0008618                          
03-17-06 19:23 binilbenjamin  Note Added: 0008652                          
03-17-06 19:41 rlrevell       Note Added: 0008653                          
03-17-06 19:44 rlrevell       Note Added: 0008654                          
03-17-06 19:54 tiwai          Status                   new => resolved     
03-17-06 19:54 tiwai          Resolution               open => fixed       
03-17-06 19:54 tiwai          Assigned To               => tiwai           
03-17-06 19:54 tiwai          Note Added: 0008655                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
