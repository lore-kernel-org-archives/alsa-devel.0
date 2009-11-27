From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opti-miro: fix OOPS if hardware is not detected
Date: Fri, 27 Nov 2009 11:20:56 +0100
Message-ID: <20091127112056.828e6bf7.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0369710659759840558=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 40A701038E1
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 11:19:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--===============0369710659759840558==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

If a hardware is not detected there is a kernel crash
due to not initialized snd_miro->aci pointer. This pointer
is initialized after detection of the opti (miro) chip.

This bug was introduced by patches to expose
ACI mikser outside the snd-miro driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

 sound/isa/opti9xx/miro.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 40b64cd..e374869 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -1229,7 +1229,8 @@ static void snd_card_miro_free(struct snd_card *card)
 	struct snd_miro *miro = card->private_data;
         
 	release_and_free_resource(miro->res_aci_port);
-	miro->aci->aci_port = 0;
+	if (miro->aci)
+		miro->aci->aci_port = 0;
 	release_and_free_resource(miro->res_mc_base);
 }
 
-- 
1.6.4


----------------------------------------------------------------------
Wygraj pobyt w Alpach dla ca³ej rodziny
Kliknij >>> http://link.interia.pl/f2446


--===============0369710659759840558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0369710659759840558==--
