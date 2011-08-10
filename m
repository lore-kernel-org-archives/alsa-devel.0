From: ashwanik <ashwani.kumar@freesystems.biz>
Subject: Most likely this is a bug in the ALSA driver
 'snd_usb_audio'. Please report this issue to the ALSA developers.
Date: Wed, 10 Aug 2011 15:54:19 +0530
Message-ID: <4E425C53.8010002@freesystems.biz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070200020501030809060001"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.freesystems.biz (unknown [124.30.7.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C6F12461C
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 12:24:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.freesystems.biz (Postfix) with ESMTP id D0C972162EF
	for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2011 15:51:25 +0530 (IST)
Received: from mail.freesystems.biz ([127.0.0.1])
	by localhost (mail.freesystems.biz [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id 02bNgrnoxAT0 for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 15:51:18 +0530 (IST)
Received: from [192.168.1.4] (localhost [127.0.0.1])
	by mail.freesystems.biz (Postfix) with ESMTP id EB48D2162D0
	for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2011 15:51:11 +0530 (IST)
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070200020501030809060001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I am using USB mic on omap4 board(panda). When I am trying to use  
"gst-launch-0.10 pulsesrc ! pulsesink" pipeline, getting 1-2 sec audio 
delay and following error messages:

E: alsa-source.c: ALSA woke us up to read new data from the device, but 
there was actually nothing to read!
E: alsa-source.c: Most likely this is a bug in the ALSA driver 
'snd_usb_audio'. Please report this issue to the ALSA developers.
E: alsa-source.c: We were woken up with POLLIN set -- however a 
subsequent snd_pcm_avail() returned 0 or another value < min_avail.


I am attaching the complete log.

please find pointers.





Regards,
Ashwani

--------------070200020501030809060001
Content-Type: text/plain;
 name="palog_pipelinerun"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="palog_pipelinerun"

I: client.c: Created 5 "Native client (UNIX socket client)"
I: protocol-native.c: Got credentials: uid=1000 gid=1000 success=1
I: client.c: Created 6 "Native client (UNIX socket client)"
I: protocol-native.c: Got credentials: uid=1000 gid=1000 success=1
I: client.c: Freed 6 "gst-launch-0.10"
I: protocol-native.c: Connection died.
I: client.c: Created 7 "Native client (UNIX socket client)"
I: protocol-native.c: Got credentials: uid=1000 gid=1000 success=1


I: resampler.c: Forcing resampler 'copy', because of fixed, identical sample rates.
I: remap.c: Using mono to stereo remapping
I: resampler.c: Using resampler 'copy'
I: resampler.c: Using s16le as working format.


I: source-output.c: Created output 1 "Record Stream" on alsa_input.hw_1_0 with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
I: source-output.c:     media.name = "Record Stream"
I: source-output.c:     application.name = "gst-launch-0.10"
I: source-output.c:     native-protocol.peer = "UNIX socket client"
I: source-output.c:     native-protocol.version = "22"
I: source-output.c:     application.process.id = "1599"
I: source-output.c:     application.process.user = "vu"
I: source-output.c:     application.process.host = "vu-desktop"
I: source-output.c:     application.process.binary = "gst-launch-0.10"
I: source-output.c:     application.language = "en_IN"
I: source-output.c:     window.x11.display = ":0.0"
I: source-output.c:     application.process.machine_id = "9542ce26af2176ff98c2a74d00000006"
I: source-output.c:     application.process.session_id = "9542ce26af2176ff98c2a74d00000006-1312965529.337216-2022292295"
I: source-output.c:     module-stream-restore.id = "source-output-by-application-name:gst-launch-0.10"
I: protocol-native.c: Final latency 199.88 ms = 99.93 ms + 99.95 ms


E: alsa-source.c: ALSA woke us up to read new data from the device, but there was actually nothing to read!
E: alsa-source.c: Most likely this is a bug in the ALSA driver 'snd_usb_audio'. Please report this issue to the ALSA developers.
E: alsa-source.c: We were woken up with POLLIN set -- however a subsequent snd_pcm_avail() returned 0 or another value < min_avail.


I: module-stream-restore.c: Restoring device for stream sink-input-by-application-name:gst-launch-0.10.
I: module-stream-restore.c: Restoring mute state for sink input sink-input-by-application-name:gst-launch-0.10.
I: alsa-sink.c: Trying resume...
I: alsa-sink.c: Resumed successfully...
I: alsa-sink.c: Starting playback.
I: resampler.c: Using resampler 'speex-float-3'
I: resampler.c: Using float32le as working format.
I: resampler.c: Choosing speex quality setting 3.

I: sink-input.c: Created input 0 "Playback Stream" on alsa_output.plughw_0_7 with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
I: sink-input.c:     media.name = "Playback Stream"
I: sink-input.c:     application.name = "gst-launch-0.10"
I: sink-input.c:     native-protocol.peer = "UNIX socket client"
I: sink-input.c:     native-protocol.version = "22"
I: sink-input.c:     application.process.id = "1599"
I: sink-input.c:     application.process.user = "vu"
I: sink-input.c:     application.process.host = "vu-desktop"
I: sink-input.c:     application.process.binary = "gst-launch-0.10"
I: sink-input.c:     application.language = "en_IN"
I: sink-input.c:     window.x11.display = ":0.0"
I: sink-input.c:     application.process.machine_id = "9542ce26af2176ff98c2a74d00000006"
I: sink-input.c:     application.process.session_id = "9542ce26af2176ff98c2a74d00000006-1312965529.337216-2022292295"
I: sink-input.c:     module-stream-restore.id = "sink-input-by-application-name:gst-launch-0.10"


I: protocol-native.c: Requested tlength=200.00 ms, minreq=10.00 ms
I: protocol-native.c: Final latency 220.00 ms = 100.00 ms + 2*10.00 ms + 100.00 ms


E: alsa-sink.c: ALSA woke us up to write new data to the device, but there was actually nothing to write!
E: alsa-sink.c: Most likely this is a bug in the ALSA driver '(null)'. Please report this issue to the ALSA developers.
E: alsa-sink.c: We were woken up with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or another value < min_avail.


--------------070200020501030809060001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070200020501030809060001--
