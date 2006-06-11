From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002199]: No sound from M-AUDIO
	Revolution 5.1
Date: Sun, 11 Jun 2006 19:40:57 +0200
Message-ID: <226d19487a9a157c6b6ade8cb361b1db@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EC06510A
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Jun 2006 19:40:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2199> 
======================================================================
Reported By:                hlabs
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2199
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-09-2006 21:25 CEST
Last Modified:              06-11-2006 19:40 CEST
======================================================================
Summary:                    No sound from M-AUDIO Revolution 5.1
Description: 
M-AUDIO Revo 5.1
kernel 2.6.16
alsa 1.0.11

I got sound only from front channel.
Other channels doesn't works at all.

In alsamixer all outs unmuted and routed to pcm out.

======================================================================

----------------------------------------------------------------------
 wollschaf - 06-11-06 00:06 
----------------------------------------------------------------------
It is not very clear what you intend to do with the other channels. 

The channels themselves work, to use the surround channel as normal stero
device I placed the following in my ~/.asoundrc

pcm.!surround {
  type plug
  slave.pcm "dmixer2"
}

pcm.dmixer2  {
        type dmix
        ipc_key 1024
        slave {
                pcm "hw:0,2,1"
                format S32_LE
                period_time 0
                period_size 2048
                buffer_size 24756
                rate 44100
        }
        bindings {
                0 0
                1 1
        }
}


I used excessive buffer values as my PCI graphics card interferes with
nonstop audio replay :(

pcm "hw:0,2,0" is the center/sub channel.

I have no experience using real multichannel audio, though.

----------------------------------------------------------------------
 hlabs - 06-11-06 19:40 
----------------------------------------------------------------------
Thanks a lot !

Also working HP out is necessary to me.
And what device corresponds to HP output ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-06 21:25 hlabs          New Issue                                    
06-09-06 21:34 hlabs          Issue Monitored: hlabs                       
06-11-06 00:06 wollschaf      Note Added: 0010149                          
06-11-06 19:40 hlabs          Note Added: 0010152                          
======================================================================
