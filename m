From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000653]: poor microphone recording quality on pcicmi
Date: Thu, 18 Nov 2004 20:01:14 +0100
Message-ID: <8855fbbf6c001d6dfdc4100e4bc18118@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4C013211
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 20:01:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=653> 
======================================================================
Reported By:                pbienst
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   653
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9-gentoo-r4
======================================================================
Date Submitted:             11-18-2004 10:58 CET
Last Modified:              11-18-2004 20:01 CET
======================================================================
Summary:                    poor microphone recording quality on pcicmi
Description: 
I have a C-Media PCI CMI8738-MC6 (rev 16) from a Hercules Muse DVD soundd
card.

When recording from a headset microphone, sound quality is really bad: low

volume and quite some noise / distortion.

I have my microphone mixers maxed out, 'Mic boost' is on, 'Mic as
Center/LFE' 
is off.

I've fiddled with all the other options, but they don't seem to affect the

quality.

I do my recording with:

arecord -D hw:1,0 -d 4 test.wav

Under Windows, sound quality is a lot better with the same setup.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-18-04 19:54 
----------------------------------------------------------------------
No, the last argument is the inverse - you just flipped the meaning of 0
and 1.  So these bits also play nothing.

It seems that all existing mixer switches have no influence on your
problem at all.  No matter which combination, it's liekly useless.

Sorry, simply lack of hardware information.  I can't do any more.

----------------------------------------------------------------------
 pbienst - 11-18-04 20:01 
----------------------------------------------------------------------
Well, I don't think we have explored all options then, since I haven't been
able to set the "MICBST", "EMUCB" and "VADMIC3" mixer switches.

Which lines in the driver do I need to change to set these?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-18-04 10:58 pbienst        New Issue                                    
11-18-04 10:58 pbienst        Distribution              => Gentoo          
11-18-04 10:58 pbienst        Kernel Version            => 2.6.9-gentoo-r4 
11-18-04 18:07 tiwai          Note Added: 0002453                          
11-18-04 18:08 tiwai          File Added: cmipci-test.diff                    
11-18-04 19:11 pbienst        Note Added: 0002459                          
11-18-04 19:26 pbienst        Note Added: 0002460                          
11-18-04 19:33 tiwai          Note Added: 0002461                          
11-18-04 19:36 pbienst        Note Added: 0002462                          
11-18-04 19:54 tiwai          Note Added: 0002467                          
11-18-04 20:01 pbienst        Note Added: 0002468                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
