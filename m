From: Arnaud Patard <rtp@rtp-net.org>
Subject: [PATCH] cs4281 DLLRDY
Date: Sat, 07 May 2005 17:38:52 +0200
Message-ID: <85sm0zhwqb.fsf@Orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

--=-=-=

Hi,

I've recently played with my old laptop shipped with a cs4281
chipset. Sometimes, I was getting the following message when loading the
snd-cs4281 module:

May  7 11:38:20 rtp kernel: ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 5
(level, low) -> IRQ 5
May  7 11:38:20 rtp kernel: DLLRDY not seen
May  7 11:38:20 rtp kernel: CS4281: probe of 0000:00:08.0 failed with
error -5


After giving a quick glance at the datasheet from ftp.alsa-project.org,
I found that the fpdn bit of the eppmc register was set. After unsetting
this bit, the problem disappeared and the card was working.

The attached patch test if this bit is set and unset it in that case. 

Regards,
Arnaud Patard


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=cs4281_fpdn.patch


Reset the FPDN bit of the EPPMC register if needed

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---

 cs4281.c |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -puN sound/pci/cs4281.c~fpdn sound/pci/cs4281.c
--- linux/sound/pci/cs4281.c~fpdn	2005-02-06 12:45:45.000000000 +0100
+++ linux/sound/pci/cs4281.c	2005-05-07 16:56:17.000000000 +0200
@@ -206,7 +206,10 @@ MODULE_PARM_DESC(dual_codec, "Secondary 
 
 #define BA0_PMCS		0x0344	/* Power Management Control/Status */
 #define BA0_CWPR		0x03e0	/* Configuration Write Protect */
+
 #define BA0_EPPMC		0x03e4	/* Extended PCI Power Management Control */
+#define BA0_EPPMC_FPDN		(1<<14) /* Full Power DowN */
+
 #define BA0_GPIOR		0x03e8	/* GPIO Pin Interface Register */
 
 #define BA0_SPMC		0x03ec	/* Serial Port Power Management Control (& ASDIN2 enable) */
@@ -1460,6 +1463,11 @@ static int snd_cs4281_chip_init(cs4281_t
 	int timeout;
 	int retry_count = 2;
 
+	/* Having EPPMC.FPDN=1 prevent proper chip initialisation */
+	tmp = snd_cs4281_peekBA0(chip, BA0_EPPMC);
+	if ( tmp & BA0_EPPMC_FPDN)
+		snd_cs4281_pokeBA0(chip, BA0_EPPMC, tmp & ~BA0_EPPMC_FPDN);
+
       __retry:
 	tmp = snd_cs4281_peekBA0(chip, BA0_CFLR);
 	if (tmp != BA0_CFLR_DEFAULT) {

--=-=-=--



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
