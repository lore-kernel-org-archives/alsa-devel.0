From: noreply@alsa-project.org
Subject: [ALSA - driver 0000402]: No Wavetable-MIDI with snd-emu10k1 compiled static in kernel
Date: Wed, 21 Jul 2004 21:17:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040721191753.1F7822F002@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6ECEC259
	for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2004 21:17:53 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000402
======================================================================
Reported By:                frankpoole
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     402
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-21-2004 21:13 CEST
Last Modified:              07-21-2004 21:17 CEST
======================================================================
Summary:                    No Wavetable-MIDI with snd-emu10k1 compiled static in kernel
Description: 
ALSA does not detect the Wavetable capabilities of the card (tested on SB
Live 5.1 and Audigy2) when loading snd-emu10k1-synth with snd-emu10k1
built inside the kernel. I'm forced to build everything as modules to get
it working.
======================================================================

----------------------------------------------------------------------
 frankpoole - 07-21-2004 21:17 CEST 
----------------------------------------------------------------------
This is how I want to build the sound support:

CONFIG_SOUND=y

CONFIG_SND=y                                                              
        
CONFIG_SND_TIMER=y                                                        
        
CONFIG_SND_PCM=y                                                          
        
CONFIG_SND_HWDEP=y                                                        
        
CONFIG_SND_RAWMIDI=y                                                      
        
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y                                                      
        
CONFIG_SND_MIXER_OSS=m                                                    
        
CONFIG_SND_PCM_OSS=m                                                      
        
CONFIG_SND_SEQUENCER_OSS=y

CONFIG_SND_AC97_CODEC=y
CONFIG_SND_EMU10K1=y

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-21-04 21:13 frankpoole     New Bug                                      
07-21-04 21:13 frankpoole     Kernel Version            => 2.6.7           
07-21-04 21:17 frankpoole     Bugnote Added: 0001464                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
