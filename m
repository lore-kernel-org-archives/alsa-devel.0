From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 4/8] ALSA: hdspm - Fix DS/QS output channel
	mappings on RME MADI/MADIface
Date: Wed, 23 Feb 2011 11:43:11 +0100
Message-ID: <1298457795-28114-5-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, Florian Faber <faber@faberman.de>, Fredrik Lingvall <fredrik.lingvall@gmail.com>
List-Id: alsa-devel@alsa-project.org

Caused by two typos, no output channel mappings were assigned for
MADI/MADIface at double/quad speed.

The channel mapping is indeed identical to the single speed mapping, the
cards will simply use the first N channels.

Signed-off-by: Florian Faber <faber@faberman.de>
Signed-off-by: Fredrik Lingvall <fredrik.lingvall@gmail.com>
Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 17939b9..7246302 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6462,9 +6462,9 @@ static int __devinit snd_hdspm_create(struct snd_card *card,
 
 		hdspm->channel_map_in_ss = hdspm->channel_map_out_ss =
 			channel_map_unity_ss;
-		hdspm->channel_map_in_ds = hdspm->channel_map_out_ss =
+		hdspm->channel_map_in_ds = hdspm->channel_map_out_ds =
 			channel_map_unity_ss;
-		hdspm->channel_map_in_qs = hdspm->channel_map_out_ss =
+		hdspm->channel_map_in_qs = hdspm->channel_map_out_qs =
 			channel_map_unity_ss;
 
 		hdspm->port_names_in_ss = hdspm->port_names_out_ss =
-- 
1.7.2.3
