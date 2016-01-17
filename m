From: tom.ty89@gmail.com
Subject: [PATCH - alsa-lib 3/3] add surround21 to Echo3G devices
Date: Sun, 17 Jan 2016 21:44:06 +0800
Message-ID: <569b9abf.d944620a.28b6f.ffffc263@mx.google.com>
References: <1453038246-5240-1-git-send-email-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1453038246-5240-1-git-send-email-me>
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
Cc: alsa-devel@alsa-project.org, Tom Yan <tom.ty89@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Tom Yan <tom.ty89@gmail.com>

Signed-off-by: Tom Yan <tom.ty89@gmail.com>

diff --git a/src/conf/cards/Echo_Echo3G.conf b/src/conf/cards/Echo_Echo3G.conf
index dc95de6..548e709 100644
--- a/src/conf/cards/Echo_Echo3G.conf
+++ b/src/conf/cards/Echo_Echo3G.conf
@@ -50,6 +50,40 @@ Echo_Echo3G.pcm.side.0 {
 	subdevice 6
 }
 
+<confdir:pcm/surround21.conf>
+Echo_Echo3G.pcm.surround21.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type multi
+	slaves [
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.front.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.center_lfe.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+	]
+	bindings [
+		{ slave 0 channel 0 }
+		{ slave 0 channel 1 }
+		{ slave 1 channel 0 }
+	]
+}
+
 <confdir:pcm/surround30.conf>
 Echo_Echo3G.pcm.surround30.0 {
 	@args [ CARD ]
-- 
2.7.0
