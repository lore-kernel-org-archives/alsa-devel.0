From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001454]: requantizing to narrower types *MUST* dither
Date: Sun, 25 Sep 2005 00:18:59 +0200
Message-ID: <f2b65f195fdaa10f7ebcf8ebdc96771d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A7C9413F
	for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2005 00:18:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1454> 
======================================================================
Reported By:                ma
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1454
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-25-2005 00:18 CEST
Last Modified:              09-25-2005 00:18 CEST
======================================================================
Summary:                    requantizing to narrower types *MUST* dither
Description: 
alsa-lib 1.0.9/1.0.10rc1 do not currently dither the signal when
requantizing 16-bit hardware input to narrower types, say, 8-bit. It is a
well-known fact in digital signal processing that any requantization
requires dithering to avoid the nasty and hefty twitching noises
particularly with data which is barely above the minimum level of the new,
narrower type. dithering decorellates the quantization noise so it sounds
less obtrusive and linearizes the quantization process.
Books: the art of digital audio (John Watkinson); principles of digital
audio (Ken C. Pohlmann)

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-05 00:18 ma             New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
