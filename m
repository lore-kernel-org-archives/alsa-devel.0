From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000798]: Make alsaconf optinal able to create an asound.conf
Date: Wed, 19 Jan 2005 16:54:31 +0100
Message-ID: <de5ee5d6831d7e9463a87509010ad0d9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 36E8C22F
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 16:54:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=798> 
======================================================================
Reported By:                christeck
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   798
Category:                   alsaconf
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-09-2005 22:05 CET
Last Modified:              01-19-2005 16:54 CET
======================================================================
Summary:                    Make alsaconf optinal able to create an asound.conf
Description: 
An asound.conf is difficult to create manually due to its difficult to
understand syntax. Would be great if alsaconf could optional create it, so
the user can

* Define in which order the cards appear (e.g., internal AC97, Modem,
USB-Audio and an USB MIDI card)

* Define some dmix devices

* Else? Not familiar enough with dmix, I do not use it :)
======================================================================

----------------------------------------------------------------------
 tiwai - 01-19-05 16:48 
----------------------------------------------------------------------
Agreed.  Both issues described are above the scope of alsaconf.

dmix will be default in alsa-lib without any special configuration for
most of mobo drivers in the next version (I hope).

The order of card is not the problem of asound.conf but rather index
module option.  Since alsaconf supports only a single card, this is also 
out or its target.  The hack to move modem to the secondary card (by
James) will be added in the next rext version, too.

----------------------------------------------------------------------
 jdthood - 01-19-05 16:54 
----------------------------------------------------------------------
>  The hack to move modem to the secondary card (by James) will
> be added in the next rext version, too.

Are you referring to my hack?  If so then N.B. my name is Thomas.  :)
If not, then please let me know what James's hack will do.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-09-05 22:05 christeck      New Issue                                    
01-19-05 15:29 jdthood        Note Added: 0003287                          
01-19-05 16:48 tiwai          Note Added: 0003293                          
01-19-05 16:54 jdthood        Note Added: 0003297                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
