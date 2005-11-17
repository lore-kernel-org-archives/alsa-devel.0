From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001570]: IEC958 subframes are not generated correctly by the iec958 plugin
Date: Thu, 17 Nov 2005 01:21:58 +0100
Message-ID: <68d20a98de2c60f69b050932d781e444@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0D58A1B5
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2005 01:21:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1570> 
======================================================================
Reported By:                nboullis
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1570
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-17-2005 01:21 CET
Last Modified:              11-17-2005 01:21 CET
======================================================================
Summary:                    IEC958 subframes are not generated correctly by the
iec958 plugin
Description: 
If I understand it correctly (see
http://www.epanorama.net/documents/audio/spdif.html for example) all
non-first channels should use the W preamble, while the first channel
should use the B preamble once in each block (192 subframes) and the M
preamble otherwise.

This would lead to the following sequence of preambles:
BWMWMWMWMW....MW

On the other hand, the current code generates B preambles for all the
channels once in each block, otherwise W preambles for the first channel,
and M preambles for the other channels.

This leads to the following sequence of preambles:
BBWMWMWMWM....WM

Hence, it appears that M and W preambles are swapped (but this would be
fixable by swapping the values of the preambles), but also that there are
extraneous B preambles.

The attached patch fixes this issue.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-17-05 01:21 nboullis       New Issue                                    
11-17-05 01:21 nboullis       File Added: alsa-lib.patch                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
