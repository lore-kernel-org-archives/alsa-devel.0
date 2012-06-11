From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/4] alsa-info: Add roaraudio sound server
	detection
Date: Mon, 11 Jun 2012 10:45:22 +0200
Message-ID: <1339404323-3770-3-git-send-email-david.henningsson@canonical.com>
References: <1339404323-3770-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D86A10425D
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 10:45:35 +0200 (CEST)
In-Reply-To: <1339404323-3770-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 utils/alsa-info.sh |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/utils/alsa-info.sh b/utils/alsa-info.sh
index 01429a5..8f67e3c 100755
--- a/utils/alsa-info.sh
+++ b/utils/alsa-info.sh
@@ -416,6 +416,7 @@ ESDINST=$(which esd 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null)
 PAINST=$(which pulseaudio 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null)
 ARTSINST=$(which artsd 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null)
 JACKINST=$(which jackd 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null)
+ROARINST=$(which roard 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null)
 DMIDECODE=$(which dmidecode 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null)
 
 #Check for DMI data
@@ -529,7 +530,14 @@ echo "      Installed - Yes ($JACKINST)" >> $FILE
 echo "      Running - $JACKRUNNING" >> $FILE
 echo "" >> $FILE
 fi
-if [[ -z "$PAINST" && -z "$ESDINST" && -z "$ARTSINST" && -z "$JACKINST" ]];then
+if [[ -n $ROARINST ]];then
+[[ `pgrep '^(.*/)?roard$'` ]] && ROARRUNNING="Yes" || ROARRUNNING="No"
+echo "RoarAudio:" >> $FILE
+echo "      Installed - Yes ($ROARINST)" >> $FILE
+echo "      Running - $ROARRUNNING" >> $FILE
+echo "" >> $FILE
+fi
+if [[ -z "$PAINST" && -z "$ESDINST" && -z "$ARTSINST" && -z "$JACKINST" && -z "$ROARINST" ]];then
 echo "No sound servers found." >> $FILE
 echo "" >> $FILE
 fi
-- 
1.7.9.5
