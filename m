From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000528]: Please support ADPCM
Date: Thu, 18 Nov 2004 18:13:21 +0100
Message-ID: <53ec631120102201c6efecbbe2ed2e33@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 310AE230
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 18:13:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=528> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   528
Category:                   aplay/arecord
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-24-2004 05:52 CEST
Last Modified:              11-18-2004 18:13 CET
======================================================================
Summary:                    Please support ADPCM
Description: 
Hi,

together with some help from Steven Kowalik, I was able to find out that
aplay fails to play some pcm encoded files. A closer look reveals that the
files, that fail to play, are encoded with ADPCM encoded. I've found some
explanation about ADPCM at these URLs:

http://www-mobile.ecs.soton.ac.uk/speech_codecs/standards/adpcm.html
http://www.hr/josip/DSP/FAQ/23.html

I would appreciate if aplay would also support those kind of pcm encoded
files. Thanks for adding that support.

Christian
======================================================================

----------------------------------------------------------------------
 pzad - 09-24-04 08:28 
----------------------------------------------------------------------
I think, that there is adpcm plugin.

----------------------------------------------------------------------
 tiwai - 11-18-04 18:13 
----------------------------------------------------------------------
Not all type of ADPCM is supported by ALSA plugin.
We may borrow the relevant code from libsndfile, though...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 05:52 jdthood        New Issue                                    
09-24-04 08:28 pzad           Note Added: 0001857                          
11-18-04 18:13 tiwai          Note Added: 0002454                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
