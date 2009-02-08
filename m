From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - Don't touch non-existent port f on
	4-port 92hd71bxx codecs
Date: Sun, 8 Feb 2009 19:51:28 -0200
Message-ID: <200902081951.28160.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 736E6243C3
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2009 22:51:46 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 3561F3EA5
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2009 16:52:02 -0500 (EST)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id qfidrN86fwBB for <alsa-devel@alsa-project.org>;
	Sun,  8 Feb 2009 16:52:00 -0500 (EST)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 88E323EB8
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2009 16:51:45 -0500 (EST)
Received: from palo.localnet (unknown [172.21.225.10])
	by fox.conectiva (Postfix) with ESMTP id 9CF7C2F243
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2009 18:51:28 -0300 (BRT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When checking for input amps on pins 0x0a, 0x0d and 0x0f, and
initializing them for 92hd71xxx codec models, we must skip nid 0x0f
for 4-port models too like with 5-port models, as it is unused
(nid 0x0f is vendor reserved in 4-port models).

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_sigmatel.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index d16d5c6..2f4e090 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -5072,6 +5072,8 @@ again:
 	switch (codec->vendor_id) {
 	case 0x111d76b6: /* 4 Port without Analog Mixer */
 	case 0x111d76b7:
+		unmute_init++;
+		/* fallthru */
 	case 0x111d76b4: /* 6 Port without Analog Mixer */
 	case 0x111d76b5:
 		memcpy(&spec->private_dimux, &stac92hd71bxx_dmux_nomixer,
-- 
1.6.1.2
