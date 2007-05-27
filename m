From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Alsa-OSS Duplex bug (revisited)
Date: Sun, 27 May 2007 23:23:13 +0100
Message-ID: <200705272323.13056.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RTgWGxFLUsft1j9"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (unknown [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id E93002458F
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 00:15:05 +0200 (CEST)
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_RTgWGxFLUsft1j9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

About a year ago I posted an explaination of the cause of non-functioning with 
Alsa-OSS in duplex, together with a workaround patch.  After some discussion 
the thread ended.  However since then there has been a steady trickle of 
downloads of the patches from my host (it can also be found elsewhere) and 
some reports of great success,eg

	http://audacityteam.org/forum/thread/1388  (2nd page especially)

In attempting to tidy up some loose ends, I hope you can bear with me 
revisiting this and making the case for it's acceptance.  I am aware the 
Alsa-OSS is not of much interest to developers, and it might be said 'use 
native Alsa'; however that is not possible or desirable in all applications, 
and anyway, why provide an OSS emulation that cannot be made to work 
properly?

To summarise the problem first:

OSS provides a single SNDCTL_DSP_CHANNELS ioctl; where a device is duplex the 
number of capture and playback channels cannot be set separately.  With 
original OSS this was not a problem AFAIK because separate devices are 
created for capture and playback, ie they are not used duplex.  However 
Alsa-OSS in most cases creates a single combined device, which only operates 
correctly when an equal number of capture and playback channels are used.

The Workaround:

The workaround I proposed and now use constantly is like a secret trapdoor.  
Where the existing interface is adequate (ie captue channels == playback 
channels, or non-duplex) nothing changes, and SNDCTL_DSP_CHANNELS is set with 
a number between 0 and 128.  It is fully compatible with apps that don't know 
of the secret door -the front door is used!

However, if an app needs to set capture channels != playback channels, in 
duplex, at present the stream will malfunction every time.  But with this 
patch applied, if the app knows the workaround, then it can simply set 
SNDCTL_DSP_CHANNELS as  playback + 256*capture channels, and this will be 
interpreted correctly in the patched Alsa-OSS and the stream functions 
correctly.

As I say, there is therefore no loss of compatibility in either direction.  
Providing the app only uses the special formula when necessary rather than 
always, it is only providing a way to fix something that is broken.  It would 
seem to me of value to add the patch to Alsa so that the workaround can be 
effected by changes to the app only, without also having to patch and compile 
a replacement Alsa.  Whilst it is by no means ideal, it does overcome the 
underlying problem successfully.  Details of the workaround could be added to 
the  OSS-Emulation.html document.

Patch for 1.0.14rc4 is attached for consideration, together with example 
portaudio patch.

Regards  Alan









--Boundary-00=_RTgWGxFLUsft1j9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pcm_oss.c-1.0.14rc4-duplex-channels-set.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pcm_oss.c-1.0.14rc4-duplex-channels-set.diff"

--- alsa-kernel/core/oss/pcm_oss-orig.c	2006-04-13 11:51:24.000000000 +0100
+++ alsa-kernel/core/oss/pcm_oss.c	2006-06-19 11:08:07.000000000 +0100
@@ -1665,25 +1665,65 @@
 	return substream->runtime->oss.rate;
 }
 
