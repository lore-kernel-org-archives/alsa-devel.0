From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: [PATCH] driver/pci/asihpi.c fix segfault ASI87xx
Date: Tue, 8 Feb 2005 13:50:28 +1300
Message-ID: <200502081350.28474.linux@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received: from mta202-rme.xtra.co.nz (mta202-rme.xtra.co.nz [210.86.15.145])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9DC7E22A
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2005 01:50:39 +0100 (MET)
Received: from pop1-rme.xtra.co.nz ([210.86.15.240])
          by mta202-rme.xtra.co.nz with ESMTP
          id <20050208005032.LXLD28243.mta202-rme.xtra.co.nz@pop1-rme.xtra.co.nz>
          for <alsa-devel@alsa-project.org>; Tue, 8 Feb 2005 13:50:32 +1300
Received: from blennerhassett.gen.nz ([222.152.174.117])
          by pop1-rme.xtra.co.nz with ESMTP
          id <20050208005031.UTAV7985.pop1-rme.xtra.co.nz@blennerhassett.gen.nz>
          for <alsa-devel@alsa-project.org>; Tue, 8 Feb 2005 13:50:31 +1300
Content-Disposition: inline
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

Sampleclock control was assumed to exist, actually doesn't in some adapters.
Add error return checks so use of invalid return value doesn't result 
(sometimes) in segfault.

--- ../../alsa-driver-1.0.8_clean/pci/asihpi.c  2004-09-23 03:29:17.000000000 
+1200
+++ asihpi.c    2005-02-07 16:56:12.000000000 +1300
@@ -1568,8 +1568,8 @@
        snd_card_asihpi_t *asihpi = entry->private_data;
        HW16 wVersion;
        HPI_HCONTROL hControl;
-       HW32 dwRate;
-       HW16 wSource;
+       HW32 dwRate=0;
+       HW16 wSource=0;
        int err;

        snd_iprintf(buffer, "ASIHPI driver proc file\n");
@@ -1580,7 +1580,7 @@

        wVersion = asihpi->wVersion;
        snd_iprintf(buffer,
-                   "S/N=%ld\nHw Version %c%d\nDSP code version %03d\n",
+                   "Serial#=%ld\nHw Version %c%d\nDSP code version %03d\n",
                    asihpi->dwSerialNumber, ((wVersion >> 3) & 0xf) + 'A',
                    wVersion & 0x7,
                    ((wVersion >> 13) * 100) + ((wVersion >> 7) & 0x3f));
@@ -1589,10 +1589,13 @@
                                  HPI_SOURCENODE_CLOCK_SOURCE, 0, 0, 0,
                                  HPI_CONTROL_SAMPLECLOCK, &hControl);

-       err = HPI_SampleClock_GetSampleRate(phSubSys, hControl, &dwRate);
-       err = HPI_SampleClock_GetSource(phSubSys, hControl, &wSource);
-       snd_iprintf(buffer, "SampleClock=%ldHz, source %s\n", dwRate,
-                   sampleclock_sources[wSource]);
+       if (!err) {
+                       err = HPI_SampleClock_GetSampleRate(phSubSys, 
hControl, &dwRate);
+                       err = HPI_SampleClock_GetSource(phSubSys, hControl, 
&wSource);
+                       snd_iprintf(buffer, "SampleClock=%ldHz, source %s\n", 
dwRate,
+                                               sampleclock_sources[wSource]);
+       }
+
 }


@@ -1671,8 +1674,8 @@
                                  HPI_SOURCENODE_CLOCK_SOURCE, 0, 0, 0,
                                  HPI_CONTROL_SAMPLECLOCK, &hControl);

-       err =
-           HPI_SampleClock_SetSampleRate(phSubSys, hControl, adapter_fs);
+       if (!err)
+                       err = HPI_SampleClock_SetSampleRate(phSubSys, 
hControl, adapter_fs);

        snd_asihpi_proc_init(asihpi);



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
