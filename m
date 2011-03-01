From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 5/5] hdspmixer: Fix labels on H9652
Date: Tue,  1 Mar 2011 10:42:27 +0100
Message-ID: <1298972547-8759-6-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298972547-8759-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298972547-8759-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The H9652 uses the same layout as the Digiface, except Digiface features
an additional headphones out. That's why the channel mappings are the
same, but Digiface has mexdest=14 while H9652 has maxdest=13 (12 ADAT
pairs, another pair for S/PDIF and headphone-L/R on Digiface)

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerOutput.cxx b/hdspmixer/src/HDSPMixerOutput.cxx
index b0064c2..5047825 100644
--- a/hdspmixer/src/HDSPMixerOutput.cxx
+++ b/hdspmixer/src/HDSPMixerOutput.cxx
@@ -220,7 +220,7 @@ void HDSPMixerOutput::setLabels()
         return;
     };
     
-    if (type == Digiface) {
+    if (type == Digiface || type == H9652) {
         if (sm)
             labels_input = labels_playback = labels_df_ds;
         else
-- 
1.7.4.1
