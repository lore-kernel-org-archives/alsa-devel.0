From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002188]: Alsa mixer lack of some
	functions
Date: Thu, 8 Jun 2006 02:52:55 +0200
Message-ID: <f1ca2983454b1ec41087225922b2c7ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C83E6165
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jun 2006 02:52:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2188> 
======================================================================
Reported By:                Cimmo
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2188
Category:                   alsamixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-07-2006 16:56 CEST
Last Modified:              06-08-2006 02:52 CEST
======================================================================
Summary:                    Alsa mixer lack of some functions
Description: 
Is it possible to add to the alsa-mixer the possibility to change these
things:

- dolby surround configurations: 2.0, 2.1, 4.0, 4.1, 5.1, 7.1 and the
possibility to duplicate front sound to the rear speakers.
- modify high and basses

best things is changes are immediatelly available without relogging.
These feature are missing to linux community that have always to trouble
with configuration files.

thanx for attention
Marco
======================================================================

----------------------------------------------------------------------
 Raymond - 06-08-06 02:52 
----------------------------------------------------------------------
alsamixer is just an utility which allow you to change the setting
supported by the hardware (e.g audio chip/codec)

Some codecs are capble of duplicate front to rear but some cannot.

Some chip/codecs has treble/bass control or even equalizer but most of the
sound card don't

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-06 16:56 Cimmo          New Issue                                    
06-08-06 02:52 Raymond        Note Added: 0010104                          
======================================================================
