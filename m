From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] alsa-plugins: Pulse: only underrun if no
 more data has been written
Date: Tue, 23 Aug 2011 13:56:58 +0200
Message-ID: <4E53958A.5050602@canonical.com>
References: <4E4D2A67.9050507@canonical.com> <s5hobzllubm.wl%tiwai@suse.de>
	<4E4E31A5.2090100@canonical.com> <s5hliup7emd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040808080001070501040605"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 5E1C824666
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 13:57:01 +0200 (CEST)
In-Reply-To: <s5hliup7emd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040808080001070501040605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Behold the third version of the patch.

On 08/19/2011 02:46 PM, Takashi Iwai wrote:
> At Fri, 19 Aug 2011 11:49:25 +0200,
> David Henningsson wrote:
>>
>> > From 8098c77a447a80d2860588387d18b3aa6d23b6bb Mon Sep 17 00:00:00 2001
>> From: David Henningsson<david.henningsson@canonical.com>
>> Date: Fri, 19 Aug 2011 11:47:07 +0200
>> Subject: [PATCH] alsa-plugins: Pulse: only underrun if no more data has been
>>   written
>>
>> If more data has already been written after the underrun, the underrun
>> will automatically end and therefore we should not report it or
>> restart the stream.
>>
>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>> ---
>>   configure.in      |    7 +++++++
>>   pulse/pcm_pulse.c |   28 ++++++++++++++++++++++++++--
>>   2 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/configure.in b/configure.in
>> index ccf59ba..f6886b1 100644
>> --- a/configure.in
>> +++ b/configure.in
>> @@ -31,8 +31,14 @@ AC_ARG_ENABLE([pulseaudio],
>>
>>   if test "x$enable_pulseaudio" != "xno"; then
>>     PKG_CHECK_MODULES(pulseaudio, [libpulse>= 0.9.11], [HAVE_PULSE=yes], [HAVE_PULSE=no])
>> +  PKG_CHECK_MODULES(pulseaudio_099, [libpulse>= 0.99.1],
>> +    [HAVE_PULSE_UNDERRUN_INDEX=yes], [HAVE_PULSE_UNDERRUN_INDEX=no])
>
> Hm, can we use PA_CHECK_VERSION() or such simply in the code?

Ok, good idea.

>
>> diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
>> index d6c6792..61f1c0c 100644
>> --- a/pulse/pcm_pulse.c
>> +++ b/pulse/pcm_pulse.c
>> @@ -26,6 +26,10 @@
>>   #include<alsa/asoundlib.h>
>>   #include<alsa/pcm_external.h>
>>
>> +#ifdef HAVE_CONFIG_H
>> +#include<config.h>
>> +#endif
>> +
>>   #include "pulse.h"
>>
>>   typedef struct snd_pcm_pulse {
>> @@ -39,9 +43,10 @@ typedef struct snd_pcm_pulse {
>>   	size_t last_size;
>>   	size_t ptr;
>>   	int underrun;
>> -	int handle_underrun;
>> +	int handle_underrun; /* can be 0=never, 1=always or 2,3=only if more data has not been written */
>
> I think it'd be simpler to introduce one more boolean variable.
> Otherwise the logic looks too complex than needed.

I've now done that. I don't know if it became simpler though.

>
>> @@ -594,7 +600,12 @@ static void stream_underrun_cb(pa_stream * p, void *userdata)
>>   	if (!pcm->p)
>>   		return;
>>
>> -	pcm->underrun = 1;
>> +	if (pcm->handle_underrun == 1
>> +#ifdef HAVE_PULSE_UNDERRUN_INDEX
>> +		|| pcm->written<= pa_stream_get_underflow_index(p)
>> +#endif
>> +	)
>> +		pcm->underrun = 1;
>
> A nicer way is to define a macro such as
>
> #ifdef HAVE_PULSE_UNDERRUN_INDEX
> static inline int handle_underrun_detect(snd_pcm_pulse_t *pcm, pa_stream *p)
> {
> 	return !pcm->handle_underrun_detect ||
> 		pcm->written<= pa_stream_get_underflow_index(p);
> }
> #else
> #define handle_underrun_detect(pcm, p)	1
> #endif
>
> Then
>
> 	if (pcm->handle_underrun&&  handle_underrun_detect(pcm, p))
> 		pcm->underrun = 1;

Ok, works for me.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040808080001070501040605
Content-Type: text/x-patch;
 name="0001-alsa-plugins-Pulse-only-underrun-if-no-more-data-has.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alsa-plugins-Pulse-only-underrun-if-no-more-data-has.pa";
 filename*1="tch"

>From a57884821509b373ef3acd82f73b719d8d2f6e23 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 23 Aug 2011 13:42:33 +0200
Subject: [PATCH] alsa-plugins: Pulse: only underrun if no more data has been
 written

If more data has already been written after the underrun, the underrun
will automatically end and therefore we should not report it or
restart the stream.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 pulse/pcm_pulse.c |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index d6c6792..92f4777 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -40,8 +40,10 @@ typedef struct snd_pcm_pulse {
 	size_t ptr;
 	int underrun;
 	int handle_underrun;
+	int handle_underrun_detect;
 
 	size_t offset;
+	int64_t written;
 
 	pa_stream *stream;
 
@@ -460,6 +462,7 @@ static snd_pcm_sframes_t pulse_write(snd_pcm_ioplug_t * io,
 
 	/* Make sure the buffer pointer is in sync */
 	pcm->last_size -= writebytes;
+	pcm->written += writebytes;
 	ret = update_ptr(pcm);
 	if (ret < 0)
 		goto finish;
@@ -585,6 +588,23 @@ static void stream_request_cb(pa_stream * p, size_t length, void *userdata)
 	update_active(pcm);
 }
 
+#if defined(PA_CHECK_VERSION) && PA_CHECK_VERSION(0,99,0)
+
+#define has_underrun_detect 1
+
+static inline int do_underrun_detect(snd_pcm_pulse_t *pcm, pa_stream *p)
+{
+	return pcm->handle_underrun_detect &&
+		pcm->written <= pa_stream_get_underflow_index(p);
+}
+
+#else
+
+#define has_underrun_detect 0
+#define do_underrun_detect(pcm, p) 0
+
+#endif
+
 static void stream_underrun_cb(pa_stream * p, void *userdata)
 {
 	snd_pcm_pulse_t *pcm = userdata;
@@ -594,7 +614,8 @@ static void stream_underrun_cb(pa_stream * p, void *userdata)
 	if (!pcm->p)
 		return;
 
-	pcm->underrun = 1;
+	if (pcm->handle_underrun || do_underrun_detect(pcm, p))
+		pcm->underrun = 1;
 }
 
 static void stream_latency_cb(pa_stream *p, void *userdata) {
@@ -697,7 +718,7 @@ static int pulse_prepare(snd_pcm_ioplug_t * io)
 	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
 		pa_stream_set_write_callback(pcm->stream,
 					     stream_request_cb, pcm);
-		if (pcm->handle_underrun)
+		if (pcm->handle_underrun_detect || pcm->handle_underrun)
 			pa_stream_set_underflow_callback(pcm->stream,
 							 stream_underrun_cb, pcm);
 		r = pa_stream_connect_playback(pcm->stream, pcm->device,
@@ -739,6 +760,7 @@ static int pulse_prepare(snd_pcm_ioplug_t * io)
 
 	pcm->offset = 0;
 	pcm->underrun = 0;
+	pcm->written = 0;
 
 	/* Reset fake ringbuffer */
 	pcm->last_size = 0;
@@ -984,6 +1006,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(pulse)
 	const char *device = NULL;
 	const char *fallback_name = NULL;
 	int handle_underrun = 0;
+	int handle_underrun_detect = 1;
 	int err;
 	snd_pcm_pulse_t *pcm;
 
@@ -1017,6 +1040,14 @@ SND_PCM_PLUGIN_DEFINE_FUNC(pulse)
 			handle_underrun = err;
 			continue;
 		}
+		if (strcmp(id, "handle_underrun_detect") == 0) {
+			if ((err = snd_config_get_bool(n)) < 0) {
+				SNDERR("Invalid value for %s", id);
+				return -EINVAL;
+			}
+			handle_underrun_detect = err;
+			continue;
+		}
 		if (strcmp(id, "fallback") == 0) {
 			if (snd_config_get_string(n, &fallback_name) < 0) {
 				SNDERR("Invalid value for %s", id);
@@ -1051,6 +1082,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(pulse)
 	}
 
 	pcm->handle_underrun = handle_underrun;
+	pcm->handle_underrun_detect = has_underrun_detect && handle_underrun_detect;
 
 	err = pulse_connect(pcm->p, server, fallback_name != NULL);
 	if (err < 0)
-- 
1.7.5.4


--------------040808080001070501040605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040808080001070501040605--
