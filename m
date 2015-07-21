From: Martin Geier <martin.geier@streamunlimited.com>
Subject: snd_pcm_set_params faild on set_buffer_time_near and
	set_period_time_near
Date: Tue, 21 Jul 2015 10:52:01 +0200
Message-ID: <55AE0831.2010206@streamunlimited.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030209030708030608050507"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bsmtp.bon.at (bsmtp8.bon.at [213.33.87.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 481442617B5
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 10:52:02 +0200 (CEST)
Received: from [192.168.1.198] (81.89.61.168.vnet.sk [81.89.61.168])
 by bsmtp.bon.at (Postfix) with ESMTPSA id 3mbDFF6xpHz5tlR
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 10:52:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030209030708030608050507
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hallo,

I tried to configure alsa device with snd_pcm_set_params function, 
requested
parameters was:
channel 2, rate: 22050, soft_resample: 1, latency: 50000

Function snd_pcm_hw_params_set_buffer_time_near and 
snd_pcm_hw_param_set_near
is called with:
min: 50000, max: 50000, mindir: 0, maxdir: -1

and input params was:

ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 22050
PERIOD_TIME: (362 743039)
PERIOD_SIZE: [8 16384]
PERIOD_BYTES: [32 65536]
PERIODS: [2 19]
BUFFER_TIME: (725 1486078)
BUFFER_SIZE: [16 32768]
BUFFER_BYTES: [64 131072]
TICK_TIME: ALL

unfortunately, this function fails, on function snd_pcm_hw_param_set_first:

ALSA ERROR hw_params: set_near (BUFFER_TIME)
            value = 50000 : Invalid argument
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 22050
PERIOD_TIME: (4580 5533)
PERIOD_SIZE: NONE
PERIOD_BYTES: [404 488]
PERIODS: 10
BUFFER_TIME: (50022 50023)
BUFFER_SIZE: 1103
BUFFER_BYTES: 4412
TICK_TIME: ALL

This shouldn't be problem because in snd_pcm_set_params is
snd_pcm_hw_params_set_period_time_near called.
This function should be called with same params as 
snd_pcm_hw_params_set_buffer_time_near
but the input params are:

snd_pcm_hw_param_set_near: min: 12500, max: 12500, mindir: 0, maxdir: -1
hw_params: snd_pcm_hw_param_set_near (PERIOD_TIME)
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 22050
PERIOD_TIME: (4580 5533)
PERIOD_SIZE: NONE
PERIOD_BYTES: [404 488]
PERIODS: 10
BUFFER_TIME: (50022 50023)
BUFFER_SIZE: 1103
BUFFER_BYTES: 4412
TICK_TIME: ALL

because in snd_pcm_hw_param_set_near is

if (last)
     err = snd_pcm_hw_param_set_last(pcm, params, var, val, dir);
else
     err = snd_pcm_hw_param_set_first(pcm, params, var, val, dir);
if (err < 0)
     dump_hw_params(params, "set_near", var, *val, err);
return err;

and in error part is only debug output and not restore original parameters.

Environment:
alsa-lib 1.0.27.1
TI AM335x soc

Simple fix is attached, but I am not sure if it is correct.

BR
Martin Geier
-- 
*StreamUnlimited*
High Tech Campus Vienna, Gutheil-Schoder-Gasse 10, A-1102 Vienna, Austria
Levocska 9, 851 01 Bratislava, Slovakia
Email: martin.geier@streamunlimited.com
www.streamunlimited.com

--------------030209030708030608050507
Content-Type: text/x-patch;
 name="0001-patch-restore-params-if-snd_pcm_hw_param_set_near-met.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-patch-restore-params-if-snd_pcm_hw_param_set_near-met.p";
 filename*1="atch"

>From 6a31c2f854b255b407ce2d52d233db00588d2e40 Mon Sep 17 00:00:00 2001
From: Martin Geier <martin.geier@streamunlimited.com>
Date: Mon, 20 Jul 2015 08:59:54 +0200
Subject: [PATCH] restore params if snd_pcm_hw_param_set_near method failed

Signed-off-by: Martin Geier <martin.geier@streamunlimited.com>
---
 pcm_params.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_params.c b/src/pcm/pcm_params.c
index 0b66e8c..57d98d8 100644
--- a/src/pcm/pcm_params.c
+++ b/src/pcm/pcm_params.c
@@ -872,8 +872,10 @@ int snd_pcm_hw_param_set_near(snd_pcm_t *pcm, snd_pcm_hw_params_t *params,
 		err = snd_pcm_hw_param_set_last(pcm, params, var, val, dir);
 	else
 		err = snd_pcm_hw_param_set_first(pcm, params, var, val, dir);
-	if (err < 0)
+	if (err < 0) {
 		dump_hw_params(params, "set_near", var, *val, err);
+		*params = save;
+	}
 	return err;
 }
 
-- 
1.9.1


--------------030209030708030608050507
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030209030708030608050507--
