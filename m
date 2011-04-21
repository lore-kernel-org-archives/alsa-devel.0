From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Alsa-plugins: Pulse: Fix snd_pcm_avail
 returning 0 in some cases
Date: Thu, 21 Apr 2011 15:22:18 +0200
Message-ID: <4DB02F8A.4040001@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090807090806050001010504"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 7499E1038E4
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Apr 2011 15:22:20 +0200 (CEST)
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
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, Maarten Lankhorst <m.b.lankhorst@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090807090806050001010504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Due to a round-off error, snd_pcm_avail could in some cases
return 0 even though more data could be written to the stream.

This was discovered by Maarten Lankhorst [1], and there is also a test 
program available that triggers this error [2].

[1] 
https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-April/009935.html

[2] 
https://tango.0pointer.de/pipermail/pulseaudio-discuss/attachments/20110420/3c852d6e/attachment.c


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------090807090806050001010504
Content-Type: text/x-patch;
 name="0001-Pulse-Fix-snd_pcm_avail-returning-0-in-some-cases.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Pulse-Fix-snd_pcm_avail-returning-0-in-some-cases.patch"

>From 73ff6f83e1e4c53181e1794bf2cec3baee7c81b7 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 21 Apr 2011 15:10:19 +0200
Subject: [PATCH] Pulse: Fix snd_pcm_avail returning 0 in some cases

Due to a round-off error, snd_pcm_avail could in some cases
return 0 even though more data could be written to the stream.

Reported-by: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 pulse/pcm_pulse.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index 2df0a80..9105d4d 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -92,8 +92,8 @@ static int update_ptr(snd_pcm_pulse_t *pcm)
 		size -= pcm->offset;
 
 	/* Prevent accidental overrun of the fake ringbuffer */
-	if (size >= pcm->buffer_attr.tlength)
-		size = pcm->buffer_attr.tlength-1;
+	if (size > pcm->buffer_attr.tlength - pcm->frame_size)
+		size = pcm->buffer_attr.tlength - pcm->frame_size;
 
 	if (size > pcm->last_size) {
 		pcm->ptr += size - pcm->last_size;
-- 
1.7.4.1


--------------090807090806050001010504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090807090806050001010504--
