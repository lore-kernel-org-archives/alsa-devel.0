From: noreply@alsa-project.org
Subject: [ALSA - driver 0000182]: Missing raw midi device in 1.0.x, working with 0.9.8
Date: Fri, 16 Jul 2004 12:58:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105831.3375226008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 659A1244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:58:31 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000182
======================================================================
Reported By:                pigeon
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     182
Category:                   CORE - rawmidi
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.4.24
======================================================================
Date Submitted:             04-03-2004 15:04 CEST
Last Modified:              07-16-2004 12:58 CEST
======================================================================
Summary:                    Missing raw midi device in 1.0.x, working with 0.9.8
Description: 
I'm using a ymfpci sound card. Everything has been working well from 0.9.x
to 1.0.x. I didn't realize until today that the raw midi device is missing
with 1.0.x. "8: [0- 0]: raw midi" is missing from /proc/asound/devices.

As I know it used to work before, I kept downgrading the driver, until I
found it works with 0.9.8.

I turned on debugging with seq_oss_debug, and just a simple test by 'cat
/dev/sequencer'. With 0.9.8 (working), I get:

ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_midi.c:153: check for MIDI
client 0 port 0
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_midi.c:153: check for MIDI
client 0 port 1
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_midi.c:153: check for MIDI
client 64 port 0
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_midi.c:153: check for MIDI
client 65 port 0
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_midi.c:153: check for MIDI
client 65 port 1
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_synth.c:139: synth OPL3 FM
synth registered 0


And with 1.0.x, I get:
Apr  3 23:02:43 buu kernel: ALSA
../../../alsa-kernel/core/seq/oss/seq_oss_init.c:84: new client = 63
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_midi.c:153: check for MIDI
client 0 port 0                                                           
           ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_midi.c:153:
check for MIDI client 0 port 1                                            
                          ALSA
../../../alsa-kernel/core/seq/oss/seq_oss_init.c:189: oss_open: dp =
d3ddbc00                                                                  
           ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_init.c:213: no
device found


======================================================================

----------------------------------------------------------------------
 pigeon - 04-09-2004 16:09 CEST 
----------------------------------------------------------------------
I did a diff between 0.9.8 and 1.0.0pre1 for ymfpci.c
Except the stuff added for the joystick, I tried reverting those in 1.0.4
to 0.9.8, all the changes are like:

-               if (fm_port[dev] <= 0) {
+               if (fm_port[dev] == 1) {
+                       /* auto-detect */

-               if (mpu_port[dev] <= 0) {
+               if (mpu_port[dev] == 1) {
+                       /* auto-detect */

-               default: fm_port[dev] = -1; break;
+               default: fm_port[dev] = 0; break;

-                       fm_port[dev] = -1;
+                       fm_port[dev] = 0;


etc etc, and it works.

----------------------------------------------------------------------
 tiwai - 04-13-2004 19:37 CEST 
----------------------------------------------------------------------
MIDI is disabled as default on YMFPCI (see ALSA-Configuration.txt).

you can enable it by passing a proper I/O port address to
mpu_port module option (or 1 if it's YMF744/754).

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-03-04 15:04 pigeon         New Bug                                      
04-03-04 15:04 pigeon         Kernel Version            => 2.4.24          
04-04-04 04:19 pigeon         Bug Monitored: pigeon                        
04-09-04 16:09 pigeon         Bugnote Added: 0000776                       
04-13-04 19:37 tiwai          Bugnote Added: 0000792                       
04-13-04 19:37 tiwai          Assigned To               => tiwai           
04-13-04 19:37 tiwai          Resolution               open => not a bug   
04-13-04 19:37 tiwai          Status                   new => resolved     
07-16-04 12:58 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
