From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000568]: cmipci mpu401 based midi device node not created
Date: Wed,  6 Oct 2004 11:12:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041006091255.E49CAE05E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6473F2B6
	for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2004 11:12:56 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000568
======================================================================
Reported By:                ChrisWhite
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     568
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.4-gentoo
Resolution:                 not a bug
======================================================================
Date Submitted:             10-06-2004 00:12 CEST
Last Modified:              10-06-2004 11:12 CEST
======================================================================
Summary:                    cmipci mpu401 based midi device node not created
Description: 
I have the following modules loaded for alsa:

snd_pcm_oss            47912  0
snd_mixer_oss          17920  1 snd_pcm_oss
snd_seq_midi            6560  0
snd_seq_midi_event      6272  1 snd_seq_midi
snd_opl3_synth         13828  0
snd_seq_instr           8192  1 snd_opl3_synth
snd_seq_midi_emul       6912  1 snd_opl3_synth
snd_seq                52624  5
snd_seq_midi,snd_seq_midi_event,snd_opl3_synth,snd_seq_instr,snd_seq_midi_emul
snd_ainstr_fm           2560  1 snd_opl3_synth
snd_cmipci             28164  0
snd_pcm                85384  2 snd_pcm_oss,snd_cmipci
snd_opl3_lib            9600  2 snd_opl3_synth,snd_cmipci
snd_timer              22276  3 snd_seq,snd_pcm,snd_opl3_lib
snd_hwdep               7812  1 snd_opl3_lib
snd_mpu401_uart         6400  1 snd_cmipci
snd_rawmidi            20644  2 snd_seq_midi,snd_mpu401_uart
snd_seq_device          6920  5
snd_seq_midi,snd_opl3_synth,snd_seq,snd_opl3_lib,snd_rawmidi
snd                    50436  15
snd_pcm_oss,snd_mixer_oss,snd_seq_midi,snd_seq_midi_event,snd_opl3_synth,snd_seq_instr,snd_seq,snd_cmipci,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
snd_page_alloc

and I cannot get a /dev/midi or /dev/sound/midi node in my dev filesystem.
 Having the snd_mpu401_uart module loaded, I'd think the node would be
created once the connection was made.  The current setup is a Radio Shack
keyboard set under MIDI channel 1 and connected by a MPU401->5 DIN MIDI
adapter.  I've verified the connections and nothing is wrong.  I've setup
my card by the cmipci guide provided in the docs.  modules.conf is
attached with the relevant parts shown.
======================================================================

----------------------------------------------------------------------
 tiwai - 10-06-2004 11:12 CEST 
----------------------------------------------------------------------
You passed a wrong module option.
Pass mpu_port with the appropriate I/O port address.

See alsa-kernel/Documentation/ALSA-Configuration.txt.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-06-04 00:12 ChrisWhite     New Bug                                      
10-06-04 00:12 ChrisWhite     File Added: modules.conf                     
10-06-04 00:12 ChrisWhite     Distribution              => Gentoo          
10-06-04 00:12 ChrisWhite     Kernel Version            => 2.6.4-gentoo    
10-06-04 00:13 ChrisWhite     Bug Monitored: ChrisWhite                    
10-06-04 11:12 tiwai          Bugnote Added: 0002017                       
10-06-04 11:12 tiwai          Resolution               open => not a bug   
10-06-04 11:12 tiwai          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
