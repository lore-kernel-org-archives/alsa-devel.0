From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001411]: plug:jack interface not
	working for apps that both read and write
Date: Wed, 2 Aug 2006 13:18:44 +0200
Message-ID: <80fc65a03c4c7de6c13b993aa2b6d217@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3428718D
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Aug 2006 13:18:44 +0200 (MEST)
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
Last Modified:              08-02-2006 13:18 CEST
======================================================================
Summary:                    plug:jack interface not working for apps that both
read and write
Description: 
This is a general problem with any app that both read and write to the
plug:jack device. It (plug:jack) however works for apps that only do one
or the other. 
======================================================================

----------------------------------------------------------------------
 b0ef - 09-10-05 18:11 
----------------------------------------------------------------------
I have applied the realtime patch to linux from
http://people.redhat.com/mingo/realtime-preempt/ but I've also tested
without and see the same problem

I'm running linux-2.6.13-rt4

ALSA apps that use both playback and capture fails to work with plug:jack

I have tested with several applications, primarily asterisk and kphone

I have not found any app that uses both playback and capture that works
with plug:jack. Normal playback and capture separate with plug:jack works
great.

----------------------------------------------------------------------
 Raymond - 08-02-06 13:18 
----------------------------------------------------------------------
Are there any reason to use jack instead of ALSA when running asterisk and
kphone (internet phone application)?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-10-05 17:57 b0ef           New Issue                                    
09-10-05 18:11 b0ef           Note Added: 0006123                          
03-24-06 05:49 Raymond        Note Added: 0008912                          
08-02-06 13:11 Raymond        Note Deleted: 0008912                        
08-02-06 13:18 Raymond        Note Added: 0011385                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
