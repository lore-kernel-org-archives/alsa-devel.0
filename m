From: Marcel Holtmann <marcel@holtmann.org>
Subject: Hardware interface constant for Bluetooth
Date: Mon, 08 Nov 2004 02:24:10 +0100
Message-ID: <1099877050.6896.70.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Hi guys,

I like to drive the Bluetooth audio support a little bit and it would be
great if you can add a hardware interface constant for us. I don't know
what is the correct procedure to do it, but from my first analysis it
seems that it is enough to add a patch like the one below to the kernel
code and the library code. Everything else can be developed outside the
ALSA core.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

===== include/sound/asound.h 1.30 vs edited =====
--- 1.30/include/sound/asound.h 2004-09-03 11:08:15 +02:00
+++ edited/include/sound/asound.h       2004-11-08 02:12:44 +01:00
@@ -110,9 +110,10 @@
        SNDRV_HWDEP_IFACE_MIXART,       /* Digigram miXart cards */
        SNDRV_HWDEP_IFACE_USX2Y,        /* Tascam US122, US224 & US428 usb */
        SNDRV_HWDEP_IFACE_EMUX_WAVETABLE, /* EmuX wavetable */
+       SNDRV_HWDEP_IFACE_BLUETOOTH,    /* Bluetooth audio */
 
        /* Don't forget to change the following: */
-       SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_EMUX_WAVETABLE,
+       SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_BLUETOOTH,
 };
 
 struct sndrv_hwdep_info {

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
