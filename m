From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001942]: [PATCH] added support uncommon "rate"
Date: Thu, 23 Mar 2006 18:30:21 +0100
Message-ID: <958fda19853a62e5fa4148ce62f92b10@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 98B661AD
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2006 18:30:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1942> 
======================================================================
Reported By:                os-bebas
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1942
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               UBuntu Dapper Drake
Kernel Version:             2.6.15.6
======================================================================
Date Submitted:             03-18-2006 23:48 CET
Last Modified:              03-23-2006 18:30 CET
======================================================================
Summary:                    [PATCH] added support uncommon "rate"
Description: 
attached you can find a simple patch to match
"uncommon" rate in some USB speaker to the fixed
conv_rates in usbaudio.c.

Signed-off-by: S. Effendi <osbebas@yahoo.co.id>

======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 03-20-06 09:09 
----------------------------------------------------------------------
Your patch assumes that every device that doesn't happen to support one of
the predefined rates is lying and actually does use the next-smaller rate
instead.
This assumptions is wrong for most devices, and probably for yours, too.

What is the output of "time dd if=/dev/zero of=/dev/dsp1 bs=1000
count=10000"?

----------------------------------------------------------------------
 os-bebas - 03-23-06 18:30 
----------------------------------------------------------------------
well, I assume that any USB conformed audio devices would support this:
---5.2.3.2.3 Endpoint Controls 
5.2.3.2.3.1 Sampling Frequency Control 
... The Sampling Frequency Control honors the request to the best of its
abilities. 
If the endpoint operates at a fixed sampling frequency, setting this
Control has no effect. 
If the endpoint supports a discrete number of sampling frequencies,
setting the tSampleFreq value to a non-supported value causes the Control
to round it to the closest available value. 
This also happens when the sampling frequency is set outside the range for
a continuous sampling frequency endpoint. It will report the rounded
setting when queried during a Get Control request.
---
as can be read in "Universal Serial Bus Device Class Definition for Audio
Devices" (http://www.usb.org/developers/devclass_docs/audio10.pdf)

If they don't, then they deserved to get "some quirks" support ;), and I'm
sure in most cases this patch will work. (Though I'ven't tested it with
other devices yet, since I don't have any others with "uncommon rates").

It's better for me to hear sounds as to get error message: "no supported
rate".

BTW. thanks to ALSA now I can enjoy nice music under Linux using USB
Speaker, which would have "forced" me to use the other OS ;)

Following some output from dd:
(since count=10000 would take long time, I skipped that.)

---
root@d1:~# time dd if=/dev/zero of=/dev/dsp1 bs=1000 count=1
1+0 records in
1+0 records out
1000 bytes (1.0 kB) copied, 0.530765 seconds, 1.9 kB/s

real    0m0.538s
user    0m0.004s
sys     0m0.004s
root@d1:~# time dd if=/dev/zero of=/dev/dsp1 bs=1000 count=10
10+0 records in
10+0 records out
10000 bytes (10 kB) copied, 1.54986 seconds, 6.5 kB/s

real    0m1.557s
user    0m0.003s
sys     0m0.006s
root@d1:~# time dd if=/dev/zero of=/dev/dsp1 bs=1000 count=100
100+0 records in
100+0 records out
100000 bytes (100 kB) copied, 12.7945 seconds, 7.8 kB/s

real    0m12.802s
user    0m0.005s
sys     0m0.018s
root@d1:~# time dd if=/dev/zero of=/dev/dsp1 bs=1000 count=1000
1000+0 records in
1000+0 records out
1000000 bytes (1.0 MB) copied, 125.263 seconds, 8.0 kB/s

real    2m5.279s
user    0m0.009s
sys     0m0.178s
---

best regards

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-18-06 23:48 os-bebas       New Issue                                    
03-18-06 23:48 os-bebas       File Added: alsa_usbaudio_conv_rates_fixed.patch  
                 
03-18-06 23:48 os-bebas       Distribution              => UBuntu Dapper Drake
03-18-06 23:48 os-bebas       Kernel Version            => 2.6.15.6        
03-20-06 09:09 Clemens LadischNote Added: 0008712                          
03-23-06 18:30 os-bebas       Note Added: 0008900                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
