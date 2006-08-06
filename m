From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001411]: plug:jack interface not
	working for apps that both read and write
Date: Sun, 6 Aug 2006 03:09:24 +0200
Message-ID: <d828f8ba90686ea8b8f95584f1421707@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BFA21179
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 03:09:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1411> 
======================================================================
Reported By:                b0ef
Assigned To:                
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1411
Category:                   PCM - jack
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-10-2005 17:57 CEST
Last Modified:              08-06-2006 03:09 CEST
======================================================================
Summary:                    plug:jack interface not working for apps that both
read and write
Description: 
This is a general problem with any app that both read and write to the
plug:jack device. It (plug:jack) however works for apps that only do one
or the other. 
======================================================================

----------------------------------------------------------------------
 Raymond - 08-02-06 13:18 
----------------------------------------------------------------------
Are there any reason to use jack instead of ALSA when running asterisk and
kphone (internet phone application)?

----------------------------------------------------------------------
 b0ef - 08-06-06 03:09 
----------------------------------------------------------------------
Indeed. There are several reasons. 

First off; it's very important to preprocess the audio signal so you get a
good voice when talking. For radio shows and audio conferencing you need
good control of the audio channel. 

Secondly, for audio cards that requires exclusive access, it's not
possible to use ALSA and JACk at the same time and of course JACK is
always up in a serious audio environment. 

I request that this bug be closed as I've recently changed audio card. I
will open new bugs on the JACK plugin, f.ex that it doesn't work with
96kHz sampling rates. 

This bug is too old to pursue and no one has added any info to help
resolve it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-06-06 03:09 b0ef           Note Added: 0011455                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
