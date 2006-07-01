From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001835]: Patch to add volume control
	per voice for au88x0
Date: Sat, 1 Jul 2006 06:27:38 +0200
Message-ID: <5d7ba05793f1d39d2e3dd9dbfe354def@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6D3B024A
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 06:27:38 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1835> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1835
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-10-2006 03:28 CET
Last Modified:              07-01-2006 06:27 CEST
======================================================================
Summary:                    Patch to add volume control per voice for au88x0
Description: 
As the proposed API "PCM volume control per snd_pcm_open()" have not been
finalised, I upload the program ( a workaround tool instead of demo ) to
test the new feature "Volume control per voice" for au88x0 using
SNDRV_CTL_ELEM_IFACE_PCM
======================================================================

----------------------------------------------------------------------
 rlrevell - 07-01-06 05:31 
----------------------------------------------------------------------
If you want feedback on this, you have to post it to the alsa-devel mailing
list.  This bug tracker is not the right forum for general development
discussions.

----------------------------------------------------------------------
 Raymond - 07-01-06 06:27 
----------------------------------------------------------------------
Add "optional true" to ctl_elems will prevent au8830 with stereo codec to
report wrong error  


<confdir:pcm/rear.conf>

AU8830.pcm.rear.0 {
    @args [ CARD ]
    @args.CARD {
        type string
    }
    type hooks
    slave.pcm {
        type hw
        card $CARD
        device 0
    }
    hooks.0 {
        type ctl_elems
        hook_args [
            {
                interface PCM
                device 0
                name "Subdevice Playback Volume"
                optional true
                index { @func private_pcm_subdevice }
                value [ -64 -64 8 8 ]
            }
        ]
    }
}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-10-06 03:28 Raymond        New Issue                                    
02-10-06 03:30 Raymond        File Added: iface_pcm.c                      
02-11-06 11:19 Raymond        Note Added: 0008014                          
02-13-06 16:07 Raymond        Note Added: 0008053                          
02-22-06 08:59 Raymond        File Added:
vol_ctrl_per_voice_testing_using_aplay.patch                    
02-22-06 09:57 Raymond        Note Added: 0008156                          
03-29-06 16:15 Raymond        File Added:
au88x0_pcm_vol_using_index_control.patch                    
03-29-06 17:44 Raymond        Note Added: 0008994                          
04-07-06 03:21 ponchick       Note Added: 0009132                          
04-07-06 03:57 Raymond        Note Added: 0009133                          
04-11-06 07:32 Raymond        Note Added: 0009228                          
04-20-06 06:04 Raymond        Note Added: 0009365                          
07-01-06 05:02 Raymond        File Added: iface_pcm_v2.c                    
07-01-06 05:05 Raymond        Note Added: 0010757                          
07-01-06 05:31 rlrevell       Note Added: 0010759                          
07-01-06 06:27 Raymond        Note Added: 0010760                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
