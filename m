From: Felix Homann <linuxaudio@showlabor.de>
Subject: [PATCH 4/5] Rename Fast Track Ultra mixer quirk
	functions
Date: Mon, 23 Apr 2012 20:24:26 +0200
Message-ID: <1335205467-12650-5-git-send-email-linuxaudio@showlabor.de>
References: <1335205467-12650-1-git-send-email-linuxaudio@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1335205467-12650-1-git-send-email-linuxaudio@showlabor.de>
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

This is in preparation for more FTU controls to come. Should help keeping names
a bit shorter.

Signed-off-by: Felix Homann <linuxaudio@showlabor.de>

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 9f1987f..534e81e 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -575,8 +575,8 @@ static int snd_nativeinstruments_create_mixer(struct usb_mixer_interface *mixer,
 
 /* M-Audio FastTrack Ultra quirks */
 
-/* Create a volume control for FTU devices*/
-static int snd_maudio_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
+/* Create volume controls for FTU devices*/
+static int snd_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
 {
 	char name[64];
 	unsigned int control, cmask;
@@ -614,11 +614,11 @@ static int snd_maudio_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
-static int snd_maudio_ftu_create_mixer(struct usb_mixer_interface *mixer)
+static int snd_ftu_create_mixer(struct usb_mixer_interface *mixer)
 {
 	int err;
 
-	err = snd_maudio_ftu_create_volume_ctls(mixer);
+	err = snd_ftu_create_volume_ctls(mixer);
 	if (err < 0)
 		return err;
 
@@ -703,7 +703,7 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 
 	case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra */
 	case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
-		err = snd_maudio_ftu_create_mixer(mixer);
+		err = snd_ftu_create_mixer(mixer);
 		break;
 
 	case USB_ID(0x0b05, 0x1739):
-- 
1.7.5.4
