From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002038]: Microphone is not working on
	Sigmatel STAC9200
Date: Tue, 25 Jul 2006 13:43:17 +0200
Message-ID: <beb1a4ddb889320b80a8b94e9a8ecc0f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B7628227
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Jul 2006 13:43:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2038> 
======================================================================
Reported By:                telles
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2038
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandriva 2006
Kernel Version:             2.6.12-18mdk
======================================================================
Date Submitted:             04-19-2006 20:58 CEST
Last Modified:              07-25-2006 13:43 CEST
======================================================================
Summary:                    Microphone is not working on Sigmatel STAC9200
Description: 
I have a laptop Dell Latitude 120L with a HDA Intel Sound Board:
Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition
Audio Controller (rev 03)
that is recognized as Sigmatel STAC9200.
Sound is working great but the microphone is not working at all.
I think that is missing some control on alsamixer about Mic, because there
is no Mic's volume or sound control, only "Input Source" is present
(Line|Mic) and seems that it doesn't change anything about Microphone.
======================================================================

----------------------------------------------------------------------
 maiquel - 07-20-06 15:36 
----------------------------------------------------------------------


----------------------------------------------------------------------
 lorenzodp - 07-25-06 13:43 
----------------------------------------------------------------------
hi! I've got the same problem with a Sony vaio FE11M, no way to get any
sign of life by the microphone.

HDA Intel  &#9474;  Chip: SigmaTel STAC7661

no mic in any mixer (alsamixer, amixer, ...)

i use linux slackware and tried all kernels until 2.6.17.
alsa is 1.0.11

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-06 20:58 telles         New Issue                                    
04-19-06 20:58 telles         Distribution              => Mandriva 2006   
04-19-06 20:58 telles         Kernel Version            => 2.6.12-18mdk    
04-19-06 22:09 rlrevell       Note Added: 0009358                          
04-19-06 22:50 telles         Note Added: 0009359                          
04-19-06 23:21 rlrevell       Note Added: 0009361                          
04-20-06 14:30 tiwai          Note Added: 0009373                          
04-20-06 15:59 telles         File Added: codec#0.txt                      
04-20-06 15:59 telles         File Added: codec#1.txt                      
04-20-06 16:01 telles         Note Added: 0009393                          
04-20-06 16:04 telles         Note Edited: 0009393                         
06-03-06 03:56 MACHINE        Note Added: 0010060                          
06-17-06 23:52 maiquel        Issue Monitored: maiquel                     
06-18-06 00:37 maiquel        Note Added: 0010294                          
06-18-06 00:38 maiquel        File Added: test-2038.wav                    
06-29-06 23:55 maiquel        Note Edited: 0010294                         
07-20-06 15:36 maiquel        Note Added: 0011126                          
07-25-06 13:43 lorenzodp      Note Added: 0011227                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
