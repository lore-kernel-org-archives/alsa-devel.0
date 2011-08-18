From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] alsa-plugins: Pulse: only underrun if no more
 data has been written
Date: Thu, 18 Aug 2011 17:06:15 +0200
Message-ID: <4E4D2A67.9050507@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030800070508050501080505"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id C2C8C243B6
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 17:06:15 +0200 (CEST)
Received: from hd9483857.selulk5.dyn.perspektivbredband.net ([217.72.56.87]
	helo=[192.168.8.102]) by youngberry.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <david.henningsson@canonical.com>) id 1Qu4Ag-000279-9D
	for alsa-devel@alsa-project.org; Thu, 18 Aug 2011 15:06:14 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030800070508050501080505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

With the new/upcoming version of PulseAudio (0.99.x) there is a protocol 
addition that makes it possible to handle underruns better in the pulse 
plugin.

The attached patch implements that, but it has two flaws I wouldn't mind 
getting some help with if possible:

1) Since this uses the new API function pa_stream_get_underflow_index, 
it won't compile with current stable PulseAudio versions, only the 
upcoming version.

2) So now there are three possibilities for handle_underrun ( 0 = never, 
1 = always, 2 = the new improved one that IMO should be used). Since 
handle_underrun is a bool in the config, it can not be set to "2", only 
0 or 1.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------030800070508050501080505
Content-Type: text/x-patch;
 name="0001-alsa-plugins-Pulse-only-underrun-if-no-more-data-has.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alsa-plugins-Pulse-only-underrun-if-no-more-data-has.pa";
 filename*1="tch"

>From 4e31ba395b751a6ab3254256dc8a227b3be67932 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 2 Aug 2011 14:49:04 +0200
Subject: [PATCH] alsa-plugins: Pulse: only underrun if no more data has been written

If more data has already been written after the underrun, the underrun
will automatically end and therefore we should not report it or
restart the stream.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 pulse/pcm_pulse.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index d6c6792..9c4a7e5 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -39,9 +39,10 @@ typedef struct snd_pcm_pulse {
 	size_t last_size;
 	size_t ptr;
 	int underrun;
-	int handle_underrun;
+	int handle_underrun; /* can be 0=never, 1=always or 2=only if more data has not been written */
 
 	size_t offset;
+	int64_t written;
 
 	pa_stream *stream;
 
@@ -459,6 +460,7 @@ static snd_pcm_sframes_t pulse_write(snd_pcm_ioplug_t * io,
 	}
 
 	/* Make sure the buffer pointer is in sync */
+	pcm->written += writebytes;
 	pcm->last_size -= writebytes;
 	ret = update_ptr(pcm);
 	if (ret < 0)
@@ -594,7 +596,8 @@ static void stream_underrun_cb(pa_stream * p, void *userdata)
 	if (!pcm->p)
 		return;
 
-	pcm->underrun = 1;
+	if (pcm->handle_underrun == 1 || pcm->written <= pa_stream_get_underflow_index(p))
+		pcm->underrun = 1;
 }
 
 static void stream_latency_cb(pa_stream *p, void *userdata) {
@@ -691,6 +694,7 @@ static int pulse_prepare(snd_pcm_ioplug_t * io)
 		goto finish;
 	}
 
+	pcm->written = 0;
 	pa_stream_set_state_callback(pcm->stream, stream_state_cb, pcm);
 	pa_stream_set_latency_update_callback(pcm->stream, stream_latency_cb, pcm);
 
@@ -983,7 +987,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(pulse)
 	const char *server = NULL;
 	const char *device = NULL;
 	const char *fallback_name = NULL;
-	int handle_underrun = 0;
+	int handle_underrun = 2;
 	int err;
 	snd_pcm_pulse_t *pcm;
 
-- 
1.7.4.1


--------------030800070508050501080505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030800070508050501080505--
