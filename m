From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000577]: locking two (or more) mixer sliders together to get full volume range
Date: Sun, 10 Oct 2004 17:35:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041010153506.864F64A046@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4655D285
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2004 17:36:30 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 9E67425B0E
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2004 17:35:06 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000577
======================================================================
Reported By:                ldarby
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     577
Category:                   alsamixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-10-2004 17:35 CEST
Last Modified:              10-10-2004 17:35 CEST
======================================================================
Summary:                    locking two (or more) mixer sliders together to get full volume range
Description: 
I noticed that the only way to reduce the volume to the lowest (not muting
it tho) is reducing both Master and PCM sliders, and to get the loudest
non-distorted volume, both need to increased to almost max.  I think I
remember a mixer for a windows driver that could lock two mixer sliders
together to do this, and I've done this myself from within XMMS, but it
relies on Master and PCM elems being in a certain position (probably sound
card dependent).  Would it be a good idea to implement this in a general
way in alsamixer, or has this already been done in another mixer?
(googling for linux mixers reveals far too many to check through...)

Thanks,
Laurence
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-10-04 17:35 ldarby         New Bug                                      
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
