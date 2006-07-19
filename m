From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002292]: volume suspend/resume no longer
	works.
Date: Wed, 19 Jul 2006 22:31:27 +0200
Message-ID: <26b7bf2535cf022872f8cfcc5c0920fa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 02F3217A
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Jul 2006 22:31:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2292> 
======================================================================
Reported By:                cartman
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2292
Category:                   2_mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-18-2006 22:27 CEST
Last Modified:              07-19-2006 22:31 CEST
======================================================================
Summary:                    volume  suspend/resume no longer works.
Description: 
I was using 2.6.18 latest git tree fine so far but when I updated alsa-lib
and other userspace tools to 1.1.12rc1 mplayer gives this error when
suspending/resuming volume :

alsa-pause: pcm pause error: Input/output error
alsa-resume: pcm resume error: Input/output error

Corresponding source code is :

[...]
if ((err = snd_pcm_pause(alsa_handler, 1)) < 0)
        {
            mp_msg(MSGT_AO,MSGL_ERR,"alsa-pause: pcm pause error: %s\n",
snd_strerror(err));
            return;
        }
[...]

and similar for resume.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-19-06 22:13 
----------------------------------------------------------------------
How about the second patch?

----------------------------------------------------------------------
 cartman - 07-19-06 22:31 
----------------------------------------------------------------------
Second patch works, thank you!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-18-06 22:27 cartman        New Issue                                    
07-19-06 20:14 tiwai          Note Added: 0011094                          
07-19-06 20:14 tiwai          File Added: dmix-pause-disable.diff               
    
07-19-06 20:24 cartman        Note Added: 0011097                          
07-19-06 22:12 tiwai          File Added: dmix-pause-disable2.diff              
     
07-19-06 22:13 tiwai          Note Added: 0011103                          
07-19-06 22:31 cartman        Note Added: 0011104                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
