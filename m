From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] aplay: Fix error message when writing captured
	data
Date: Fri, 7 Apr 2017 15:14:40 +0300
Message-ID: <1491567280-20273-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0041.outbound.protection.outlook.com [104.47.2.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A3D0C2673B7
 for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2017 14:14:54 +0200 (CEST)
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
Cc: mihai.serban@nxp.com, alsa-devel@alsa-project.org, broonie@kernel.org, shengjiu.wang@nxp.com, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

Write can return less then requested bytes, but we treat
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
index ee480f2..9547d1b 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -3079,7 +3079,7 @@ static void capture(char *orig_name)
 				break;
 			}
 			if (write(fd, audiobuf, c) != c) {
-				perror(name);
+				fprintf(stderr, "Couldn't write all data to %s\n", name);
 				in_aborting = 1;
 				break;
 			}
-- 
2.7.4
