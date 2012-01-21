From: Dave Lentz <dtl131@gmail.com>
Subject: [PATCH] - HDA-Models.txt: Update model names
Date: Sat, 21 Jan 2012 07:37:44 -0500
Message-ID: <4F1AB198.207@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090605090300030300050908"
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090605090300030300050908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Update Conexant model names and add Realtek ALC665.

Signed-off-by: Dave Lentz <dtl131 at gmail.com>
---
  Documentation/sound/alsa/HD-Audio-Models.txt |    10 +++++-----
  1 files changed,  5 insertions(+),  5 deletions(-)

--------------090605090300030300050908
Content-Type: text/x-diff;
 name="hdamodels.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hdamodels.patch"

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index c8c5454..a2a2865 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -53,7 +53,7 @@ ALC269
   laptop-amic	Laptops with analog-mic input
   laptop-dmic	Laptops with digital-mic input
 
-ALC662/663/272
+ALC662/663/665/272
 ==============
   asus-mode1	ASUS
   asus-mode2	ASUS
@@ -192,7 +192,7 @@ AD1988/AD1988B/AD1989A/AD1989B
   laptop-dig	ditto with SPDIF
   auto		auto-config reading BIOS (default)
 
-Conexant 5045
+Conexant 5045  Venice/CX20549
 =============
   laptop-hpsense    Laptop with HP sense (old model laptop)
   laptop-micsense   Laptop with Mic sense (old model fujitsu)
@@ -203,7 +203,7 @@ Conexant 5045
 		can be adjusted.  Appearing only when compiled with
 		$CONFIG_SND_DEBUG=y
 
-Conexant 5047
+Conexant 5047  Waikiki/CX20551
 =============
   laptop	Basic Laptop config 
   laptop-hp	Laptop config for some HP models (subdevice 30A5)
@@ -212,7 +212,7 @@ Conexant 5047
 		can be adjusted.  Appearing only when compiled with
 		$CONFIG_SND_DEBUG=y
 
-Conexant 5051
+Conexant 5051  Hermosa/CX20561
 =============
   laptop	Basic Laptop config (default)
   hp		HP Spartan laptop
@@ -221,7 +221,7 @@ Conexant 5051
   ideapad	Lenovo IdeaPad laptop
   toshiba	Toshiba Satellite M300
 
-Conexant 5066
+Conexant 5066  Pebble/CX20582 
 =============
   laptop	Basic Laptop config (default)
   hp-laptop	HP laptops, e g G60

--------------090605090300030300050908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090605090300030300050908--
