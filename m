From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: usb-audio: Fix an out-of-bound read
	in create_composite_quirks
Date: Mon,  7 Jan 2019 11:17:27 +0100
Message-ID: <20190107101727.6564-2-tiwai@suse.de>
References: <20190107101727.6564-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 885302678D3
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 11:17:30 +0100 (CET)
In-Reply-To: <20190107101727.6564-1-tiwai@suse.de>
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
Cc: Mathias Payer <mathias.payer@nebelwelt.net>, Hui Peng <benquike@163.com>
List-Id: alsa-devel@alsa-project.org

From: Hui Peng <benquike@163.com>

In `create_composite_quirk`, the terminating condition of for loops is
`quirk->ifnum < 0`. So any composite quirks should end with `struct
snd_usb_audio_quirk` object with ifnum < 0.

    for (quirk = quirk_comp->data; quirk->ifnum >= 0; ++quirk) {

    	.....
    }

the data field of Bower's & Wilkins PX headphones usb device device quirks
do not end with {.ifnum = -1}, wihch may result in out-of-bound read.

This Patch fix the bug by adding an ending quirk object.

Fixes: 240a8af929c7 ("ALSA: usb-audio: Add a quirck for B&W PX headphones")
Signed-off-by: Hui Peng <benquike@163.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks-table.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 37fc0447c071..b345beb447bd 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3326,6 +3326,9 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 					}
 				}
 			},
+			{
+				.ifnum = -1
+			},
 		}
 	}
 },
@@ -3369,6 +3372,9 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 					}
 				}
 			},
+			{
+				.ifnum = -1
+			},
 		}
 	}
 },
-- 
2.19.2
