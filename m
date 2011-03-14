From: Magnus Olsson <magnus.olsson@axis.com>
Subject: Dsnoop-plugin buffer sizes
Date: Mon, 14 Mar 2011 10:58:33 +0100
Message-ID: <A612847CFE53224C91B23E3A5B48BAC749EE00F801@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 2682610380E
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 10:58:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id A4E0711EC0
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 10:58:37 +0100 (CET)
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Qm6afplBXq-g for <alsa-devel@alsa-project.org>;
	Mon, 14 Mar 2011 10:58:36 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by ra.se.axis.com (Postfix) with ESMTP id 43DBF11EBF
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 10:58:35 +0100 (CET)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by thoth.se.axis.com (Postfix) with ESMTP id 5496A3417F
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 10:58:35 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm having issues with garbage data in my audio stream, which I believe is caused by incorrect buffer sizes somewhere in the audio pipeline. The garbage occurs periodically and is always constant in length. This problem only triggers when I use the dsnoo-plugin. If running directly towards the device, the audio stream is fine (no garbage). I've not tested if this occurs with any other plugin.

I'm using Dsnoop to capture a mono stream from a stereo device using arecord,
arecord -v -r 16000 -c1 -Daudiosource0 -fS16_LE /tmp/in.wav
(where audiosource0 is my dsnoop-device, bound to channel 0)

The verbose info from arecord shows me that ALSA has correctly created the Dsnoop device, with a "buffer_size" of 8000. It also shows that it has opened my Hardware device in MMAP-mode, with a "buffer_size" of 8192.

Here comes the kicker: The length of the garbage seen in my audio stream is always equal to the difference between the  two buffer sizes. So in the above case, I'm seeing 8000 valid samples, followed by 192 "garbage" samples.

Furthermore, I've added debugprints to the PCM driver hw_params() function, and in the above configuration, and it shows that the PCM is asked to allocate 4 periods of 8000 bytes each, NOT 8192 bytes as one would expect for the Hardware device.

I added some poisoning to the pre-allocated PCM buffer, and it clearly shows that the garbage comes from ALSA reading data from places in the buffer it has not allocated: ALSA thinks the ring buffer contains periods of size 8192, but the PCM driver is only asked to alloc size 8000.

Here comes the second kicker: I originally noticed this issue as I was adjusting the periods_min parameter of the PCM driver (PCM hardware has some special needs). It seems like for some periods_min, ALSA will "default" to a buffer_size so that the buffer_size of my Dsnoop device AND my hardware device is identical. In this case, everything works. For example, if I set period_min to 4, ALSA will default to Dsnoop buffer_size 8000 and Hardware buffer_size 8192. If I set periods_min to 3, ALSA will instead default Dsnoop buffer_size to 6000 and Hardware buffer_size to 6000. In the latter case, no garbage appears, since there is no buffer size diff.

Now my question is if it's possible that I have some misconfiguration and/or missing constraint in my system? .. or maybe this is just a bug. My first thought was that 8000 was rounded to the nearest page 8192, however, for periods_min=3, both buffers stay at 6000 which is not a page multiple.

Best regards,
Magnus
