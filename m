From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000605]: memalloc.c:53 build error
Date: Wed, 27 Oct 2004 17:27:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1b538a04794d6b451c64efa7c1c90500@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1BF5B2AF
	for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2004 17:27:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=605> 
======================================================================
Reported By:                Andrew
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   605
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             10-26-2004 12:37 CEST
Last Modified:              10-27-2004 17:27 CEST
======================================================================
Summary:                    memalloc.c:53 build error
Description: 
GCC 3.3.4 is in use.
./cvscomile for current CVS tree shows:

make[1]: Entering directory `/usr/src/linux-2.6.9-gentoo-r1'
  CC [M]  /wrk/cvs/alsa/alsa-driver/kbuild/../acore/memalloc.o
/wrk/cvs/alsa/alsa-driver/acore/memalloc.c:53: error: invalid lvalue in
unary `&'
/wrk/cvs/alsa/alsa-driver/acore/memalloc.c:53: error: initializer element
is not constant
/wrk/cvs/alsa/alsa-driver/acore/memalloc.c:53: error: (near initialization
for `__param_arr_enable.num')
make[4]: *** [/wrk/cvs/alsa/alsa-driver/kbuild/../acore/memalloc.o] Error
1

======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 10-27-04 15:58 
----------------------------------------------------------------------
I get the same (compiling for vanilla 2.6.9 kernel with gcc 2.95.3).

I guess the latest module_param_array change isn't compatible with an old
kernel like this. :-)

----------------------------------------------------------------------
 lee - 10-27-04 17:27 
----------------------------------------------------------------------
Same error here.  If you want to work around it here's how I fixed my
tree:

Index: alsa-kernel/pci/emu10k1/emu10k1.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1.c,v
retrieving revision 1.28
diff -u -r1.28 emu10k1.c
--- alsa-kernel/pci/emu10k1/emu10k1.c   23 Oct 2004 16:10:27 -0000     
1.28
+++ alsa-kernel/pci/emu10k1/emu10k1.c   27 Oct 2004 15:25:33 -0000
@@ -48,24 +48,25 @@
 static int max_synth_voices[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] =
64};
 static int max_buffer_size[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] =
128};
 static int enable_ir[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 0};
+static int boot_devs;

-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, boot_devs, 0444);
 MODULE_PARM_DESC(index, "Index value for the EMU10K1 soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, boot_devs, 0444);
 MODULE_PARM_DESC(id, "ID string for the EMU10K1 soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, boot_devs, 0444);
 MODULE_PARM_DESC(enable, "Enable the EMU10K1 soundcard.");
-module_param_array(extin, int, NULL, 0444);
+module_param_array(extin, int, boot_devs, 0444);
 MODULE_PARM_DESC(extin, "Available external inputs for FX8010.
Zero=default.");
-module_param_array(extout, int, NULL, 0444);
+module_param_array(extout, int, boot_devs, 0444);
 MODULE_PARM_DESC(extout, "Available external outputs for FX8010.
Zero=default.");
-module_param_array(seq_ports, int, NULL, 0444);
+module_param_array(seq_ports, int, boot_devs, 0444);
 MODULE_PARM_DESC(seq_ports, "Allocated sequencer ports for internal
synthesizer.");
-module_param_array(max_synth_voices, int, NULL, 0444);
+module_param_array(max_synth_voices, int, boot_devs, 0444);
 MODULE_PARM_DESC(max_synth_voices, "Maximum number of voices for
WaveTable.");
-module_param_array(max_buffer_size, int, NULL, 0444);
+module_param_array(max_buffer_size, int, boot_devs, 0444);
 MODULE_PARM_DESC(max_buffer_size, "Maximum sample buffer size in MB.");
-module_param_array(enable_ir, bool, NULL, 0444);
+module_param_array(enable_ir, bool, boot_devs, 0444);
 MODULE_PARM_DESC(enable_ir, "Enable IR.");

 static struct pci_device_id snd_emu10k1_ids[] = {

This should be fixed according to the CVS log, maybe sourceforge CVS has
not updated yet.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-26-04 12:37 Andrew         New Issue                                    
10-27-04 15:58 Clemens LadischNote Added: 0002274                          
10-27-04 17:27 lee            Note Added: 0002276                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
