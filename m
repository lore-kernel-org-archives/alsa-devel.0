From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001140]: sine wave generator only works for 16bit cards
Date: Sun, 29 May 2005 03:11:07 +0200
Message-ID: <0593aced17a2045b7e32e84b497e086b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 836301CB
	for <alsa-devel@alsa-project.org>; Sun, 29 May 2005 03:11:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1140> 
======================================================================
Reported By:                grabner
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1140
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-29-2005 03:11 CEST
Last Modified:              05-29-2005 03:11 CEST
======================================================================
Summary:                    sine wave generator only works for 16bit cards
Description: 
The simple sine wave generator, which serves as a test program for PCM
audio, only creates 16bit samples. It has no option to switch this
behaviour (although it lists "recognized sample formats"). However, it
doesn't refuse to play to non-16bit devices, which produces noise.

Note: this refers to alsa-lib version 1.0.*9*, but this wasn't available
in the "Product Version" selection.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-05 03:11 grabner        New Issue                                    
05-29-05 03:11 grabner        File Added: pcm.diff                         
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
