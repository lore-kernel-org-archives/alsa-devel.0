From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 6/8] hdspmixer: Fix code indentation
Date: Mon,  7 Mar 2011 19:03:07 +0100
Message-ID: <1299520989-14273-7-git-send-email-adi@drcomp.erfurt.thur.de>
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

Only cosmetics, no changed semantics. Indent the whole function to get
rid of a mixture of tabs and spaces.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerCard.cxx b/hdspmixer/src/HDSPMixerCard.cxx
index 3ddbf62..bf7009f 100644
--- a/hdspmixer/src/HDSPMixerCard.cxx
+++ b/hdspmixer/src/HDSPMixerCard.cxx
@@ -208,202 +208,202 @@ void HDSPMixerCard::getAeb() {
 
 void HDSPMixerCard::adjustSettings() {
     if (type == Multiface) {
-	switch (speed_mode) {
-	case 0:
-	    channels_input = 18;
-	    channels_playback = 18;
-	    channels_output = 20; /* SS 8xAnalog+8xADAT+2xSPDIF+2xHeadphone */
-	    channel_map_input = channel_map_playback = channel_map_mf_ss;
-	    dest_map = dest_map_mf_ss;
-	    meter_map_input = meter_map_playback = channel_map_mf_ss;
-	    break;
-	case 1:
-	    channels_input = 14;
-	    channels_playback = 14;
-	    channels_output = 16; /* DS 8xAnalog+4xADAT(SMUX)+2xSPDIF+2xHeadphone */
-	    channel_map_input = channel_map_playback = meter_map_ds;
-	    dest_map = dest_map_ds;
-	    meter_map_input = meter_map_playback = meter_map_ds;
-	    break;
-	case 2:
-	    /* should never happen */
-	    break;
-	}
+        switch (speed_mode) {
+        case 0:
+            channels_input = 18;
+            channels_playback = 18;
+            channels_output = 20; /* SS 8xAnalog+8xADAT+2xSPDIF+2xHeadphone */
+            channel_map_input = channel_map_playback = channel_map_mf_ss;
+            dest_map = dest_map_mf_ss;
+            meter_map_input = meter_map_playback = channel_map_mf_ss;
+            break;
+        case 1:
+            channels_input = 14;
+            channels_playback = 14;
+            channels_output = 16; /* DS 8xAnalog+4xADAT(SMUX)+2xSPDIF+2xHeadphone */
+            channel_map_input = channel_map_playback = meter_map_ds;
+            dest_map = dest_map_ds;
+            meter_map_input = meter_map_playback = meter_map_ds;
+            break;
+        case 2:
+            /* should never happen */
+            break;
+        }
     } else if (type == Digiface) {
-	switch (speed_mode) {
-	case 0:
-	    channels_input = channels_playback = 26;
-	    channels_output = 28; /* SS 3x8xADAT+2xSPDIF+2xHeadphone */
-	    channel_map_input = channel_map_playback = channel_map_df_ss;
-	    dest_map = dest_map_df_ss;
-	    meter_map_input = meter_map_playback = channel_map_df_ss;
-	    break;
-	case 1:
-	    channels_input = channels_playback = 14;
-	    channels_output = 16; /* DS 3x4xADAT(SMUX)+2xSPDIF+2xHeadphone */
-	    channel_map_input = channel_map_playback = meter_map_ds;
-	    dest_map = dest_map_ds;
-	    meter_map_input = meter_map_playback = meter_map_ds;
-	    break;
-	case 2:
-	    /* should never happen */
-	    break;
-	}
+        switch (speed_mode) {
+        case 0:
+            channels_input = channels_playback = 26;
+            channels_output = 28; /* SS 3x8xADAT+2xSPDIF+2xHeadphone */
+            channel_map_input = channel_map_playback = channel_map_df_ss;
+            dest_map = dest_map_df_ss;
+            meter_map_input = meter_map_playback = channel_map_df_ss;
+            break;
+        case 1:
+            channels_input = channels_playback = 14;
+            channels_output = 16; /* DS 3x4xADAT(SMUX)+2xSPDIF+2xHeadphone */
+            channel_map_input = channel_map_playback = meter_map_ds;
+            dest_map = dest_map_ds;
+            meter_map_input = meter_map_playback = meter_map_ds;
+            break;
+        case 2:
+            /* should never happen */
+            break;
+        }
     } else if (type == H9652) {
-	switch (speed_mode) {
-	case 0:
-	    channels_input = channels_playback = 26;
-        channels_output = 26; /* SS like Digiface, but no Headphones */
-	    channel_map_input = channel_map_playback = channel_map_df_ss;
-	    dest_map = dest_map_h9652_ss;
-	    meter_map_input = meter_map_playback = channel_map_df_ss;
-	    break;
-	case 1:
-	    channels_input = channels_playback = 14;
-        channels_output = 14; /* DS like Digiface, but no Headphones */
-	    channel_map_input = channel_map_playback = channel_map_ds;
-	    dest_map = dest_map_h9652_ds;
-	    meter_map_input = meter_map_playback = meter_map_ds;
-	    break;
-	case 2:
-	    /* should never happen */
-	    break;
-	}
+        switch (speed_mode) {
+        case 0:
+            channels_input = channels_playback = 26;
+            channels_output = 26; /* SS like Digiface, but no Headphones */
+            channel_map_input = channel_map_playback = channel_map_df_ss;
+            dest_map = dest_map_h9652_ss;
+            meter_map_input = meter_map_playback = channel_map_df_ss;
+            break;
+        case 1:
+            channels_input = channels_playback = 14;
+            channels_output = 14; /* DS like Digiface, but no Headphones */
+            channel_map_input = channel_map_playback = channel_map_ds;
+            dest_map = dest_map_h9652_ds;
+            meter_map_input = meter_map_playback = meter_map_ds;
+            break;
+        case 2:
+            /* should never happen */
+            break;
+        }
     } else if (type == H9632) {
-	switch (speed_mode) {
-	case 0:
-	    channels_input = channels_playback = 12 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
-        channels_output = channels_playback; /* untested, no idea about this card */
-	    channel_map_input = channel_map_playback = channel_map_h9632_ss;
-	    dest_map = dest_map_h9632_ss;
-	    meter_map_input = meter_map_playback = channel_map_h9632_ss;
-	    break;
-	case 1:
-	    channels_input = channels_playback = 8 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
-        channels_output = channels_playback; /* untested, no idea about this card */
-	    channel_map_input = channel_map_playback = channel_map_h9632_ds;
-	    dest_map = dest_map_h9632_ds;
-	    meter_map_input = meter_map_playback = channel_map_h9632_ds;
-	    break;
-	case 2:
-	    channels_input = channels_playback = 4 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
-        channels_output = channels_playback; /* untested, no idea about this card */
-	    channel_map_input = channel_map_playback = channel_map_h9632_qs;
-	    dest_map = dest_map_h9632_qs;
-	    meter_map_input = meter_map_playback = channel_map_h9632_qs;
-	    break;
-	}
+        switch (speed_mode) {
+        case 0:
+            channels_input = channels_playback = 12 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
+            channels_output = channels_playback; /* untested, no idea about this card */
+            channel_map_input = channel_map_playback = channel_map_h9632_ss;
+            dest_map = dest_map_h9632_ss;
+            meter_map_input = meter_map_playback = channel_map_h9632_ss;
+            break;
+        case 1:
+            channels_input = channels_playback = 8 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
+            channels_output = channels_playback; /* untested, no idea about this card */
+            channel_map_input = channel_map_playback = channel_map_h9632_ds;
+            dest_map = dest_map_h9632_ds;
+            meter_map_input = meter_map_playback = channel_map_h9632_ds;
+            break;
+        case 2:
+            channels_input = channels_playback = 4 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
+            channels_output = channels_playback; /* untested, no idea about this card */
+            channel_map_input = channel_map_playback = channel_map_h9632_qs;
+            dest_map = dest_map_h9632_qs;
+            meter_map_input = meter_map_playback = channel_map_h9632_qs;
+            break;
+        }
     } else if (HDSPeMADI == type) {
-      playbacks_offset = 64;
+        playbacks_offset = 64;
 
-      switch (speed_mode) {
-      case 0: // SS
-	channels_input = channels_playback = 64;
-    channels_output = channels_input; /* SS headphones missing, at least HDSPe MADI has some, MADIface hasn't */
-	channel_map_input = channel_map_playback = channel_map_unity_ss;
-	dest_map = dest_map_unity;
-	meter_map_input = meter_map_playback = channel_map_unity_ss;
-	break;
-      case 1: // DS
-	channels_input = channels_playback = 32;
-    channels_output = channels_input; /* DS headphones missing, at least HDSPe MADI has some, MADIface hasn't */
-	channel_map_input = channel_map_playback = channel_map_unity_ss;
-	dest_map = dest_map_unity;
-	meter_map_input = meter_map_playback = channel_map_unity_ss;
-	break;
-      case 2: // QS
-	channels_input = channels_playback = 16;
-    channels_output = channels_input; /* QS headphones missing, at least HDSPe MADI has some, MADIface hasn't */
-	channel_map_input = channel_map_playback = channel_map_unity_ss;
-	dest_map = dest_map_unity;
-	meter_map_input = meter_map_playback = channel_map_unity_ss;
-	break;
-      }
+        switch (speed_mode) {
+        case 0: // SS
+            channels_input = channels_playback = 64;
+            channels_output = channels_input; /* SS headphones missing, at least HDSPe MADI has some, MADIface hasn't */
+            channel_map_input = channel_map_playback = channel_map_unity_ss;
+            dest_map = dest_map_unity;
+            meter_map_input = meter_map_playback = channel_map_unity_ss;
+            break;
+        case 1: // DS
+            channels_input = channels_playback = 32;
+            channels_output = channels_input; /* DS headphones missing, at least HDSPe MADI has some, MADIface hasn't */
+            channel_map_input = channel_map_playback = channel_map_unity_ss;
+            dest_map = dest_map_unity;
+            meter_map_input = meter_map_playback = channel_map_unity_ss;
+            break;
+        case 2: // QS
+            channels_input = channels_playback = 16;
+            channels_output = channels_input; /* QS headphones missing, at least HDSPe MADI has some, MADIface hasn't */
+            channel_map_input = channel_map_playback = channel_map_unity_ss;
+            dest_map = dest_map_unity;
+            meter_map_input = meter_map_playback = channel_map_unity_ss;
+            break;
+        }
 
     } else if (HDSPeAIO == type) {
-      playbacks_offset = 64;
+        playbacks_offset = 64;
 
-      switch (speed_mode) {
-      case 0: // SS
-	channels_input = 14;
-	channels_playback = 16;
-    channels_output = 16; /* SS 2xAnalog+2xAES+2xSPDIF+4xADAT+2xHeadphones */
-	channel_map_input = channel_map_aio_in_ss;
-	channel_map_playback = channel_map_aio_out_ss;
-	dest_map = dest_map_aio_ss;
-	meter_map_input = channel_map_aio_in_ss;
-	meter_map_playback = channel_map_aio_out_ss;
-	break;
-      case 1: // DS
-	channels_input = 10;
-	channels_playback = 12;
-    channels_output = 12; /* DS 2xAnalog+2xAES+2xSPDIF+4xADAT(SMUX)+2xHeadphones */
-	channel_map_input = channel_map_aio_in_ds;
-	channel_map_playback = channel_map_aio_out_ds;
-	dest_map = dest_map_aio_ds;
-	meter_map_input = channel_map_aio_in_ds;
-	meter_map_playback = channel_map_aio_out_ds;
-	break;
-      case 2: // QS
-	channels_input = 8;
-	channels_playback = 10;
-    channels_output = 10; /* QS 2xAnalog+2xAES+2xSPDIF+2xADAT(SMUX)+2xHeadphones */
-	channel_map_input = channel_map_aio_in_qs;
-	channel_map_playback = channel_map_aio_out_qs;
-	dest_map = dest_map_aio_qs;
-	meter_map_input = channel_map_aio_in_qs;
-	meter_map_playback = channel_map_aio_out_qs;
-	break;
-      }
+        switch (speed_mode) {
+        case 0: // SS
+            channels_input = 14;
+            channels_playback = 16;
+            channels_output = 16; /* SS 2xAnalog+2xAES+2xSPDIF+4xADAT+2xHeadphones */
+            channel_map_input = channel_map_aio_in_ss;
+            channel_map_playback = channel_map_aio_out_ss;
+            dest_map = dest_map_aio_ss;
+            meter_map_input = channel_map_aio_in_ss;
+            meter_map_playback = channel_map_aio_out_ss;
+            break;
+        case 1: // DS
+            channels_input = 10;
+            channels_playback = 12;
+            channels_output = 12; /* DS 2xAnalog+2xAES+2xSPDIF+4xADAT(SMUX)+2xHeadphones */
+            channel_map_input = channel_map_aio_in_ds;
+            channel_map_playback = channel_map_aio_out_ds;
+            dest_map = dest_map_aio_ds;
+            meter_map_input = channel_map_aio_in_ds;
+            meter_map_playback = channel_map_aio_out_ds;
+            break;
+        case 2: // QS
+            channels_input = 8;
+            channels_playback = 10;
+            channels_output = 10; /* QS 2xAnalog+2xAES+2xSPDIF+2xADAT(SMUX)+2xHeadphones */
+            channel_map_input = channel_map_aio_in_qs;
+            channel_map_playback = channel_map_aio_out_qs;
+            dest_map = dest_map_aio_qs;
+            meter_map_input = channel_map_aio_in_qs;
+            meter_map_playback = channel_map_aio_out_qs;
+            break;
+        }
 
     } else if (HDSP_AES == type) {
-      playbacks_offset = 64; /* not sure about this one? */
+        playbacks_offset = 64; /* not sure about this one? */
 
-      /* 16 channels for all modes */
-      channels_input = 16;
-      channels_playback = 16;
-      channels_output = 16;
-      channel_map_input = channel_map_aes32;
-      channel_map_playback = channel_map_aes32;
-      dest_map = dest_map_aes32;
-      meter_map_input = channel_map_aes32;
-      meter_map_playback = channel_map_aes32;
+        /* 16 channels for all modes */
+        channels_input = 16;
+        channels_playback = 16;
+        channels_output = 16;
+        channel_map_input = channel_map_aes32;
+        channel_map_playback = channel_map_aes32;
+        dest_map = dest_map_aes32;
+        meter_map_input = channel_map_aes32;
+        meter_map_playback = channel_map_aes32;
 
     } else if (HDSPeRayDAT == type) {
-      playbacks_offset = 64;
+        playbacks_offset = 64;
 
-      switch (speed_mode) {
-      case 0: // SS
-	channels_input = 36;
-	channels_playback = 36;
-	channels_output = 36; /* SS 4x8xADAT+2xAES/EBU+2xSPDIF */
-	channel_map_input = channel_map_playback = channel_map_raydat_ss;
-	dest_map = dest_map_raydat_ss;
-	meter_map_input = meter_map_playback = channel_map_raydat_ss;
-	break;
-      case 1: // DS
-	channels_input = 20;
-    channels_playback = 20;
-	channels_output = 20; /* DS 4x4xADAT(SMUX)+2xAES/EBU+2xSPDIF */
-	channel_map_input = channel_map_playback = channel_map_raydat_ds;
-	dest_map = dest_map_raydat_ds;
-	meter_map_input = meter_map_playback = channel_map_raydat_ds;
-	break;
-      case 2: // QS
-	channels_input = 12;
-	channels_playback = 12;
-	channels_output = 12; /* QS 4x2xADAT(SMUX)+2xAES/EBU+2xSPDIF */
-	channel_map_input = channel_map_playback = channel_map_raydat_qs;
-	dest_map = dest_map_raydat_qs;
-	meter_map_input = meter_map_playback = channel_map_raydat_qs;
-	break;
-      }
+        switch (speed_mode) {
+        case 0: // SS
+            channels_input = 36;
+            channels_playback = 36;
+            channels_output = 36; /* SS 4x8xADAT+2xAES/EBU+2xSPDIF */
+            channel_map_input = channel_map_playback = channel_map_raydat_ss;
+            dest_map = dest_map_raydat_ss;
+            meter_map_input = meter_map_playback = channel_map_raydat_ss;
+            break;
+        case 1: // DS
+            channels_input = 20;
+            channels_playback = 20;
+            channels_output = 20; /* DS 4x4xADAT(SMUX)+2xAES/EBU+2xSPDIF */
+            channel_map_input = channel_map_playback = channel_map_raydat_ds;
+            dest_map = dest_map_raydat_ds;
+            meter_map_input = meter_map_playback = channel_map_raydat_ds;
+            break;
+        case 2: // QS
+            channels_input = 12;
+            channels_playback = 12;
+            channels_output = 12; /* QS 4x2xADAT(SMUX)+2xAES/EBU+2xSPDIF */
+            channel_map_input = channel_map_playback = channel_map_raydat_qs;
+            dest_map = dest_map_raydat_qs;
+            meter_map_input = meter_map_playback = channel_map_raydat_qs;
+            break;
+        }
 
     }
 
     window_width = (channels_playback+2)*STRIP_WIDTH;
     window_height = FULLSTRIP_HEIGHT*2+SMALLSTRIP_HEIGHT+MENU_HEIGHT;
-} 
+}
 
 void HDSPMixerCard::setMode(int mode)
 {
-- 
1.7.4.1
