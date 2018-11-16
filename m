From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: amd: fix spelling mistake "Inavlid" -> "Invalid"
Date: Fri, 16 Nov 2018 13:39:43 +0000
Message-ID: <20181116133943.8267-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/amd/raven/pci-acp3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index ef805e71a98f..c28457fd9b81 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -105,7 +105,7 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		}
 		break;
 	default:
-		dev_err(&pci->dev, "Inavlid ACP audio mode : %d\n", val);
+		dev_err(&pci->dev, "Invalid ACP audio mode : %d\n", val);
 		ret = -ENODEV;
 		goto unmap_mmio;
 	}
-- 
2.19.1
