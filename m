From: Eliot Blennerhassett <linux@audioscience.com>
Subject: driver silence callback
Date: Thu, 24 Mar 2011 13:32:13 +1300
Message-ID: <4D8A910D.6030604@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 9787D103948
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 01:32:22 +0100 (CET)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LIJ00BX5DHPJF50@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 24 Mar 2011 13:32:14 +1300 (NZDT)
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

Greetings,

Is the driver's silence callback meant to be able to *overwrite* some
part of the audio buffer that has already been written e.g. via the
playback *copy* callback?

In the case of my (older) hardware, once audio has been written via the
copy callback, it is gone (into a fifo), there is no way to overwrite
with silence.

The asihpi silence call back will _append_ a period of silence to the
already written audio queue.  I'm wondering if this is wrong?

Perhaps I should not have a silence callback at all?

I'm looking at the case in pcm_lib.c snd_pcm_playback_silence() where
"when runtime->silence_size >= runtime->boundary - fill processed area
with silence immediately"

My reference for silence callback.
http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch11s02.html

regards

Eliot
