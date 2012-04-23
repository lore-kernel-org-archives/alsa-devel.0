From: Felix Homann <linuxaudio@showlabor.de>
Subject: [PATCH 5/7] Update comment for M-Audio FTU quirk
Date: Mon, 23 Apr 2012 16:37:35 +0200
Message-ID: <1335191857-6725-6-git-send-email-linuxaudio@showlabor.de>
References: <1335191857-6725-1-git-send-email-linuxaudio@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1335191857-6725-1-git-send-email-linuxaudio@showlabor.de>
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
Cc: alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>, mark@pogo.org.uk
List-Id: alsa-devel@alsa-project.org

Just cosmetics...

Signed-off-by: Felix Homann <linuxaudio@showlabor.de>

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 6e4f51c..3adef3e 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -575,7 +575,7 @@ static int snd_nativeinstruments_create_mixer(struct usb_mixer_interface *mixer,
 
 /* M-Audio FastTrack Ultra quirks */
 
-/* Create a volume control for FTU devices*/
+/* Create volume controls for FTU devices*/
 static int snd_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
 {
 	char name[64];
-- 
1.7.5.4
