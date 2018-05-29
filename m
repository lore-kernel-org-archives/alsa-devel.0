From: Jason Self <j@jxself.org>
Subject: [PATCH 1/1] Fix up aica firmware licensing
Date: Mon, 28 May 2018 18:43:35 -0700
Message-ID: <1527558215-20635-1-git-send-email-j@jxself.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@alsa-project.org, Jason Self <j@jxself.org>
List-Id: alsa-devel@alsa-project.org

The 3-clause BSD that this firmware uses requires more than just
keeping the copyright notice, like license.txt currently says.
Rather, it has has that "redistributions in binary form (which is
what the ALSA Project is doing, since only the firmware binary is
provided) must reproduce the above copyright notice, this list of
conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution." This means that more
than just the copyright notice needs to be included. This change is
intended to address this by adding the parts that were omitted
originally.

Signed-off-by: Jason Self <j@jxself.org>

diff --git a/aica/license.txt b/aica/license.txt
index 4b4cdbc..9de48bd 100644
--- a/aica/license.txt
+++ b/aica/license.txt
@@ -1,8 +1,34 @@
 This firmware is licenced under the KOS licence - a modified form of the BSD licence
 (for details see http://gamedev.allusion.net/softprj/kos/faq.php).
 
-It is fully and freely distributable provided the following notice is preserved somewhere
-in the code: Copyright (c) Dan Potter 2000.
+It is fully and freely distributable provided the following notices 
+are preserved:
+
+Copyright (c) Dan Potter 2000.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions
+are met:
+1. Redistributions of source code must retain the above copyright
+   notice, this list of conditions and the following disclaimer.
+2. Redistributions in binary form must reproduce the above copyright
+   notice, this list of conditions and the following disclaimer in the
+   documentation and/or other materials provided with the distribution.
+3. Neither the name of Cryptic Allusion nor the names of its contributors
+   may be used to endorse or promote products derived from this software
+   without specific prior written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE AUTHORS AND CONTRIBUTORS ``AS IS'' AND
+ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE LIABLE
+FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+SUCH DAMAGE.
 
 The code this firmware was built with is part of the KOS distribution and can also be
 reviewed here: http://linuxdc.cvs.sourceforge.net/linuxdc/linux-sh-dc/sound/oss/aica/firmware/
-- 
2.7.4
