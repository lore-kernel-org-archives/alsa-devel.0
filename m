From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/2] hdspmixer: Fix temporary RPM constant
Date: Fri, 29 Jul 2011 17:57:30 +0200
Message-ID: <1311955050-28144-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1311955050-28144-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1311955050-28144-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

RPM in hdsp.h's HDSP_IO_Type is 4, not 5. This patch isn't exactly
necessary here, because the constant is only used internally, but to
avoid confusion if somebody ever reads the code, let's use the correct
value.

Note that we'll drop it after the next alsa-lib release.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerCard.h b/hdspmixer/src/HDSPMixerCard.h
index 656702b..faaeefa 100644
--- a/hdspmixer/src/HDSPMixerCard.h
+++ b/hdspmixer/src/HDSPMixerCard.h
@@ -34,7 +34,7 @@
 
 /* temporary workaround until hdsp.h (HDSP_IO_Type gets fixed */
 #ifndef RPM
-# define RPM	5
+# define RPM	4
 #endif
 
 class HDSPMixerWindow;
-- 
1.7.5.4
