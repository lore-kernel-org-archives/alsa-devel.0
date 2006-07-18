From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000402]: No Wavetable-MIDI with
	snd-emu10k1 compiled static in kernel
Date: Tue, 18 Jul 2006 20:25:52 +0200
Message-ID: <9c1fcefe7287ef530dea79228a43a541@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 89AB71A7
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 20:25:52 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=402> 
======================================================================
Reported By:                frankpoole
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   402
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-21-2004 21:13 CEST
Last Modified:              07-18-2006 20:25 CEST
======================================================================
Summary:                    No Wavetable-MIDI with snd-emu10k1 compiled static
in kernel
Description: 
ALSA does not detect the Wavetable capabilities of the card (tested on SB
Live 5.1 and Audigy2) when loading snd-emu10k1-synth with snd-emu10k1
built inside the kernel. I'm forced to build everything as modules to get
it working.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-21-04 21:13 frankpoole     New Issue                                    
07-21-04 21:13 frankpoole     Kernel Version            => 2.6.7           
07-21-04 21:17 frankpoole     Note Added: 0001464                          
07-21-04 21:18 frankpoole     Note Deleted: 0001464                        
07-21-04 21:19 frankpoole     Issue Monitored: frankpoole                    
03-29-06 17:40 perex          Note Added: 0008993                          
03-29-06 17:40 perex          Note Deleted: 0008993                        
07-18-06 20:20 pzad           Assigned To              pzad =>             
07-18-06 20:25 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
