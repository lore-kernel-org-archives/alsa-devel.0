From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: Re: [PATCH] driver/pci/asihpi.c fix segfault ASI87xx
Date: Wed, 9 Feb 2005 09:56:11 +1300
Message-ID: <200502090956.11703.linux@blennerhassett.gen.nz>
References: <200502081350.28474.linux@blennerhassett.gen.nz> <s5hmzueu6ze.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rdSCChyI9mquLg1"
In-Reply-To: <s5hmzueu6ze.wl@alsa2.suse.de>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_rdSCChyI9mquLg1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 09 Feb 2005 09:33, Takashi Iwai wrote:
> Hi Eliot,
>
> At Tue, 8 Feb 2005 13:50:28 +1300,
>
> Eliot Blennerhassett wrote:
> > Sampleclock control was assumed to exist, actually doesn't in some
> > adapters. Add error return checks so use of invalid return value doesn't
> > result (sometimes) in segfault.
>
> Looks like your mailer broke the patch.

Oops. Thanks for letting me know.

> Please attach the patch instead of pasting.

here 

> Also, don't forget to give "Signed-off-by" for changelog.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

OK this time I hope

-- Eliot

--Boundary-00=_rdSCChyI9mquLg1
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="asihpi_sclock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="asihpi_sclock.patch"

--- ../../alsa-driver-1.0.8_clean/pci/asihpi.c	2004-09-23 03:29:17.000000000 +1200
+++ asihpi.c	2005-02-08 13:44:18.000000000 +1300
@@ -1568,8 +1568,8 @@
 	snd_card_asihpi_t *asihpi = entry->private_data;
 	HW16 wVersion;
 	HPI_HCONTROL hControl;
-	HW32 dwRate;
-	HW16 wSource;
+	HW32 dwRate=0;
+	HW16 wSource=0;
 	int err;
 
 	snd_iprintf(buffer, "ASIHPI driver proc file\n");
@@ -1580,7 +1580,7 @@
 
 	wVersion = asihpi->wVersion;
 	snd_iprintf(buffer,
-		    "S/N=%ld\nHw Version %c%d\nDSP code version %03d\n",
+		    "Serial#=%ld\nHw Version %c%d\nDSP code version %03d\n",
 		    asihpi->dwSerialNumber, ((wVersion >> 3) & 0xf) + 'A',
 		    wVersion & 0x7,
 		    ((wVersion >> 13) * 100) + ((wVersion >> 7) & 0x3f));
@@ -1589,10 +1589,15 @@
 				  HPI_SOURCENODE_CLOCK_SOURCE, 0, 0, 0,
 				  HPI_CONTROL_SAMPLECLOCK, &hControl);
 
-	err = HPI_SampleClock_GetSampleRate(phSubSys, hControl, &dwRate);
-	err = HPI_SampleClock_GetSource(phSubSys, hControl, &wSource);
-	snd_iprintf(buffer, "SampleClock=%ldHz, source %s\n", dwRate,
-		    sampleclock_sources[wSource]);
+	if (!err) {
+			err = HPI_SampleClock_GetSampleRate(phSubSys, hControl, &dwRate);
+			err += HPI_SampleClock_GetSource(phSubSys, hControl, &wSource);
+
+			if (!err)
+					snd_iprintf(buffer, "SampleClock=%ldHz, source %s\n", dwRate,
+								sampleclock_sources[wSource]);
+	} 
+
 }
 
 
@@ -1671,8 +1676,8 @@
 				  HPI_SOURCENODE_CLOCK_SOURCE, 0, 0, 0,
 				  HPI_CONTROL_SAMPLECLOCK, &hControl);
 
-	err =
-	    HPI_SampleClock_SetSampleRate(phSubSys, hControl, adapter_fs);
+	if (!err)
+			err = HPI_SampleClock_SetSampleRate(phSubSys, hControl, adapter_fs);
 
 	snd_asihpi_proc_init(asihpi);
 

--Boundary-00=_rdSCChyI9mquLg1--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
