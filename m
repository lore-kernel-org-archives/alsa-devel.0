From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001019]: Unresolved symbols for snd-seq-oss.o on gentoo with a kernel 2.4.29
Date: Fri, 30 Dec 2005 05:21:53 +0100
Message-ID: <2322d163522ab837d5efa4ee06ed23c9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 181CDEB
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 05:21:54 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1019> 
======================================================================
Reported By:                Alinoe
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1019
Category:                   CORE OSS - sequencer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.4.29 with grsecurity (but grsecurity doesn't
matter in this case ;p)
======================================================================
Date Submitted:             03-27-2005 11:47 CEST
Last Modified:              12-30-2005 05:21 CET
======================================================================
Summary:                    Unresolved symbols for snd-seq-oss.o on gentoo with
a kernel 2.4.29
Description: 
# /etc/init.d/alsasound restart
 * WARNING:  you are stopping a boot service.
 * Storing ALSA Mixer Levels...                                           
                                           [ ok ]
 * Unloading ALSA...                                                      
                                           [ ok ]
 * Unloading ALSA modules...                                              
                                           [ ok ]
 * Loading ALSA modules...
 *   Loading: snd-card-0...                                               
                                           [ ok ]
 *   Loading: snd-mixer-oss...                                            
                                           [ ok ]
 *   Loading: snd-pcm-oss...                                              
                                           [ ok ]
 *   Loading: snd-seq-oss...
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o:
init_module: Device or resource busy
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o: insmod
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o failed
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o: insmod
snd-seq-oss failed                         [ !! ]

 *   Loading: snd-seq...                                                  
                                           [ ok ]
 * Restoring Mixer Levels...                                              
                                           [ ok ]


Damn WTF?! :-)

# dmesg [...]
ALSA mixer_oss.c:1260: unable to register OSS mixer device 0:0
ALSA pcm_oss.c:2436: unable to register OSS PCM device 0:0
ALSA seq_oss.c:236: can't register device seq

My mistake? :-/

# insmod
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o:
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o:
unresolved symbol snd_midi_event_no_status_R5c9c7f86
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o:
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o:
unresolved symbol snd_midi_event_free_R9cf69370
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o:
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o:
unresolved symbol snd_midi_event_encode_byte_Rea2835af
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o:
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o:
unresolved symbol snd_midi_event_decode_R7a1ad7c0
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o:
/lib/modules/2.4.29-grsec/kernel/sound/acore/seq/oss/snd-seq-oss.o:
unresolved symbol snd_midi_event_new_R1e92e146

Urgh no :-/

======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 05:21 
----------------------------------------------------------------------
Were you ever able to get this to work?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-27-05 11:47 Alinoe         New Issue                                    
03-27-05 11:47 Alinoe         Kernel Version            => 2.4.29 with
grsecurity (but grsecurity doesn't matter in this case ;p)
03-28-05 01:29 Alinoe         Issue Monitored: Alinoe                      
12-30-05 05:21 rlrevell       Note Added: 0007242                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
