From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 2/2] pcm: Add missing signed and
	endianess definitions for DSD formats
Date: Mon, 11 Aug 2014 11:57:16 +0200
Message-ID: <1407751036-14166-2-git-send-email-tiwai@suse.de>
References: <1407751036-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A423A2651BE
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 11:57:16 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 82955ACFF
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 09:57:16 +0000 (UTC)
In-Reply-To: <1407751036-14166-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_misc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/pcm/pcm_misc.c b/src/pcm/pcm_misc.c
index 44bb89cb0d44..24d52f910cb6 100644
--- a/src/pcm/pcm_misc.c
+++ b/src/pcm/pcm_misc.c
@@ -62,6 +62,8 @@ int snd_pcm_format_signed(snd_pcm_format_t format)
 	case SNDRV_PCM_FORMAT_U20_3BE:
 	case SNDRV_PCM_FORMAT_U18_3LE:
 	case SNDRV_PCM_FORMAT_U18_3BE:
+	case SNDRV_PCM_FORMAT_DSD_U8:
+	case SNDRV_PCM_FORMAT_DSD_U16_LE:
 		return 0;
 	default:
 		return -EINVAL;
@@ -150,6 +152,8 @@ int snd_pcm_format_little_endian(snd_pcm_format_t format)
 	case SNDRV_PCM_FORMAT_U24_3BE:
 	case SNDRV_PCM_FORMAT_U20_3BE:
 	case SNDRV_PCM_FORMAT_U18_3BE:
+	case SNDRV_PCM_FORMAT_DSD_U8:
+	case SNDRV_PCM_FORMAT_DSD_U16_LE:
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.0.4
