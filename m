From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000568]: cmipci mpu401 based midi device node not created
Date: Tue, 9 Nov 2004 16:43:00 +0100
Message-ID: <938ab1cfabadd55bbfee9abc6787d662@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E04271CE
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:43:00 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=568> 
======================================================================
Reported By:                ChrisWhite
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   568
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.4-gentoo
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             10-06-2004 00:12 CEST
Last Modified:              11-09-2004 16:43 CET
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
 tiwai - 10-06-04 11:12 
----------------------------------------------------------------------
You passed a wrong module option.
Pass mpu_port with the appropriate I/O port address.

See alsa-kernel/Documentation/ALSA-Configuration.txt.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-06-04 00:12 ChrisWhite     New Issue                                    
10-06-04 00:12 ChrisWhite     File Added: modules.conf                     
10-06-04 00:12 ChrisWhite     Distribution              => Gentoo          
10-06-04 00:12 ChrisWhite     Kernel Version            => 2.6.4-gentoo    
10-06-04 00:13 ChrisWhite     Issue Monitored: ChrisWhite                    
10-06-04 11:12 tiwai          Status                   assigned => resolved
10-06-04 11:12 tiwai          Resolution               open => not an issue
10-06-04 11:12 tiwai          Note Added: 0002017                          
11-09-04 16:43 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
