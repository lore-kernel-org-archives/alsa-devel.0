From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000749]: Buzz from ALSA setup
Date: Sun, 26 Dec 2004 21:11:20 +0100
Message-ID: <c48c0e128da0b9d004a8c89995985021@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 76EFE2B9
	for <alsa-devel@alsa-project.org>; Sun, 26 Dec 2004 21:11:20 +0100 (MET)
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
Last Modified:              12-26-2004 21:11 CET
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
 misnagid - 12-26-04 20:59 
----------------------------------------------------------------------
Thanks a lot!  I use analogue speakers.  Just some cheapies right off the
Audigy 2 (op amp output I assume) board.  I always am sure to close down
kmix completely.

By the way, where is this newtest.state file that you referred to in your
last email, that you want me to use to run alsactl?  Is this a file that I
am spozed to get rom you?

Well I ran the test.  There was no sound output at all.  Here's the
standard out:

[root@ashkenazi jerry]# alsactl store
[root@ashkenazi jerry]# speaker-test -D surround51 -c 6

speaker-test 1.0.8rc1

Playback device is surround51
Stream parameters are 48000Hz, S16_LE, 6 channels
Sine wave rate is 440.0000Hz
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 64 to 16384
Period size range from 16 to 16384
Buffer time size 2525
To choose buffer_size = 2520
To choose period_size = 315
was set period_size = 315
was set buffer_size = 2520
  - Front Left
  - Front Right
  - Rear Left
  - Rear Right
  - Center
  - LFE
  - Front Left
  - Front Right
  - Rear Left
  - Rear Right
  - Center
  - LFE
  - Front Left
  - Front Right
  - Rear Left
  - Rear Right
  - Center
  - LFE
  - Front Left
  - Front Right

[root@ashkenazi jerry]#


Thanks a lot for your help!

Yours,
Jerr

----------------------------------------------------------------------
 misnagid - 12-26-04 21:11 
----------------------------------------------------------------------
Let me ask you.  Is there a different manufacturer's board other than
Creative, that is similar in quality but a lot easier in setting up in
Alsa??  With every install, whether it be Fedora, Suse, Mandrake, Debian,
I've had problems with Alsa setup.  This one has been the worst by a wide
margin I admit but still sure no fun.  Is there an easier set up card with
as high a quality as Creative's?

Thanks!
Jerr

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
