From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: io plugin: polling on unix socket,
	socket buffer sizes ?
Date: Tue, 22 Dec 2009 13:02:26 +0100
Message-ID: <4B30B552.8030903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id C68F424429
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 13:02:38 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by netfinity.tbmn.org (Postfix) with ESMTP id 4B98F4BEE9
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 13:02:35 +0100 (CET)
Received: from netfinity.tbmn.org ([127.0.0.1])
	by localhost (netfinity.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JR3J+E8i4A-7 for <alsa-devel@alsa-project.org>;
	Tue, 22 Dec 2009 13:02:35 +0100 (CET)
Received: from [128.131.254.101] (v254-101.vps.tuwien.ac.at [128.131.254.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by netfinity.tbmn.org (Postfix) with ESMTPSA id C9AB74BE05
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 13:02:33 +0100 (CET)
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

Hi,

I'm currently writing an alsa io plugin that should exchange PCM samples
with another piece of software over a unix socket.
More precisely exactly 160 PCM samples with 16bit each should be
exchanged at a time.

AFAIK the alsa plugin framework works by utilizing poll().
Thus if the plugin is used for playback it would use POLLOUT on the
socket to see if the next chunk of data can be written to the socket
without blocking.

By reading quite a lot of alsa code (including pcm_bluetooth.c from
bluez) it seems that I need to set the socket buffer size to a value
small enough, right ?

Thus if I would like to send one period consisting of 160 samples (with
16bits each) at a time, I would need to set the unix send buffer size to
320 bytes.

This way some kind of handshaking between my application and the alsa
plugin would be established:
Each time the application reads a full period of data from the socket,
the alsa plugin will start to send the next period as poll() will return
the POLLOUT event.
(Thus the transfer callback function would be called in the plugin code.)

Is this correct so far ?


To test the behavior I wrote two small code snippets:

One is unix socket reader that reads a chunk of 10 bytes at a time and
then sleeps for 10 seconds.
The socket recv buffer size SO_RCVBUF has been set to 10 bytes with
setsockopt().

The other snippet is the unix socket writer:
It sets the socket send buffer size SO_SNDBUF to 10 bytes so that after
writing 10 bytes to the socket, poll with POLLOUT would block until the
other end (the reader) reads some bytes and the send buffer is drained.
The reader polls on the socket with a timeout of 1 sec and in case poll
returns the POLLOUT event, it writes a chunk of 10 bytes to the socket.


With these small code snippets I would expect the following behavior:
