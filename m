From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000792]: alsa fails to initialize after UDEV is installed
Date: Sat, 8 Jan 2005 04:12:03 +0100
Message-ID: <b87c5a1256867608334b3c50e60840f8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 561662DC
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2005 04:12:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=792> 
======================================================================
Reported By:                sluce
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   792
Category:                   alisp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-08-2005 04:12 CET
Last Modified:              01-08-2005 04:12 CET
======================================================================
Summary:                    alsa fails to initialize after UDEV is installed
Description: 
I'm really running 1.0.7 but that wasn't an option above.
The kernel reports that it finds my CMI8330 card and alsa says:
pnp: the driver 'cmi8330' has been registered
pnp: match found with the PnP device '01:01.00' and the driver 'cmi8330'
pnp: match found with the PnP device '01:01.03' and the driver 'cmi8330'
pnp: Device 01:01.00 activated.
pnp: Device 01:01.03 activated.
ALSA sound/isa/sb/sb_common.c:130: SB [0x220]: DSP chip found, version =
4.13

I am unable to use the sound card.  KDE is configured to use alsa but is
unable to open the sound device.

I'll happily provide more information if you tell me what you want to see.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-08-05 04:12 sluce          New Issue                                    
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
