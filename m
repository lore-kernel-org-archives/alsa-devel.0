From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
Subject: [ppc/alsa-1.0.8] rme9625/hdsp.c fix.
Date: Wed, 26 Jan 2005 23:04:54 +0100
Message-ID: <200501262304.54521.pluto@pld-linux.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GQB+BGBqj+Fa45A"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_GQB+BGBqj+Fa45A
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Attached patch fixes compilation error.
Could You look at this?

Regards,
Pawe=C5=82.

--Boundary-00=_GQB+BGBqj+Fa45A
Content-Type: text/x-diff;
  charset="utf-8";
  name="rme9625-hdsp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="rme9625-hdsp.patch"

  This patch fixes compilation error:
 
  CC [M]  sound/pci/rme9652/hdsp.o
  sound/pci/rme9652/hdsp.c: In function `hdsp_request_fw_loader':
  sound/pci/rme9652/hdsp.c:4961: error: structure has no member named `data'
  
 hdsp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
 
--- a/sound/pci/rme9652/hdsp.c	2005-01-25 16:15:24.000000000 +0100
+++ b/sound/pci/rme9652/hdsp.c	2005-01-26 22:54:49.297771824 +0100
@@ -4958,7 +4958,7 @@
 #ifdef SNDRV_BIG_ENDIAN
 	{
 		int i;
-		u32 *src = hdsp->data;
+		u32 *src = fw->data;
 		for (i = 0; i < ARRAY_SIZE(hdsp->firmware_cache); i++, src++)
 			hdsp->firmware_cache[i] = ((*src & 0x000000ff) << 16) |
 				((*src & 0x0000ff00) << 8)  |

--Boundary-00=_GQB+BGBqj+Fa45A--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
