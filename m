From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 4/8] hdspmixer: Introduce output channel count
	for all cards.
Date: Mon,  7 Mar 2011 19:03:05 +0100
Message-ID: <1299520989-14273-5-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1299520989-14273-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1299520989-14273-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some cards (like multiface) have more physical output ports than
playback ports, mostly because of additional headphones out.

For those cards, the old abstraction model of channels_input and
channels_output doesn't fit, so let's introduce channels_output.

Of course, channels_output is always 2*max_dest at the given speed_mode
(SS/DS/QS), so one could extend this idea, store all destination
settings in channels_output[3] (one for each speed mode) and rip off the
massive code duplication for setting maxdest or max_dest respectively.

Note that dest_map_whatever_speed_mode's array size indirectly defines
the right value for channels_output (read: even more unwanted
redundancy)

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerCard.cxx b/hdspmixer/src/HDSPMixerCard.cxx
index cd6a922..3ddbf62 100644
--- a/hdspmixer/src/HDSPMixerCard.cxx
+++ b/hdspmixer/src/HDSPMixerCard.cxx
@@ -212,6 +212,7 @@ void HDSPMixerCard::adjustSettings() {
 	case 0:
 	    channels_input = 18;
 	    channels_playback = 18;
+	    channels_output = 20; /* SS 8xAnalog+8xADAT+2xSPDIF+2xHeadphone */
 	    channel_map_input = channel_map_playback = channel_map_mf_ss;
 	    dest_map = dest_map_mf_ss;
 	    meter_map_input = meter_map_playback = channel_map_mf_ss;
@@ -219,6 +220,7 @@ void HDSPMixerCard::adjustSettings() {
 	case 1:
 	    channels_input = 14;
 	    channels_playback = 14;
+	    channels_output = 16; /* DS 8xAnalog+4xADAT(SMUX)+2xSPDIF+2xHeadphone */
 	    channel_map_input = channel_map_playback = meter_map_ds;
 	    dest_map = dest_map_ds;
 	    meter_map_input = meter_map_playback = meter_map_ds;
@@ -231,12 +233,14 @@ void HDSPMixerCard::adjustSettings() {
 	switch (speed_mode) {
 	case 0:
 	    channels_input = channels_playback = 26;
+	    channels_output = 28; /* SS 3x8xADAT+2xSPDIF+2xHeadphone */
 	    channel_map_input = channel_map_playback = channel_map_df_ss;
 	    dest_map = dest_map_df_ss;
 	    meter_map_input = meter_map_playback = channel_map_df_ss;
 	    break;
 	case 1:
 	    channels_input = channels_playback = 14;
+	    channels_output = 16; /* DS 3x4xADAT(SMUX)+2xSPDIF+2xHeadphone */
 	    channel_map_input = channel_map_playback = meter_map_ds;
 	    dest_map = dest_map_ds;
 	    meter_map_input = meter_map_playback = meter_map_ds;
@@ -249,12 +253,14 @@ void HDSPMixerCard::adjustSettings() {
 	switch (speed_mode) {
 	case 0:
 	    channels_input = channels_playback = 26;
+        channels_output = 26; /* SS like Digiface, but no Headphones */
 	    channel_map_input = channel_map_playback = channel_map_df_ss;
 	    dest_map = dest_map_h9652_ss;
 	    meter_map_input = meter_map_playback = channel_map_df_ss;
 	    break;
 	case 1:
 	    channels_input = channels_playback = 14;
+        channels_output = 14; /* DS like Digiface, but no Headphones */
 	    channel_map_input = channel_map_playback = channel_map_ds;
 	    dest_map = dest_map_h9652_ds;
 	    meter_map_input = meter_map_playback = meter_map_ds;
@@ -267,18 +273,21 @@ void HDSPMixerCard::adjustSettings() {
 	switch (speed_mode) {
 	case 0:
 	    channels_input = channels_playback = 12 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
+        channels_output = channels_playback; /* untested, no idea about this card */
 	    channel_map_input = channel_map_playback = channel_map_h9632_ss;
 	    dest_map = dest_map_h9632_ss;
 	    meter_map_input = meter_map_playback = channel_map_h9632_ss;
 	    break;
 	case 1:
 	    channels_input = channels_playback = 8 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
+        channels_output = channels_playback; /* untested, no idea about this card */
 	    channel_map_input = channel_map_playback = channel_map_h9632_ds;
 	    dest_map = dest_map_h9632_ds;
 	    meter_map_input = meter_map_playback = channel_map_h9632_ds;
 	    break;
 	case 2:
 	    channels_input = channels_playback = 4 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
+        channels_output = channels_playback; /* untested, no idea about this card */
 	    channel_map_input = channel_map_playback = channel_map_h9632_qs;
 	    dest_map = dest_map_h9632_qs;
 	    meter_map_input = meter_map_playback = channel_map_h9632_qs;
@@ -290,18 +299,21 @@ void HDSPMixerCard::adjustSettings() {
       switch (speed_mode) {
       case 0: // SS
 	channels_input = channels_playback = 64;
+    channels_output = channels_input; /* SS headphones missing, at least HDSPe MADI has some, MADIface hasn't */
 	channel_map_input = channel_map_playback = channel_map_unity_ss;
 	dest_map = dest_map_unity;
 	meter_map_input = meter_map_playback = channel_map_unity_ss;
 	break;
       case 1: // DS
 	channels_input = channels_playback = 32;
+    channels_output = channels_input; /* DS headphones missing, at least HDSPe MADI has some, MADIface hasn't */
 	channel_map_input = channel_map_playback = channel_map_unity_ss;
 	dest_map = dest_map_unity;
 	meter_map_input = meter_map_playback = channel_map_unity_ss;
 	break;
       case 2: // QS
 	channels_input = channels_playback = 16;
+    channels_output = channels_input; /* QS headphones missing, at least HDSPe MADI has some, MADIface hasn't */
 	channel_map_input = channel_map_playback = channel_map_unity_ss;
 	dest_map = dest_map_unity;
 	meter_map_input = meter_map_playback = channel_map_unity_ss;
@@ -315,6 +327,7 @@ void HDSPMixerCard::adjustSettings() {
       case 0: // SS
 	channels_input = 14;
 	channels_playback = 16;
+    channels_output = 16; /* SS 2xAnalog+2xAES+2xSPDIF+4xADAT+2xHeadphones */
 	channel_map_input = channel_map_aio_in_ss;
 	channel_map_playback = channel_map_aio_out_ss;
 	dest_map = dest_map_aio_ss;
@@ -324,6 +337,7 @@ void HDSPMixerCard::adjustSettings() {
       case 1: // DS
 	channels_input = 10;
 	channels_playback = 12;
+    channels_output = 12; /* DS 2xAnalog+2xAES+2xSPDIF+4xADAT(SMUX)+2xHeadphones */
 	channel_map_input = channel_map_aio_in_ds;
 	channel_map_playback = channel_map_aio_out_ds;
 	dest_map = dest_map_aio_ds;
@@ -333,6 +347,7 @@ void HDSPMixerCard::adjustSettings() {
       case 2: // QS
 	channels_input = 8;
 	channels_playback = 10;
+    channels_output = 10; /* QS 2xAnalog+2xAES+2xSPDIF+2xADAT(SMUX)+2xHeadphones */
 	channel_map_input = channel_map_aio_in_qs;
 	channel_map_playback = channel_map_aio_out_qs;
 	dest_map = dest_map_aio_qs;
@@ -347,6 +362,7 @@ void HDSPMixerCard::adjustSettings() {
       /* 16 channels for all modes */
       channels_input = 16;
       channels_playback = 16;
+      channels_output = 16;
       channel_map_input = channel_map_aes32;
       channel_map_playback = channel_map_aes32;
       dest_map = dest_map_aes32;
@@ -360,13 +376,15 @@ void HDSPMixerCard::adjustSettings() {
       case 0: // SS
 	channels_input = 36;
 	channels_playback = 36;
+	channels_output = 36; /* SS 4x8xADAT+2xAES/EBU+2xSPDIF */
 	channel_map_input = channel_map_playback = channel_map_raydat_ss;
 	dest_map = dest_map_raydat_ss;
 	meter_map_input = meter_map_playback = channel_map_raydat_ss;
 	break;
       case 1: // DS
 	channels_input = 20;
-	channels_playback = 20;
+    channels_playback = 20;
+	channels_output = 20; /* DS 4x4xADAT(SMUX)+2xAES/EBU+2xSPDIF */
 	channel_map_input = channel_map_playback = channel_map_raydat_ds;
 	dest_map = dest_map_raydat_ds;
 	meter_map_input = meter_map_playback = channel_map_raydat_ds;
@@ -374,6 +392,7 @@ void HDSPMixerCard::adjustSettings() {
       case 2: // QS
 	channels_input = 12;
 	channels_playback = 12;
+	channels_output = 12; /* QS 4x2xADAT(SMUX)+2xAES/EBU+2xSPDIF */
 	channel_map_input = channel_map_playback = channel_map_raydat_qs;
 	dest_map = dest_map_raydat_qs;
 	meter_map_input = meter_map_playback = channel_map_raydat_qs;
@@ -397,7 +416,9 @@ void HDSPMixerCard::setMode(int mode)
     }
     for (int i = 0; i < channels_playback; ++i) {
       basew->playbacks->strips[i]->targets->setLabels();
-      basew->outputs->strips[i]->setLabels();    
+    }
+    for (int i = 0; i < channels_output; ++i) {
+      basew->outputs->strips[i]->setLabels();
     }
 
     if (h9632_aeb.aebo && !h9632_aeb.aebi) {
@@ -435,11 +456,16 @@ void HDSPMixerCard::actualizeStrips()
 	} else {
 	    basew->inputs->strips[i]->hide();
 	}
+
 	if (i < channels_playback) {
 	    basew->playbacks->strips[i]->show();
-	    basew->outputs->strips[i]->show();
 	} else {
 	    basew->playbacks->strips[i]->hide();
+	}
+
+	if (i < channels_output) {
+	    basew->outputs->strips[i]->show();
+	} else {
 	    basew->outputs->strips[i]->hide();
 	}
     }
diff --git a/hdspmixer/src/HDSPMixerCard.h b/hdspmixer/src/HDSPMixerCard.h
index cfb2402..b721bd9 100644
--- a/hdspmixer/src/HDSPMixerCard.h
+++ b/hdspmixer/src/HDSPMixerCard.h
@@ -44,6 +44,7 @@ public:
     char name[6];
     HDSPMixerCard(int cardtype, int id);
     int channels_input, channels_playback, window_width, window_height, card_id;
+    int channels_output;
     int type;
     char *channel_map_input, *channel_map_playback;
     char *dest_map;
diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index 8c057e0..8f44c99 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -109,7 +109,7 @@ static void readregisters_cb(void *arg)
     }
 
     if (w->inputs->buttons->output) {
-        for (int i = 0; i < w->cards[w->current_card]->channels_playback; ++i) {
+        for (int i = 0; i < w->cards[w->current_card]->channels_output; ++i) {
             w->outputs->strips[i]->meter->update(output_peaks[(w->cards[w->current_card]->meter_map_playback[i])] & 0xffffff00,
                     output_peaks[(w->cards[w->current_card]->meter_map_playback[i])] & 0xf,
                     output_rms[(w->cards[w->current_card]->meter_map_playback[i])]);
@@ -738,7 +738,7 @@ HDSPMixerWindow::HDSPMixerWindow(int x, int y, int w, int h, const char *label,
     inputs->buttons->submix = 1;
     inputs->buttons->playback = 1;
     playbacks = new HDSPMixerPlaybacks(0, MENU_HEIGHT+FULLSTRIP_HEIGHT, w, FULLSTRIP_HEIGHT, cards[0]->channels_playback);
-    outputs = new HDSPMixerOutputs(0, MENU_HEIGHT+FULLSTRIP_HEIGHT*2, w, SMALLSTRIP_HEIGHT, cards[0]->channels_playback);
+    outputs = new HDSPMixerOutputs(0, MENU_HEIGHT+FULLSTRIP_HEIGHT*2, w, SMALLSTRIP_HEIGHT, cards[0]->channels_output);
     scroll->end();
     end();
     setup = new HDSPMixerSetup(400, 260, "Level Meters Setup", this);
-- 
1.7.4.1
