From: bruno.n.pagani@gmail.com
Subject: [PATCH 1/1] USB-Audio: Add second S/PDIF device on
	Phiree U2SX
Date: Sun,  1 Apr 2018 19:11:20 +0200
Message-ID: <5ac112c2.042aed0a.b6b06.7943@mx.google.com>
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
Cc: alsa-devel@alsa-project.org, Bruno Pagani <bruno.n.pagani@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Bruno Pagani <bruno.n.pagani@gmail.com>

Phiree U2SX is the successor of Phiree U2 and has the same unusual
configuration.

See ea865bba4615d906144ae5d4f72a4aad2baffe1f for reference.

Signed-off-by: Bruno Pagani <bruno.n.pagani@gmail.com>

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index cc8c718c..2b8f9a29 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -64,6 +64,7 @@ USB-Audio.pcm.iec958_device {
 # Second iec958 device number, if any.
 USB-Audio.pcm.iec958_2_device {
 	"PHIREE U2" 1  # 0 = PCM S/PDIF, 1 = non-PCM S/PDIF
+	"PHIREE U2SX" 1  # 0 = PCM S/PDIF, 1 = non-PCM S/PDIF
 }
 
 
-- 
2.16.3
