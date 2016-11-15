From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: intel: mfld: Make static string arrays
	'const 'char * const []'
Date: Tue, 15 Nov 2016 21:40:45 +0100
Message-ID: <1479242445-12069-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 41E4D26723F
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 21:40:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

const char * const [] is the preferred type for static string arrays since
this states explicitly that the individual entries are not going to be
changed. Due to limitations in the ASoC API it was not possible to use it
for enum text arrays. Commit 87023ff74b23 ("ASoC: Declare const properly
for enum texts") changed this, but most drivers still use 'const char
* []' as the type for their enum text arrays.

Change these occurrences of 'static * const char * []' to 'static const
char * const []'.

The conversion was done automatically using the following coccinelle
semantic patch:
// <smpl>
@disable optional_qualifier@
identifier s;
@@
 static
-const char *
+const char * const
 s[] = ...;
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/intel/boards/mfld_machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
index 34f46c7..4e08885 100644
--- a/sound/soc/intel/boards/mfld_machine.c
+++ b/sound/soc/intel/boards/mfld_machine.c
@@ -81,9 +81,9 @@ static struct snd_soc_jack_zone mfld_zones[] = {
 };
 
 /* sound card controls */
-static const char *headset_switch_text[] = {"Earpiece", "Headset"};
+static const char * const headset_switch_text[] = {"Earpiece", "Headset"};
 
-static const char *lo_text[] = {"Vibra", "Headset", "IHF", "None"};
+static const char * const lo_text[] = {"Vibra", "Headset", "IHF", "None"};
 
 static const struct soc_enum headset_enum =
 	SOC_ENUM_SINGLE_EXT(2, headset_switch_text);
-- 
2.1.4
