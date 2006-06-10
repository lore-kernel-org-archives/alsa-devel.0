From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001716]: aoss not working with audacity
Date: Sat, 10 Jun 2006 13:27:32 +0200
Message-ID: <cea08ba9e408f6d3a844337a5619df38@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B8F94173
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Jun 2006 13:27:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1716> 
======================================================================
Reported By:                ajs1984
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1716
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-04-2006 23:04 CET
Last Modified:              06-10-2006 13:27 CEST
======================================================================
Summary:                    aoss not working with audacity
Description: 
Following up from a recent LKML thread, I'm going to report a number of
aoss incompatibilities with softwares on Linux.

First up is audacity, which has no ALSA port. snd-pcm/mixer-oss aren't
loaded.

======================================================================

----------------------------------------------------------------------
 Raymond - 06-09-06 11:01 
----------------------------------------------------------------------
I don't have this card, as you mention that your card have problems with
oss application.

Can you listen the sound produced by the flash plugin of the web brower ?


cat /proc/asound/pcm

cat /proc/asound/cards

----------------------------------------------------------------------
 Raymond - 06-10-06 13:27 
----------------------------------------------------------------------
Can you post the output 


export ALSA_OSS_DEBUG=1
aoss audacity

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 23:04 ajs1984        New Issue                                    
01-04-06 23:06 ajs1984        Note Added: 0007457                          
01-04-06 23:06 ajs1984        Note Added: 0007458                          
06-07-06 15:06 Raymond        Note Added: 0010082                          
06-07-06 15:29 ajs1984        Note Added: 0010083                          
06-07-06 15:41 Raymond        Note Added: 0010084                          
06-08-06 02:41 Raymond        Note Edited: 0010084                         
06-08-06 02:42 Raymond        Note Edited: 0010084                         
06-08-06 02:43 Raymond        Note Edited: 0010084                         
06-09-06 07:01 Raymond        Note Added: 0010133                          
06-09-06 10:04 ajs1984        Note Added: 0010135                          
06-09-06 11:01 Raymond        Note Added: 0010138                          
06-10-06 13:27 Raymond        Note Added: 0010145                          
======================================================================
