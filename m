From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoaudio - fix wrong # of channels
Date: Sat, 29 Jan 2005 15:23:19 +0100
Message-ID: <20050129152319.6bc1f7a0.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



- Typo fix: the number of channels of the Layla3G is wrong (copy&paste magic):


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-driver/pci/echoaudio/layla3g.c_old	Sat Jan 29 15:14:35 2005
+++ alsa-driver/pci/echoaudio/layla3g.c	Sat Jan 29 15:14:49 2005
@@ -33,18 +33,18 @@
 #define ECHOCARD_BOX	E3G_LAYLA3G
 
 /* Pipe indexes */
-#define PX_ANALOG_OUT	0	/* 6 */
-#define PX_DIGITAL_OUT	6	/* 8 */
-#define PX_ANALOG_IN	14	/* 2 */
-#define PX_DIGITAL_IN	16	/* 8 */
-#define PX_NUM		24
+#define PX_ANALOG_OUT	0	/* 8 */
+#define PX_DIGITAL_OUT	8	/* 8 */
+#define PX_ANALOG_IN	16	/* 8 */
+#define PX_DIGITAL_IN	24	/* 8 */
+#define PX_NUM		32
 
 /* Bus indexes */
-#define BX_ANALOG_OUT	0	/* 6 */
-#define BX_DIGITAL_OUT	6	/* 8 */
-#define BX_ANALOG_IN	14	/* 2 */
-#define BX_DIGITAL_IN	16	/* 8 */
-#define BX_NUM		24
+#define BX_ANALOG_OUT	0	/* 8 */
+#define BX_DIGITAL_OUT	8	/* 8 */
+#define BX_ANALOG_IN	16	/* 8 */
+#define BX_DIGITAL_IN	24	/* 8 */
+#define BX_NUM		32
 
 
 /* Number of channels */



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
