From: noreply@alsa-project.org
Subject: [ALSA - utils 0000398]: aplay produces no sound on short wav files through dmix
Date: Mon, 19 Jul 2004 16:21:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040719142138.B763D18005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3563C1D6
	for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2004 16:21:39 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id CA44313BC1
	for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2004 16:21:38 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000398
======================================================================
Reported By:                raveng
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     398
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-19-2004 16:21 CEST
Last Modified:              07-19-2004 16:21 CEST
======================================================================
Summary:                    aplay produces no sound on short wav files through dmix
Description: 
Wav files shorter than about 0.157 seconds produce no sound under aplay and
dmix. No error message is given, and it looks like it should be working.
If I add silence to the file to make the duration longer, it plays fine.
Also, if I direct aplay to use the hardware directly, it plays the
original file just fine.  Tested on both ens1371 and i810 audio.

Other media players (xmms, mplayer, and artsplay) all play the same file
correctly with dmix. It is only the ALSA-provided aplay that seems to have
difficulty.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-19-04 16:21 raveng         New Bug                                      
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
