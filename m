From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001536]: Error during compiling hpetimer.c
Date: Mon, 14 Nov 2005 10:00:08 +0100
Message-ID: <b14d8ca1f371d6c93304d77ce768bee9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 19F0219D
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 10:00:09 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1536> 
======================================================================
Reported By:                spm
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1536
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian
Kernel Version:             2.6.14-rc3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-08-2005 15:54 CET
Last Modified:              11-14-2005 10:00 CET
======================================================================
Summary:                    Error during compiling hpetimer.c
Description: 
This error occurs when trying to make 1.09b driver on my 2.6.14-rc3
kernel.

make[1]: Entering directory `/usr/src/linux-2.6.14-rc3'
  CC [M]  /usr/src/alsa/alsa-driver-1.0.9b/acore/hpetimer.o
In file included from
/usr/src/alsa/alsa-driver-1.0.9b/include/adriver.h:677,
                 from
/usr/src/alsa/alsa-driver-1.0.9b/include/sound/driver.h:42,
                 from
/usr/src/alsa/alsa-driver-1.0.9b/acore/hpetimer.c:22:
include/linux/pci.h:392: error: parse error before numeric constant
make[4]: *** [/usr/src/alsa/alsa-driver-1.0.9b/acore/hpetimer.o] Error 1
make[3]: *** [/usr/src/alsa/alsa-driver-1.0.9b/acore] Error 2


Any ideas? I have also tried on the development release
(alsa-driver-1.0.10rc2), and get the same error..


======================================================================

----------------------------------------------------------------------
 spm - 11-10-05 16:26 
----------------------------------------------------------------------
Good point...I didnt realize. I am new at this.

I was getting an error accessing ALSA, so someone "knowledgeable" told me
to install the Dev Release of ALSA to fix my problem. Thats where I
encountered the problem.

Here is the original error I got (starting VDR):



ALSA lib confmisc.c:560:(snd_determine_driver) could not open control for
card 0
ALSA lib conf.c:3479:(_snd_config_evaluate) function snd_func_card_driver
returned error: No such device or address
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:3479:(_snd_config_evaluate) function snd_func_concat
returned error: No such device or address
ALSA lib confmisc.c:955:(snd_func_refer) error evaluating name
ALSA lib conf.c:3479:(_snd_config_evaluate) function snd_func_refer
returned error: No such device or address
ALSA lib conf.c:3948:(snd_config_expand) Evaluate error: No such device or
address
ALSA lib pcm.c:2090:(snd_pcm_open_noupdate) Unknown PCM default

----------------------------------------------------------------------
 perex - 11-14-05 10:00 
----------------------------------------------------------------------
Please, open another bug, or better - the support request should be sent to
the alsa-user mailing list. See the ALSA web site for subscription
details.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-05 15:54 spm            New Issue                                    
11-08-05 15:54 spm            Distribution              => Debian          
11-08-05 15:54 spm            Kernel Version            => 2.6.14-rc3      
11-08-05 18:18 Clemens LadischNote Added: 0006629                          
11-08-05 18:28 tiwai          Note Added: 0006631                          
11-08-05 18:48 spm            File Added: config.log                       
11-08-05 18:49 spm            Note Added: 0006638                          
11-09-05 00:27 spm            Note Edited: 0006638                         
11-09-05 21:29 spm            Note Added: 0006656                          
11-10-05 00:34 rlrevell       Note Added: 0006659                          
11-10-05 16:26 spm            Note Added: 0006665                          
11-14-05 10:00 perex          Status                   assigned => resolved
11-14-05 10:00 perex          Resolution               open => fixed       
11-14-05 10:00 perex          Note Added: 0006700                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
