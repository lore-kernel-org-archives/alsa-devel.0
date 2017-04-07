From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2] aplay: Fix error message when writing
	captured data
Date: Fri, 7 Apr 2017 16:20:36 +0300
Message-ID: <1491571236-23476-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0055.outbound.protection.outlook.com [104.47.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F3552664EB
 for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2017 15:20:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, shengjiu.wang@nxp.com, o-takashi@sakamocchi.jp, broonie@kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com
List-Id: alsa-devel@alsa-project.org

Read can return less then requested bytes, but we treat
this as an error.

Anyhow, errno is not updated in this case and we can end
up with a confusing error message.

For example, when there is no room to write data into the
output file we receive:

$ arecord -d 2000 -c 2 -r 192000 -f S16_LE -Dplughw:0,0 audio.wav
Recording WAVE '/mnt/msc/audio.wav' : Signed 16 bit Little Endian, Rate
192000 Hz, Stereo
audio.wav: No such file or directory

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 aplay/aplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index ee480f2..96f5e1b 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -3079,7 +3079,7 @@ static void capture(char *orig_name)
 				break;
 			}
 			if (write(fd, audiobuf, c) != c) {
-				perror(name);
+				fprintf(stderr, _("Couldn't write all data to %s\n"), name);
 				in_aborting = 1;
 				break;
 			}
-- 
2.7.4
