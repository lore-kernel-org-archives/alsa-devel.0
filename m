From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Asus Eeepc missing in alsa models list?
Date: Tue, 16 Oct 2007 16:35:34 -0200
Message-ID: <200710161635.35861.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B3F82449F
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Oct 2007 20:35:47 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Looking at the change 291702f017efdfe556cb87b8530eb7d1ff08cbae, may be the 
addition of the Asus Eeepc model was missed? The following patch fixes it if 
it was not intended originally:

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt 
b/Documentation/sound/alsa/ALSA-Configuration.txt
index 4b48c2e..e2a1985 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -843,6 +843,7 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. 
This was removed.
 	  3stack-6ch-dig 3-stack (6-channel) with SPDIF
 	  6stack-dig	 6-stack with SPDIF
 	  lenovo-101e	 Lenovo laptop
+	  eeepc-p701	 ASUS Eeepc
 	  auto		auto-config reading BIOS (default)
 
 	ALC882/885
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 53b0428..2ceaf4c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -12058,6 +12058,7 @@ static const char *alc662_models[ALC662_MODEL_LAST] = 
{
 	[ALC662_3ST_6ch]	= "3stack-6ch",
 	[ALC662_5ST_DIG]	= "6stack-dig",
 	[ALC662_LENOVO_101E]	= "lenovo-101e",
+	[ALC662_ASUS_EEEPC_P701]	= "eeepc-p701",
 	[ALC662_AUTO]		= "auto",
 };
 
-- 
[]'s
Herton
