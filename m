From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002016]: Choppy/skippy sound on
	onboard SiS SI7012-controller
Date: Tue, 30 May 2006 10:40:35 +0200
Message-ID: <c135bea69e266fd677ab866ea7bb92e0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E47CD129
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 10:40:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2016> 
======================================================================
Reported By:                Ensnared
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2016
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10 "Breezy Badger"
Kernel Version:             2.6.x
======================================================================
Date Submitted:             04-12-2006 04:40 CEST
Last Modified:              05-30-2006 10:40 CEST
======================================================================
Summary:                    Choppy/skippy sound on onboard SiS SI7012-controller
Description: 
The sound on my specific sound controller is very bad. The times it even
plays, the quality is very choppy and it skips almost like a scratched CD,
which makes it pretty much unusable.

I suspect this might be specific for my model laptop as I'm having a hard
time finding anyone else with the same problem, but I've tried several
distros and kernel versions, and the card works in Windows.

The laptop is an Elite Group G732, which has a SiS mainboard chipset with
the SI7012 onboard controller (Realtek ALC202 chip).

I've tried messing with the buffer_size and period_size in asound.conf,
which seem to have some impact on the "pattern" of the chopping and
skipping, but there are no values that I've found that will get rid of
them entirely.

I'm assuming this is an incompatibility with the driver and this specific
hardware, but I could obviously be wrong.

I've tried using the version of ALSA in the 2.6.10, 2.6.12 and 2.6.16.2
kernels, as well as compiled the latest stable and developement releases
of ALSA myself. The result is the same for them all.
======================================================================

----------------------------------------------------------------------
 Ensnared - 05-15-06 00:29 
----------------------------------------------------------------------
Just installed Alsa 1.0.11 and there's no change, same problem as already
described.

Is there some kind of obscure module parameter that can have some impact?
I've tried buggy_irq=1, ac97_quirk=1 and buggy_semaphore=1, neither of
which helped at all - buggy_semaphore made the driver not work at all, but
other than that there was no difference.



----------------------------------------------------------------------
 razorbroom - 05-30-06 10:40 
----------------------------------------------------------------------
I've been using 1.0.11 as well.  Tried configuring a new kernel from
scratch just in case I had some bizarre option checked.  Same problems. 
Turned off ACPI and APM in the kernel and still have the same symptoms
although the error messages are a bit different:

ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -450, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -1110, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -537, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -550, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -536, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -1095, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -552, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -1110, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -538, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -538, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -565, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream =
0, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?

After much googling I read that high deltas are usually indicative of ACPI
errors... but this is when it's turned off.  So I'm at a loss once since
nobody has even denied this being an ALSA problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-06 04:40 Ensnared       New Issue                                    
04-12-06 04:40 Ensnared       Distribution              => Ubuntu 5.10 "Breezy
Badger"
04-12-06 04:40 Ensnared       Kernel Version            => 2.6.x           
04-12-06 06:57 razorbroom     Note Added: 0009239                          
04-13-06 21:47 Ensnared       Note Added: 0009271                          
04-13-06 22:06 Ensnared       Note Added: 0009276                          
04-23-06 06:31 razorbroom     Note Added: 0009440                          
04-23-06 06:32 razorbroom     Issue Monitored: razorbroom                    
04-27-06 22:04 Ensnared       Note Added: 0009536                          
05-15-06 00:07 Ensnared       Note Added: 0009811                          
05-15-06 00:29 Ensnared       Note Edited: 0009811                         
05-30-06 10:40 razorbroom     Note Added: 0010018                          
======================================================================
