From: Justin Mattock <justinmattock@gmail.com>
Subject: [PATCH] add missing definitions(letters) to
	HD-Audio.txt
Date: Tue, 14 Apr 2009 14:31:21 -0700
Message-ID: <dd18b0c30904141431x231a3251v438e365d512f9f95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f130.google.com (mail-qy0-f130.google.com
	[209.85.221.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FB4D103869
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 23:31:22 +0200 (CEST)
Received: by qyk36 with SMTP id 36so1165024qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2009 14:31:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

impact: Add missing definitions(letters).

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 Documentation/sound/alsa/HD-Audio.txt | 3 +++
 1 files changed,3 insertions(+),0 deletions(-)

===========================================================================================
---- Documentation/sound/alsa/HD-Audio.txt        2009-04-14
17:03:14.000000000 -0700
++++ Documentation/sound/alsa/HD-Audio.txt        2009-04-14
21:15:22.000000000 -0700
@@ -162,7 +162,7 @@
 What `model` option values are available depends on the codec chip.
 Check your codec chip from the codec proc file (see "Codec Proc-File"
 section below).  It will show the vendor/product name of your codec
-chip.  Then, see Documentation/sound/alsa/HD-Audio-Modelstxt file,
+chip.  Then, see Documentation/sound/alsa/HD-Audio-Models.txt file,
 the section of HD-audio driver.  You can find a list of codecs
 and `model` options belonging to each codec.  For example, for Realtek
 ALC262 codec chip, pass `model=ultra` for devices that are compatible
@@ -170,7 +170,7 @@

 Thus, the first thing you can do for any brand-new, unsupported and
 non-working HD-audio hardware is to check HD-audio codec and several
-different `model` option values.  If you have a luck, some of them
+different `model` option values.  If you have any luck, some of them
 might suit with your device well.

 Some codecs such as ALC880 have a special model option `model=test`.



-- 
Justin P. Mattock
