From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002292]: volume suspend/resume no longer
	works.
Date: Tue, 18 Jul 2006 22:27:53 +0200
Message-ID: <35336b4d4a3a5b352d332bda272ac8bc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 387B0220
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 22:27:54 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Last Modified:              07-18-2006 22:27 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-18-06 22:27 cartman        New Issue                                    
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
