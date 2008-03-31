From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] es1968: fix jitter on some maestro cards
Date: Tue, 01 Apr 2008 00:24:43 +0200
Message-ID: <47F164AB.5040009@keyaccess.nl>
References: <20080329234943.GA2899@slappy>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010102030003060405030903"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id CF9F524846
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Apr 2008 00:22:57 +0200 (CEST)
In-Reply-To: <20080329234943.GA2899@slappy>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andreas Mueller <andreas@stapelspeicher.org>
Cc: tiwai@suse.de, ALSA devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, MatzeBraun@gmx.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010102030003060405030903
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 30-03-08 00:49, Andreas Mueller wrote:

> This patch suppresses jitter on several Maestro cards in stereo mode
> (ALSA of course).
> 
> The patch is also incorporated in the *BSD drivers where I "ported" it from.
> I am barely used to driver-development so please take a look (esp. the channel
> parameters), nevertheless it completely works for me.
> 
> Without this patch most of the stereo audio gets out of sync and really
> distorted (oss-emulation with mplayer at 48000khz worked somehow).
> 
> CCed to those listed in the .c file.

Added the alsa-devel list (and re-attached the patch). My TerraTec DMX (ESS 
Canyon3D, ES1970MS-3D) doesn't need this but doesn't seem to suffer from it 
either. Otherwise no idea about this.

Rene.

--------------010102030003060405030903
Content-Type: text/plain;
 name="es1968_jitter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="es1968_jitter.patch"

--- sound/pci/es1968.c.old	2008-03-29 19:17:16.771116317 +0100
+++ sound/pci/es1968.c	2008-03-30 00:14:35.363057160 +0100
@@ -1816,7 +1816,24 @@
 
 	return 0;
 }
+/*
+ * suppress jitter on some maestros when playing stereo
+ */
+static void snd_es1968_suppress_jitter(struct es1968 *chip, struct esschan *es)
+{
+	unsigned int cp1;
+	unsigned int cp2;
+	unsigned int diff;
 
+	cp1 = __apu_get_register(chip, 0, 5);
+	cp2 = __apu_get_register(chip, 1, 5);
+	diff = (cp1 > cp2 ? cp1 - cp2 : cp2 - cp1);
+	
+	if (diff > 1) {
+		__maestro_write(chip, IDR0_DATA_PORT, cp1);
+	}
+}
+	
 /*
  * update pointer
  */
@@ -1937,8 +1954,11 @@
 		struct esschan *es;
 		spin_lock(&chip->substream_lock);
 		list_for_each_entry(es, &chip->substream_list, list) {
-			if (es->running)
+			if (es->running) {
 				snd_es1968_update_pcm(chip, es);
+				if (es->fmt & ESS_FMT_STEREO)
+					snd_es1968_suppress_jitter(chip, es);
+			}
 		}
 		spin_unlock(&chip->substream_lock);
 		if (chip->in_measurement) {

--------------010102030003060405030903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010102030003060405030903--
