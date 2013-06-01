From: o-takashi@sakamocchi.jp
Subject: [PATCH 4/8] add handling AMDTP stream
Date: Sun,  2 Jun 2013 00:55:54 +0900
Message-ID: <1370102158-24389-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: perex@perex.cz, clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Fireworks is IEC 61883-1 and 6 compliant framework (not fully). This file
utilize snd-firewire-lib module to handle AMDTP stream.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_stream.c |  107 +++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 sound/firewire/fireworks/fireworks_stream.c

diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
new file mode 100644
index 0000000..35b7a8e
--- /dev/null
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -0,0 +1,107 @@
+/*
+ * fireworks_stream.c - driver for Firewire devices from Echo Digital Audio
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ *
+ * This driver is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2.
+ *
+ * This driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "./fireworks.h"
+
+int snd_efw_stream_init(struct snd_efw *efw, struct amdtp_stream *stream)
+{
+	struct cmp_connection *connection;
+	enum cmp_direction c_dir;
+	enum amdtp_stream_direction s_dir;
+	int err;
+
+	if (stream == &efw->receive_stream) {
+		connection = &efw->output_connection;
+		c_dir = CMP_OUTPUT;
+		s_dir = AMDTP_STREAM_RECEIVE;
+	} else {
+		connection = &efw->input_connection;
+		c_dir = CMP_INPUT;
+		s_dir = AMDTP_STREAM_TRANSMIT;
+	}
+
+	err = cmp_connection_init(connection, efw->unit, c_dir, 0);
+	if (err < 0)
+		goto end;
+
+	err = amdtp_stream_init(stream, efw->unit, s_dir, CIP_NONBLOCKING);
+	if (err < 0) {
+		cmp_connection_destroy(connection);
+		goto end;
+	}
+
+end:
+	return err;
+}
+
+int snd_efw_stream_start(struct snd_efw *efw, struct amdtp_stream *stream)
+{
+	struct cmp_connection *connection;
+	int err = 0;
+
+	/* already running */
+	if (amdtp_stream_running(stream))
+		goto end;
+
+	if (stream == &efw->receive_stream)
+		connection = &efw->output_connection;
+	else
+		connection = &efw->input_connection;
+
+	/*  establish connection via CMP */
+	err = cmp_connection_establish(connection,
+				amdtp_stream_get_max_payload(stream));
+	if (err < 0)
+		goto end;
+
+	/* start amdtp stream */
+	err = amdtp_stream_start(stream,
+				 connection->resources.channel,
+				 connection->speed);
+	if (err < 0)
+		cmp_connection_break(connection);
+
+end:
+	return err;
+}
+
+void snd_efw_stream_stop(struct snd_efw *efw, struct amdtp_stream *stream)
+{
+	if (!amdtp_stream_running(stream))
+		goto end;
+
+	amdtp_stream_stop(stream);
+
+	if (stream == &efw->receive_stream)
+		cmp_connection_break(&efw->output_connection);
+	else
+		cmp_connection_break(&efw->input_connection);
+end:
+	return;
+}
+
+void snd_efw_stream_destroy(struct snd_efw *efw, struct amdtp_stream *stream)
+{
+	snd_efw_stream_stop(efw, stream);
+
+	if (stream == &efw->receive_stream)
+		cmp_connection_destroy(&efw->output_connection);
+	else
+		cmp_connection_destroy(&efw->input_connection);
+
+	return;
+}
-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
