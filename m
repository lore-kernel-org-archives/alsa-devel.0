From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] ALSA: hda - Update HD-Audio-Models.txt
Date: Mon, 17 Jun 2013 11:04:03 +0200
Message-ID: <1371459843-3555-3-git-send-email-david.henningsson@canonical.com>
References: <1371459843-3555-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 28067261A61
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2013 11:04:05 +0200 (CEST)
In-Reply-To: <1371459843-3555-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Add new known codecs, and fix up tabs.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |   40 +++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 77d68e2..809d72b 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -21,41 +21,41 @@ ALC267/268
 ==========
   inv-dmic	Inverted internal mic workaround
 
-ALC269/270/275/276/280/282
+ALC269/270/275/276/28x/29x
 ======
-  laptop-amic	Laptops with analog-mic input
-  laptop-dmic	Laptops with digital-mic input
-  alc269-dmic	Enable ALC269(VA) digital mic workaround
-  alc271-dmic	Enable ALC271X digital mic workaround
-  inv-dmic	Inverted internal mic workaround
-  lenovo-dock   Enables docking station I/O for some Lenovos
+  laptop-amic		Laptops with analog-mic input
+  laptop-dmic		Laptops with digital-mic input
+  alc269-dmic		Enable ALC269(VA) digital mic workaround
+  alc271-dmic		Enable ALC271X digital mic workaround
+  inv-dmic		Inverted internal mic workaround
+  lenovo-dock   	Enables docking station I/O for some Lenovos
   dell-headset-multi	Headset jack, which can also be used as mic-in
   dell-headset-dock	Headset jack (without mic-in), and also dock I/O
 
-ALC662/663/272
+ALC66x/67x/892
 ==============
-  mario		Chromebook mario model fixup
-  asus-mode1	ASUS
-  asus-mode2	ASUS
-  asus-mode3	ASUS
-  asus-mode4	ASUS
-  asus-mode5	ASUS
-  asus-mode6	ASUS
-  asus-mode7	ASUS
-  asus-mode8	ASUS
-  inv-dmic	Inverted internal mic workaround
+  mario			Chromebook mario model fixup
+  asus-mode1		ASUS
+  asus-mode2		ASUS
+  asus-mode3		ASUS
+  asus-mode4		ASUS
+  asus-mode5		ASUS
+  asus-mode6		ASUS
+  asus-mode7		ASUS
+  asus-mode8		ASUS
+  inv-dmic		Inverted internal mic workaround
   dell-headset-multi	Headset jack, which can also be used as mic-in
 
 ALC680
 ======
   N/A
 
-ALC882/883/885/888/889
+ALC88x/898/1150
 ======================
   acer-aspire-4930g	Acer Aspire 4930G/5930G/6530G/6930G/7730G
   acer-aspire-8930g	Acer Aspire 8330G/6935G
   acer-aspire		Acer Aspire others
-  inv-dmic	Inverted internal mic workaround
+  inv-dmic		Inverted internal mic workaround
   no-primary-hp		VAIO Z/VGC-LN51JGB workaround (for fixed speaker DAC)
 
 ALC861/660
-- 
1.7.9.5
