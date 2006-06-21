From: Matthias Koenig <mk@phasorlab.de>
Subject: [PATCH] alsa-utils: amidi: Fix device list
Date: Wed, 21 Jun 2006 15:27:22 +0200
Message-ID: <87u06e3ah1.fsf@zebra.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

--=-=-=

Hi,

amidi does not show all devices with the --list-devices option. 
It assumes that all output ports equals input ports and does not
show an input only port.
This patch extends the output of amidi -l by one column which shows
the input/output direction of each port.
E.g.

zebra:amidi # ./amidi -l
Dir Device    Name
IO  hw:1,0    MPU-401 MIDI 1-0
IO  hw:2,0,0  Keystation MIDI 1
IO  hw:3,0,0  Miditerminal 1
IO  hw:3,0,1  Miditerminal 2
IO  hw:3,0,2  Miditerminal 3
IO  hw:3,0,3  Miditerminal 4
I   hw:3,0,4  Miditerminal SMPTE

The patch still assumes, if input and output are present, both have the
same name. Maybe it would be better to do two separate lists, but I
wanted to change the behavior of the tool as little as possible.
What do you think?

Matthias


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=amidi-ports.patch
Content-Description: amidi-ports.patch

diff -r 26d52a2cc952 amidi/amidi.c
--- a/amidi/amidi.c	Thu May 18 12:33:35 2006 +0200
+++ b/amidi/amidi.c	Wed Jun 21 14:19:03 2006 +0200
@@ -95,56 +95,119 @@ static void *my_malloc(size_t size)
 	return p;
 }
 
+static int is_input(snd_ctl_t *ctl, int card, int device, int sub)
+{
+	snd_rawmidi_info_t *info;
+	int err;
+
+	snd_rawmidi_info_alloca(&info);
+	snd_rawmidi_info_set_device(info, device);
+	snd_rawmidi_info_set_subdevice(info, sub);
+	snd_rawmidi_info_set_stream(info, SND_RAWMIDI_STREAM_INPUT);
+	
+	if ((err = snd_ctl_rawmidi_info(ctl, info)) < 0 && err != -ENXIO)
+		return err;
+	else if (err == 0)
+		return 1;
+
+	return 0;
+}
+
+static int is_output(snd_ctl_t *ctl, int card, int device, int sub)
+{
+	snd_rawmidi_info_t *info;
+	int err;
+
+	snd_rawmidi_info_alloca(&info);
+	snd_rawmidi_info_set_device(info, device);
+	snd_rawmidi_info_set_subdevice(info, sub);
+	snd_rawmidi_info_set_stream(info, SND_RAWMIDI_STREAM_OUTPUT);
+	
+	if ((err = snd_ctl_rawmidi_info(ctl, info)) < 0 && err != -ENXIO)
+		return err;
+	else if (err == 0)
+		return 1;
+
+	return 0;
+}
+
 static void list_device(snd_ctl_t *ctl, int card, int device)
 {
 	snd_rawmidi_info_t *info;
 	const char *name;
 	const char *sub_name;
-	int subs;
+	int subs, subs_in, subs_out;
+	int sub, in, out;
 	int err;
 
 	snd_rawmidi_info_alloca(&info);
 	snd_rawmidi_info_set_device(info, device);
-	snd_rawmidi_info_set_subdevice(info, 0);
+
+	snd_rawmidi_info_set_stream(info, SND_RAWMIDI_STREAM_INPUT);
+	snd_ctl_rawmidi_info(ctl, info);
+	subs_in = snd_rawmidi_info_get_subdevices_count(info);
 	snd_rawmidi_info_set_stream(info, SND_RAWMIDI_STREAM_OUTPUT);
-	if ((err = snd_ctl_rawmidi_info(ctl, info)) < 0 &&
-	    err != -ENOENT) {
+	snd_ctl_rawmidi_info(ctl, info);
+	subs_out = snd_rawmidi_info_get_subdevices_count(info);
+	subs = subs_in > subs_out ? subs_in : subs_out;
+
+	sub = 0;
+	in = out = 0;
+	if ((err = is_output(ctl, card, device, sub)) < 0) {
 		error("cannot get rawmidi information %d:%d: %s",
 		      card, device, snd_strerror(err));
 		return;
-	}
-	if (err == -ENOENT) {
-		snd_rawmidi_info_set_stream(info, SND_RAWMIDI_STREAM_INPUT);
-		if ((err = snd_ctl_rawmidi_info(ctl, info)) < 0 &&
-		    err != -ENOENT) {
+	} else if (err)
+		out = 1;
+
+	if (err == 0) {
+		if ((err = is_input(ctl, card, device, sub)) < 0) {
 			error("cannot get rawmidi information %d:%d: %s",
 			      card, device, snd_strerror(err));
 			return;
 		}
-	}
-	if (err == -ENOENT)
-		return;
+	} else if (err) 
+		in = 1;
+
+	if (err == 0)
+		return;
+
 	name = snd_rawmidi_info_get_name(info);
 	sub_name = snd_rawmidi_info_get_subdevice_name(info);
-	subs = snd_rawmidi_info_get_subdevices_count(info);
 	if (sub_name[0] == '\0') {
-		if (subs == 1)
-			printf("hw:%d,%d    %s\n", card, device, name);
-		else
-			printf("hw:%d,%d    %s (%d subdevices)\n",
+		if (subs == 1) {
+			printf("%c%c  hw:%d,%d    %s\n", 
+			       in ? 'I' : ' ', out ? 'O' : ' ',
+			       card, device, name);
+		} else
+			printf("      hw:%d,%d    %s (%d subdevices)\n",
 			       card, device, name, subs);
 	} else {
-		int sub = 0;
+		sub = 0;
 		for (;;) {
-			printf("hw:%d,%d,%d  %s\n",
+			printf("%c%c  hw:%d,%d,%d  %s\n",
+			       in ? 'I' : ' ', out ? 'O' : ' ',
 			       card, device, sub, sub_name);
 			if (++sub >= subs)
 				break;
+
+			in = is_input(ctl, card, device, sub);
+			out = is_output(ctl, card, device, sub);
 			snd_rawmidi_info_set_subdevice(info, sub);
-			if ((err = snd_ctl_rawmidi_info(ctl, info)) < 0) {
-				error("cannot get rawmidi information %d:%d:%d: %s",
-				      card, device, sub, snd_strerror(err));
-				break;
+			if (out) {
+				snd_rawmidi_info_set_stream(info, SND_RAWMIDI_STREAM_OUTPUT);
+				if ((err = snd_ctl_rawmidi_info(ctl, info)) < 0) {
+					error("cannot get rawmidi information %d:%d:%d: %s",
+					      card, device, sub, snd_strerror(err));
+					break;
+				} 
+			} else {
+				snd_rawmidi_info_set_stream(info, SND_RAWMIDI_STREAM_INPUT);
+				if ((err = snd_ctl_rawmidi_info(ctl, info)) < 0) {
+					error("cannot get rawmidi information %d:%d:%d: %s",
+					      card, device, sub, snd_strerror(err));
+					break;
+				}
 			}
 			sub_name = snd_rawmidi_info_get_subdevice_name(info);
 		}
@@ -189,7 +252,7 @@ static void device_list(void)
 		error("no sound card found");
 		return;
 	}
-	puts("Device    Name");
+	puts("Dir Device    Name");
 	do {
 		list_card_devices(card);
 		if ((err = snd_card_next(&card)) < 0) {

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-=-=--
