From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH RFC 1/4] ALSA: madifx - Makefile entries for
	RME MADI FX
Date: Fri,  1 Feb 2013 13:48:38 +0100
Message-ID: <1359722921-18769-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1359722921-18769-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1359722921-18769-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add Makefile entries for RME MADI FX cards.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/Makefile b/sound/pci/rme9652/Makefile
index dcba560..e483dce 100644
--- a/sound/pci/rme9652/Makefile
+++ b/sound/pci/rme9652/Makefile
@@ -6,8 +6,10 @@
 snd-rme9652-objs := rme9652.o
 snd-hdsp-objs := hdsp.o
 snd-hdspm-objs := hdspm.o
+snd-madifx-objs := madifx.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_RME9652) += snd-rme9652.o
 obj-$(CONFIG_SND_HDSP) += snd-hdsp.o
 obj-$(CONFIG_SND_HDSPM) +=snd-hdspm.o
+obj-$(CONFIG_SND_MADIFX) +=snd-madifx.o
-- 
1.7.10.4
