From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000749]: Buzz from ALSA setup
Date: Mon, 27 Dec 2004 16:33:54 +0100
Message-ID: <f8b94ae977c66a7d535ea52923342743@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5F08516F
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 16:33:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=749> 
======================================================================
Reported By:                misnagid
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   749
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora FC3
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-26-2004 15:37 CET
Last Modified:              12-27-2004 16:33 CET
======================================================================
Summary:                    Buzz from ALSA setup
Description: 
I get an almost constant buzz from speakers when I've tried to use ALSA. 
Have followed your directions from the online web page directions to the
letter.  Still buzz.
Have brought all sound levels up ising alsamixer and Kmix.  Of no help. 
Have tried everything I've seen about this problem.
OnBoard NVidia audio from Asus A7N8X-E Deluxe disabled.  Using emu10k1
driver for installed Creative Labs Audigy 2 soundcard. This is a brand new
successful in all other regards install of Fedora FC3.

======================================================================

----------------------------------------------------------------------
 pzad - 12-27-04 10:46 
----------------------------------------------------------------------
save and attach test.state again

alsactl -f test.state store

What speakers do you have 2, 4, 5.1 ???

----------------------------------------------------------------------
 misnagid - 12-27-04 16:33 
----------------------------------------------------------------------
am sending you new file requested as test2.state, had problems deleteng
older test.state.  please accept test2.state

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-04 15:37 misnagid       New Issue                                    
12-26-04 15:37 misnagid       Distribution              => Fedora FC3      
12-26-04 15:37 misnagid       Kernel Version            => 2.6.9           
12-26-04 15:58 pzad           Note Added: 0002935                          
12-26-04 16:31 misnagid       Note Added: 0002936                          
12-26-04 16:44 misnagid       Note Added: 0002937                          
12-26-04 16:56 pzad           Note Added: 0002938                          
12-26-04 17:47 misnagid       Note Added: 0002939                          
12-26-04 18:07 misnagid       Note Added: 0002940                          
12-26-04 18:17 misnagid       Note Added: 0002942                          
12-26-04 18:38 misnagid       Note Added: 0002943                          
12-26-04 19:27 pzad           Note Added: 0002944                          
12-26-04 19:44 misnagid       File Added: test.state                       
12-26-04 19:44 misnagid       Note Added: 0002945                          
12-26-04 20:02 misnagid       Note Added: 0002946                          
12-26-04 20:09 misnagid       Note Added: 0002947                          
12-26-04 20:22 pzad           File Added: newtest.state                    
12-26-04 20:27 pzad           Note Added: 0002948                          
12-26-04 20:32 pzad           Note Added: 0002949                          
12-26-04 20:59 misnagid       Note Added: 0002950                          
12-26-04 21:11 misnagid       Note Added: 0002951                          
12-26-04 21:19 pzad           Note Added: 0002952                          
12-26-04 21:22 pzad           Note Added: 0002953                          
12-26-04 21:43 misnagid       Note Added: 0002954                          
12-26-04 21:47 pzad           Note Added: 0002955                          
12-26-04 22:18 misnagid       Note Added: 0002956                          
12-26-04 23:46 misnagid       Note Added: 0002957                          
12-27-04 10:46 pzad           Note Added: 0002958                          
12-27-04 16:33 misnagid       Note Added: 0002964                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