+static int snd_pcm_oss_get_substream_channels(struct snd_pcm_oss_file *pcm_oss_file, int substrindx)
+{
+	struct snd_pcm_substream *substream;
+	int err = -1;
+
+	if (substrindx < 0 || substrindx > 1)
+		return err;
+	substream = pcm_oss_file->streams[substrindx];
+	if (substream == NULL)
+		return 0; /* Don't complain, consider as zero active channels */
+	return substream->runtime->oss.channels;
+}
+
 static int snd_pcm_oss_set_channels(struct snd_pcm_oss_file *pcm_oss_file, unsigned int channels)
 {
-	int idx;
+	struct snd_pcm_substream *substream;
+	int playback_channels, capture_channels, channels_set = -1;
+
 	if (channels < 1)
 		channels = 1;
-	if (channels > 128)
+	if (channels > 65025)
 		return -EINVAL;
-	for (idx = 1; idx >= 0; --idx) {
-		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
-		struct snd_pcm_runtime *runtime;
-		if (substream == NULL)
-			continue;
-		runtime = substream->runtime;
-		if (runtime->oss.channels != channels) {
-			runtime->oss.params = 1;
-			runtime->oss.channels = channels;
+
+	playback_channels = channels & 255;
+			/* lower 8 bits always set playback channels */
+	if (playback_channels > 128)
+		return -EINVAL;
+	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
+	if (substream != NULL)
+		if (substream->runtime->oss.channels != playback_channels) {
+			substream->runtime->oss.params = 1;
+			substream->runtime->oss.channels = playback_channels;
 		}
+
+	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
+	if (channels >255) { /* Enhanced channel set mode */
+		capture_channels = channels / 256 & 255;
+			 /* 2nd 8 bits set capture channels */
+		if (capture_channels > 128)
+			return -EINVAL;
+		if (substream != NULL)
+			if (substream->runtime->oss.channels != capture_channels) {
+				substream->runtime->oss.params = 1;
+				substream->runtime->oss.channels = capture_channels;
+			}
+		channels_set = snd_pcm_oss_get_substream_channels(
+				   pcm_oss_file, SNDRV_PCM_STREAM_PLAYBACK)
+				   + 256 * snd_pcm_oss_get_substream_channels(
+				   pcm_oss_file, SNDRV_PCM_STREAM_CAPTURE);
+	} else {  /* Standard mode, same num channels play and capture */
+		if (substream != NULL)
+			if (substream->runtime->oss.channels != channels) {
+				 /* Capture channels same as playback */
+				substream->runtime->oss.params = 1;
+				substream->runtime->oss.channels = channels;
+			}
+		channels_set = snd_pcm_oss_get_channels(pcm_oss_file);
 	}
-	return snd_pcm_oss_get_channels(pcm_oss_file);
+	return channels_set;
 }

 static int snd_pcm_oss_get_channels(struct snd_pcm_oss_file *pcm_oss_file)

--Boundary-00=_RTgWGxFLUsft1j9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pa-oss-duplex-chans-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pa-oss-duplex-chans-fix.diff"

--- lib-src/portaudio/pa_unix_oss/pa_unix-orig.c	2004-11-18 06:17:34.000000000 +0000
+++ lib-src/portaudio/pa_unix_oss/pa_unix.c	2006-07-05 15:23:19.000000000 +0100
@@ -5,6 +5,8 @@
  *
  * Copyright (c) 1999-2000 Phil Burk
  *
+ *  Linux-Duplex-'bug' fix Alan Horstmann  26.6.06
+ *
  * Permission is hereby granted, free of charge, to any person obtaining
  * a copy of this software and associated documentation files
  * (the "Software"), to deal in the Software without restriction,
@@ -778,12 +781,11 @@
 
     /* ------------------------- OPEN DEVICE -----------------------*/
 
-    /* just output */
     if (past->past_OutputDeviceID == past->past_InputDeviceID)
     {
 
         if ((past->past_NumOutputChannels > 0) && (past->past_NumInputChannels > 0) )
-        {
+        {  /* Duplex; input and output from same device */
             pad = Pa_GetInternalDevice( past->past_OutputDeviceID );
             DBUG(("PaHost_OpenStream: attempt to open %s for O_RDWR\n", pad->pad_DeviceName ));
 
@@ -806,17 +807,30 @@
                 result = paHostError;
                 goto error;
             }
+
+            int format_NumChannels, latency_NumChannels;
+
+            if (past->past_NumInputChannels > past->past_NumOutputChannels )
+                latency_NumChannels = past->past_NumInputChannels;
+            else
+                latency_NumChannels = past->past_NumOutputChannels ;
+
+            if (past->past_NumOutputChannels == past->past_NumInputChannels)
+                format_NumChannels = past->past_NumOutputChannels ;
+            else  /* Use new AH enhanced OSS channel setting feature  */
+                format_NumChannels = past->past_NumOutputChannels  + 256 * past->past_NumInputChannels;
+
             Pa_SetLatency( pahsc->pahsc_OutputHandle,
                            past->past_NumUserBuffers, past->past_FramesPerUserBuffer,
-                           past->past_NumOutputChannels );
+                           latency_NumChannels );
             result = Pa_SetupDeviceFormat( pahsc->pahsc_OutputHandle,
-                                           past->past_NumOutputChannels, (int)past->past_SampleRate );
+                                           format_NumChannels, (int)past->past_SampleRate );
         }
     }
     else
     {
         if (past->past_NumOutputChannels > 0)
-        {
+        {  /*  Output only  */
             pad = Pa_GetInternalDevice( past->past_OutputDeviceID );
             DBUG(("PaHost_OpenStream: attempt to open %s for O_WRONLY\n", pad->pad_DeviceName ));
             /* dmazzoni: test it first in nonblocking mode to
@@ -845,7 +857,7 @@
         }
 
         if (past->past_NumInputChannels > 0)
-        {
+        {  /*  Input capture only  */
             pad = Pa_GetInternalDevice( past->past_InputDeviceID );
             DBUG(("PaHost_OpenStream: attempt to open %s for O_RDONLY\n", pad->pad_DeviceName ));
             /* dmazzoni: test it first in nonblocking mode to

--Boundary-00=_RTgWGxFLUsft1j9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_RTgWGxFLUsft1j9--
