From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002289]: Wrong channel description for
	Macbook Pro soundcard
Date: Tue, 18 Jul 2006 06:19:32 +0200
Message-ID: <a486aa6567a5864525fb4d647f876097@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3335B22F
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 06:19:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2289> 
======================================================================
Reported By:                rbultje
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2289
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper 6.06
Kernel Version:             2.6.15
======================================================================
Date Submitted:             07-18-2006 06:19 CEST
Last Modified:              07-18-2006 06:19 CEST
======================================================================
Summary:                    Wrong channel description for Macbook Pro soundcard
Description: 
Hi,

some of the mixer channels in gnom-volume-control are:
* surround
* lfe
* center
* front

The first one controls the volume of the speakers, and the rest appears
dysfunctional (there is no connection on the laptop to do anything with
any of it). I'm assuming those chip controls are unconnected. Either way,
the channel name is confusing and may lead people to believe that their
laptop is broken, whereas really, just an unsuspected channel is muted.

Would it be possible to (for spec->board_config = STAC_MACMINI):
- omit lfe, front and center
- rename surround to speakers?

I tried making a patch myself but it had odd effects (no sound at all,
sound coming out of the mic jack) so I probably did something wrong or
misunderstand the code.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-18-06 06:19 rbultje        New Issue                                    
07-18-06 06:19 rbultje        Distribution              => Ubuntu Dapper 6.06
07-18-06 06:19 rbultje        Kernel Version            => 2.6.15          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
