From: Dick Streefland <dick@streefland.net>
Subject: [PATCH] enable ac97_quirk hp_only for Acer Aspire 3003LCi
Date: Fri, 7 Oct 2005 10:23:45 +0200
Message-ID: <20051007082345.GA1735@marvin.de.bilt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

On my Acer Aspire 3003LCi laptop, the speaker volume is not controlled
by the master control, but by the headphone control. Enabling the
"hp_only" quirk corrects this. The patch below adds this device to the
list of known quirks.

Signed-off-by: Dick Streefland <dick@streefland.net>

--- linux-2.6.13.2/sound/pci/intel8x0.c.orig	2005-09-29 21:44:46.000000000 +0200
+++ linux-2.6.13.2/sound/pci/intel8x0.c	2005-10-06 02:06:58.000000000 +0200
@@ -1750,6 +1750,12 @@ static struct ac97_quirk ac97_quirks[] _
 		.type = AC97_TUNE_ALC_JACK
 	},
 	{
+		.subvendor = 0x1025,
+		.subdevice = 0x0083,
+		.name = "Acer Aspire 3003LCi",
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
 		.subvendor = 0x1028,
 		.subdevice = 0x00d8,
 		.name = "Dell Precision 530",	/* AD1885 */


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
