From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000154]: Master volume only controls front output (emu10k1)
Date: Fri, 14 Apr 2006 03:48:49 +0200
Message-ID: <d61ef7387c0e84cf683f84b4270af7c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BB399176
	for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2006 03:48:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=154> 
======================================================================
Reported By:                wzzrd
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   154
Category:                   2_mixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             03-23-2004 17:31 CET
Last Modified:              04-14-2006 03:48 CEST
======================================================================
Summary:                    Master volume only controls front output (emu10k1)
Description: 
Setting the alsamixer Master Volume slider only controls the front two
speakers. The rear speakers have to be controlled with the Wave Surround
setting. I'm not sure whether this is an alsamixer bug or a alsa-driver
bug. If I'm wrong putting it here, sorry.

It would be very convenient to be able to control all four speakers with
the Master Volume setting and to have a Front and Rear slider to control
the front and rear speakers individually.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000176 Master volume does not alters center, L...
has duplicate       0000786 Master can't handle all channel
has duplicate       0001256 surround51: Master Volume control and M...
has duplicate       0001071 Help with Volume Controls
related to          0000919 Master volume doesn't control rear spea...
======================================================================

----------------------------------------------------------------------
 Miwer - 03-17-06 14:16 
----------------------------------------------------------------------
Raymond I have no idea what you're talking about... those values I wrote
refer to the settings of the corresponding level adjusters in the
alsamixer app.

----------------------------------------------------------------------
 shina - 04-14-06 03:48 
----------------------------------------------------------------------
With master_volume_v3.patch there's now an extra Volumen Control called
"Master Digital". That's useless since I still have to use Wave Sourround
to control PCM Rear Volume. Changing "PCM" has no effect.
Also there's still no Line/Midi output on rear :(

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-23-04 17:31 wzzrd          New Issue                                    
03-23-04 18:42 perex          View Status              @0@ => public       
03-23-04 18:42 perex          Description Updated                          
03-23-04 18:42 perex          Additional Information Updated                    
03-23-04 18:43 perex          Status                   new => assigned     
03-23-04 18:43 perex          Assigned To               => perex           
03-26-04 20:21 djtm           Note Added: 0000708                          
04-19-04 02:47 tarball        Issue Monitored: tarball                     
04-19-04 21:23 perex          Relationship added       has duplicate 0000176
05-24-04 22:51 delmonico      Note Added: 0001199                          
10-22-04 16:44 perex          Relationship added       related to 0000172  
10-23-04 01:09 djtm           Note Added: 0002253                          
10-23-04 01:09 djtm           File Added: alsavol.sh                       
10-23-04 01:10 djtm           Note Edited: 0002253                         
11-25-04 12:46 rpolach        Issue Monitored: rpolach                     
01-04-05 21:01 Miwer          Note Added: 0003081                          
01-04-05 21:11 rlrevell       Note Added: 0003082                          
01-04-05 21:29 pzad           Note Added: 0003083                          
01-04-05 21:38 rlrevell       Note Added: 0003084                          
01-04-05 22:30 pzad           Note Added: 0003085                          
01-04-05 22:38 rlrevell       Note Added: 0003086                          
01-07-05 18:23 tiwai          Relationship added       has duplicate 0000786
01-09-05 20:28 voroskoi       Issue Monitored: voroskoi                    
01-27-05 00:58 adamk75        Issue Monitored: adamk75                     
01-27-05 01:00 adamk75        Note Added: 0003418                          
02-01-05 22:57 adamk75        Note Added: 0003475                          
02-03-05 20:20 rlrevell       Note Added: 0003493                          
02-17-05 22:01 adamk75        Note Added: 0003642                          
02-17-05 22:59 rlrevell       Note Added: 0003646                          
02-17-05 23:28 adamk75        Note Added: 0003647                          
02-22-05 09:56 perex          Relationship added       related to 0000919  
05-20-05 20:39 Miwer          Issue Monitored: Miwer                       
05-20-05 22:02 Miwer          Note Added: 0004699                          
05-20-05 22:05 rlrevell       Note Added: 0004700                          
07-13-05 18:56 rlrevell       Relationship added       has duplicate 0001256
07-16-05 17:11 jdthood        Relationship added       has duplicate 0001071
09-02-05 19:55 blueSceaDa     Issue Monitored: blueSceaDa                    
03-09-06 11:34 muffty         Note Added: 0008388                          
03-09-06 11:37 muffty         Issue Monitored: muffty                      
03-12-06 21:27 rlrevell       Relationship deleted     related to 0000172  
03-12-06 21:34 rlrevell       File Added: master_volume_v3.patch                
   
03-12-06 21:35 rlrevell       Note Added: 0008436                          
03-13-06 13:28 tiwai          Note Added: 0008440                          
03-13-06 13:49 muffty         Note Deleted: 0008388                        
03-13-06 13:51 muffty         Note Added: 0008442                          
03-13-06 14:36 tiwai          Note Added: 0008443                          
03-13-06 18:09 rlrevell       Note Added: 0008454                          
03-14-06 00:04 Miwer          Note Added: 0008470                          
03-16-06 15:41 Raymond        Note Added: 0008608                          
03-16-06 19:22 rlrevell       Note Added: 0008617                          
03-17-06 02:30 Raymond        Note Added: 0008628                          
03-17-06 14:16 Miwer          Note Added: 0008645                          
04-14-06 03:48 shina          Note Added: 0009280                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
