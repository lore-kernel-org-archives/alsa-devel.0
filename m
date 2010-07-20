From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: underruns and POLLERR when copying audio frames
Date: Tue, 20 Jul 2010 13:00:41 +0200
Message-ID: <4C4581D9.8020309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 303541038DB
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 13:01:31 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by keymachine.tbmn.org (Postfix) with ESMTP id 5E1558ACC15
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 13:01:30 +0200 (CEST)
Received: from keymachine.tbmn.org ([127.0.0.1])
	by localhost (keymachine.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2rCLt3FIZXM7 for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 13:01:29 +0200 (CEST)
Received: from [192.168.1.132] (85-127-52-80.dynamic.xdsl-line.inode.at
	[85.127.52.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by keymachine.tbmn.org (Postfix) with ESMTPSA id 08DA58ACC14
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 13:01:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have some code that basically captures audio frames from one device
and then writes it for playback to another device.

Ideally mmapped IO could be used for such a task, but in my application
this is not possible at the moment, as at least one of the audio devices
does not support it.


In my application copying audio frames works with a poll() based approach:

If the capture device is ready for reading, a new audio frame is being read.
And if there is a new captured frame available AND the playback device
is ready, then it is written to the playback device.

So far so good, the approach works.
However, it doesn't take long until poll() on the playback device
returns POLLERR since an underrun has occurred.
If I just ignore POLLERR, then the next write operation to the playback
device fails and I need to snd_pcm_recover().

My question is how to avoid these underruns.
Basically I have two ideas:

1. The avail_min parameter specifies when the playback device should
start to play buffered frames back.
Hence if for example avail_min=160, then the playback device would wait
until at least 160 frames have been written to the playback device (i.e.
to the internal buffer) and then start with playing back these frames.
My idea would be to just increment avail_min to something bigger, so
that more frames are being buffered before playback starts.
Would this work ?

2. Another idea would be to do some buffering on my own in the application.
Thus I would first capture a number of frames and write them to a FIFO
buffer.
Once the buffer has been filled with enough frames, I would start to
write them to the playback device.
Therefore while the FIFO is being drained on the one side (playback), it
is also refilled on the other side (capture).


* So, which of these ideas do you think is better in terms of avoiding
underruns ?

To me it seems that both solutions would lead to the same results.
Yet just setting avail_min to something higher seems to be the easier
solution as it does not require me to implement a buffering solution on
my own.

cheers,
stefan
