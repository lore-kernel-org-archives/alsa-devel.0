From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000557]: SNDCTL_DSP_GETOPTR not working correctly in specific situation
Date: Fri, 13 May 2005 15:20:18 +0200
Message-ID: <d356d4c982fb74f417545be1a63a562f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 35D571F5
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2005 15:20:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=557> 
======================================================================
Reported By:                minmax
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   557
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             vanilla 2.6.7
======================================================================
Date Submitted:             10-01-2004 16:18 CEST
Last Modified:              05-13-2005 15:20 CEST
======================================================================
Summary:                    SNDCTL_DSP_GETOPTR not working correctly in specific
situation
Description: 
When the first few writes to the oss emulation device are done in specific
way, SNDCTL_DSP_GETOPTR returns wrongly huge results in info.bytes
======================================================================

----------------------------------------------------------------------
 minmax - 04-09-05 16:22 
----------------------------------------------------------------------
i've got new laptop since i reported this bug.

I've stumbled upon a bug when using Cinelerra (video editing software),
and since then i have patched the software to ignore the excessively wrong
results gotten from SNDCTL_DSP_GETOPTR

        if(!ioctl(get_output(0), SNDCTL_DSP_GETOPTR, &info))
        {
//printf("AudioOSS::device_position %d %d %d\n", info.bytes,
device->get_obits(), device->get_ochannels());
// workaround for ALSA OSS emulation driver's bug
// the problem is that if the first write to sound device was not full
lenght fragment then
// _GETOPTR returns insanely large numbers at first moments of play
                if (info.bytes > 2100000000)
                        return 0;
                else
                        return info.bytes /
                                (device->get_obits() / 8) /
                                device->get_ochannels();
        }

----------------------------------------------------------------------
 gk4 - 05-13-05 15:20 
----------------------------------------------------------------------
We are seeing the same problem for ibmtts on Fedora Core 3 using Gnome
2.10.1 & gnome-speech 0.3.6.  I would like to request increasing the
priority on this 8 month old bug because it is impacting accessibility on
Linux.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-01-04 16:18 minmax         New Issue                                    
10-01-04 16:18 minmax         Distribution              => Debian unstable 
10-01-04 16:18 minmax         Kernel Version            => vanilla 2.6.7   
10-02-04 10:52 minmax         Issue Monitored: minmax                      
04-09-05 16:09 jdthood        Note Added: 0004406                          
04-09-05 16:22 minmax         Note Added: 0004410                          
05-13-05 15:20 gk4            Note Added: 0004646                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
